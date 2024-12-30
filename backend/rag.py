import os
import time
import pinecone
import cohere
import re
import pdfplumber
import arabic_reshaper
from bidi.algorithm import get_display
from sentence_transformers import CrossEncoder
from transformers import AutoTokenizer
from langchain_huggingface import HuggingFaceEmbeddings


# ==========================
# Configuration
# ==========================


# PINECONE_API_KEY = ""
# COHERE_API_KEY = ""
# HF_AUTH = os.getenv("HF_TOKEN", "")
EMBED_MODEL_ID = 'sentence-transformers/LaBSE'
PINECONE_ENV = "us-east-1"
MODEL_ID = "CohereForAI/c4ai-command-r7b-12-2024"
# ==========================
# Initialize Pinecone and Cohere
# ==========================
def initialize_pinecone(index_name="qa-retrieval-2"):
    pc = pinecone.Pinecone(api_key=PINECONE_API_KEY)
    spec = pinecone.ServerlessSpec(cloud="aws", region=PINECONE_ENV)

    if index_name not in pc.list_indexes().names():
        pc.create_index(
            index_name,
            dimension=768,  # Assuming LaBSE embedding dimension
            metric='cosine',
            spec=spec
        )
        while not pc.describe_index(index_name).status['ready']:
            time.sleep(1)

    return pc.Index(index_name)

def initialize_cohere():
    return cohere.ClientV2(api_key=COHERE_API_KEY)

# ==========================
# Initialize Models and Tokenizer
# ==========================
def initialize_models():
    tokenizer = AutoTokenizer.from_pretrained(MODEL_ID, token=HF_AUTH)
    embed_model = HuggingFaceEmbeddings(model_name=EMBED_MODEL_ID)
    reranker = CrossEncoder('cross-encoder/mmarco-mMiniLMv2-L12-H384-v1')
    return tokenizer, embed_model, reranker

# ==========================
# Re-ranking Function
# ==========================
def rerank_documents(query, documents, reranker):
    scores = reranker.predict([(query, doc.page_content) for doc in documents])
    sorted_docs = [doc for _, doc in sorted(zip(scores, documents), reverse=True)]
    return sorted_docs

# ==========================
# Answer Generation Function
# ==========================
def get_answer_with_sources(query, chain, tokenizer, co, max_token_length=2048):
    try:
        # Retrieve and re-rank documents
        retrieved_docs = chain.invoke(query)

        # Prepare context from retrieved documents
        context = "\n".join([doc.page_content for doc in retrieved_docs])
        context_tokens = tokenizer.encode(context, add_special_tokens=False)
        if len(context_tokens) > max_token_length:
            context_tokens = context_tokens[:max_token_length]
            context = tokenizer.decode(context_tokens)

        # Collect sources
        sources = "\n".join([doc.metadata.get("source", "Unknown Source") for doc in retrieved_docs])

        # Define system message for Cohere chat
        system_message = (
            "You are an expert assistant. Provide detailed, clear, and explanatory answers "
            "based on the provided context. Ensure the response is comprehensive and addresses "
            "the query thoroughly. Use examples or analogies if necessary to make the answer more "
            "understandable and engaging."
        )
        messages = [
            {"role": "system", "content": system_message},
            {"role": "user", "content": f"Context: {context}\nQuestion: {query}\nAnswer:"},
        ]

        # Call Cohere chat API
        res = co.chat(
            model="command-r-plus-08-2024",
            messages=messages,
        )

        # Extract the generated answer
        answer = res.message.content[0].text

        # Format the final response with sources
        final_response = f"{answer}\n\n**Sources:**\n{sources}"
        return final_response

    except Exception as e:
        return f"An error occurred while generating the answer: {e}"


def get_general_answer(query, chain, co):
    try:
        # Retrieve and re-rank documents (removing context preparation)
        retrieved_docs = chain.invoke(query)

        # Define system message for Cohere chat
        system_message = (
            "You are an expert assistant. Provide detailed, clear, and explanatory answers "
            "to the user's query. Ensure the response is comprehensive and addresses "
            "the query thoroughly. Use examples or analogies if necessary to make the answer more "
            "understandable and engaging."
        )
        messages = [
            {"role": "system", "content": system_message},
            {"role": "user", "content": f"Question: {query}\nAnswer:"},
        ]

        # Call Cohere chat API
        res = co.chat(
            model="command-r-plus-08-2024",
            messages=messages,
        )

        # Extract the generated answer
        answer = res.message.content[0].text

        # Return the final response without sources
        return answer

    except Exception as e:
        return f"An error occurred while generating the answer: {e}"

# ==========================
# PDF Processing Functions
# ==========================
def extract_pdf_text(file_path, remove_header_footer=True, header_lines=3, footer_lines=3):
    """
    Extract text from a PDF file and optionally remove header/footer lines.
    """
    try:
        with pdfplumber.open(file_path) as pdf:
            all_text = "\n".join(page.extract_text() for page in pdf.pages if page.extract_text())

        if remove_header_footer:
            lines = all_text.splitlines()
            if len(lines) > (header_lines + footer_lines):
                lines = lines[header_lines:-footer_lines]
            else:
                lines = []
            all_text = "\n".join(lines)

        reshaped_text = arabic_reshaper.reshape(all_text)
        bidi_text = get_display(reshaped_text)

        chunks = [bidi_text]
        return chunks, [file_path] * len(chunks)

    except Exception as e:
        print(f"Error extracting text from {file_path}: {e}")
        return [], []

def split_text_into_chunks(text_list, tokenizer, max_tokens=2048, source="", min_chunk_length=100):
    """
    Split text into smaller chunks while handling short chunks and Arabic-specific issues.
    """
    chunks = []
    chunk_sources = []

    for text_item in text_list:
        sentences = re.split(r'(?<=[.!؟])\s+', text_item)

        current_chunk = ""
        current_token_count = 0

        for sentence in sentences:
            if not sentence.strip():
                continue

            sentence_tokens = tokenizer.encode(sentence, add_special_tokens=False)
            sentence_token_count = len(sentence_tokens)

            if current_token_count + sentence_token_count > max_tokens:
                if len(current_chunk.strip()) >= min_chunk_length:
                    chunks.append(current_chunk.strip())
                    chunk_sources.append(source)
                current_chunk = sentence
                current_token_count = sentence_token_count
            else:
                current_chunk += f" {sentence}".strip()
                current_token_count += sentence_token_count

        if len(current_chunk.strip()) >= min_chunk_length:
            chunks.append(current_chunk.strip())
            chunk_sources.append(source)

    combined_chunks = []
    combined_sources = []
    i = 0
    while i < len(chunks):
        if len(chunks[i]) >= min_chunk_length:
            combined_chunks.append(chunks[i])
            combined_sources.append(chunk_sources[i])
            i += 1
        else:
            if i + 1 < len(chunks):
                combined_text = f"{chunks[i]} {chunks[i+1]}".strip()
                combined_tokens = tokenizer.encode(combined_text, add_special_tokens=False)
                if len(combined_tokens) <= max_tokens:
                    combined_chunks.append(combined_text)
                    combined_sources.append(chunk_sources[i])
                    i += 2
                else:
                    combined_chunks.append(chunks[i])
                    combined_sources.append(chunk_sources[i])
                    i += 1
            else:
                combined_chunks.append(chunks[i])
                combined_sources.append(chunk_sources[i])
                i += 1

    return combined_chunks, combined_sources

def process_and_upsert_pdfs(file_paths, tokenizer, embed_model, index, batch_size=32, requests_per_second=5):
    """
    Process multiple PDF files, extract text, split into chunks, generate embeddings, and upsert into an index.
    """
    for file_path in file_paths:
        try:
            print(f"Processing PDF: {file_path}")

            pdf_text, sources = extract_pdf_text(file_path)

            vectors = []
            start_time = time.time()
            processed_vectors = 0

            for idx, (text, source) in enumerate(zip(pdf_text, sources)):
                chunks, chunk_sources = split_text_into_chunks([text], tokenizer, max_tokens=2048, source=source)
                for chunk_idx, (chunk, chunk_source) in enumerate(zip(chunks, chunk_sources)):
                    embedding = embed_model.embed_query(chunk)

                    if embedding is None:
                        print(f"Skipping chunk {chunk_idx} in {file_path} due to failed embedding.")
                        continue

                    vector_id = f"{os.path.basename(file_path)}_chunk_{idx}_{chunk_idx}"
                    vector = {
                        "id": vector_id,
                        "values": embedding,
                        "metadata": {"content": chunk, "source": chunk_source}
                    }
                    vectors.append(vector)

                    if len(vectors) >= batch_size:
                        index.upsert(vectors)
                        print(f"Upserted batch of {len(vectors)} vectors from {file_path}.")
                        vectors = []

                        processed_vectors += batch_size
                        elapsed_time = time.time() - start_time
                        expected_time = processed_vectors / requests_per_second
                        if elapsed_time < expected_time:
                            time.sleep(expected_time - elapsed_time)

            if vectors:
                index.upsert(vectors)
                print(f"Upserted final batch of {len(vectors)} vectors from {file_path}.")

        except Exception as e:
            print(f"Error processing and upserting PDF {file_path}: {e}")
