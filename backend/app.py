from flask import Flask, request, jsonify
from langchain_pinecone import PineconeVectorStore
from langchain_core.runnables import RunnableSequence
from rag import (
    get_answer_with_sources,
    get_general_answer,
    initialize_cohere,
    initialize_pinecone,
    initialize_models,
    rerank_documents,
    process_and_upsert_pdfs,
)
import os

# Initialize Flask app
app = Flask(__name__)

# ==========================
# Flask Routes
# ==========================

@app.route('/chat', methods=['POST'])
def chat():
    data = request.json
    query = data.get('query')
    
    if not query:
        return jsonify({'error': 'Query is required'}), 400

    try:
        response = get_answer_with_sources(query, chain, tokenizer, co)
        return jsonify({'response': response})
    except Exception as e:
        return jsonify({'error': str(e)}), 500


@app.route('/chat_with_pdf', methods=['POST'])
def chat_with_pdf():
    data = request.json
    query = data.get('query')
    
    if not query:
        return jsonify({'error': 'Query is required'}), 400

    try:
        index = initialize_pinecone(index_name='upload_files')
       
        # Initialize vector store and retriever
        vectorstore = PineconeVectorStore(index, embed_model, "content")
        retriever = vectorstore.as_retriever(search_kwargs={"k": 3})

        # Initialize chain
        query = 'ماهي المادة رقم 72'
        chain = RunnableSequence(
            retriever,
            lambda docs: rerank_documents(query, docs, reranker),
        )


        response = get_general_answer(query, chain, co)
        return jsonify({'response': response})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/chat_general', methods=['POST'])
def chat_general():
    data = request.json
    query = data.get('query')
    
    if not query:
        return jsonify({'error': 'Query is required'}), 400

    try:

        response = get_general_answer(query, chain, co)
        return jsonify({'response': response})
    except Exception as e:
        return jsonify({'error': str(e)}), 500


# ==========================
# Initialize Components
# ==========================

# Initialize Pinecone, Cohere, and models
index = initialize_pinecone()
co = initialize_cohere()
tokenizer, embed_model, reranker = initialize_models()

# Initialize vector store and retriever
vectorstore = PineconeVectorStore(index, embed_model, "content")
retriever = vectorstore.as_retriever(search_kwargs={"k": 1})

# Initialize chain
query = 'ماهي المادة رقم 72'
chain = RunnableSequence(
    retriever,
    lambda docs: rerank_documents(query, docs, reranker),
)



# ==========================
# Upload file 
# ==========================UPLOAD_FOLDER = 'uploads'
UPLOAD_FOLDER='data'
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

@app.route('/upload', methods=['POST'])
def upload_file():
    try:
        # Check if a file is included in the request
        if 'file' not in request.files:
            return jsonify({'error': 'No file part in the request'}), 400

        file = request.files['file']

        # Check if the file is empty
        if file.filename == '':
            return jsonify({'error': 'No file selected for uploading'}), 400

        # Save the file to the uploads folder
        file_path = os.path.join(UPLOAD_FOLDER, file.filename)
        file.save(file_path)

        # Process the file (Pinecone integration)
        try:
            index = initialize_pinecone(index_name='upload_files')
            process_and_upsert_pdfs([file_path], tokenizer, embed_model, index)
        except Exception as e:
            return jsonify({'error': f'Processing error: {e}'}), 500

        return jsonify({'message': 'File uploaded successfully', 'file_path': file_path}), 200
    except Exception as e:
        return jsonify({'error': f'Unexpected error: {e}'}), 500

# ==========================
# Run the Flask App
# ==========================

if __name__ == '__main__':
    # Disable tokenizer parallelism to avoid warnings
    os.environ["TOKENIZERS_PARALLELISM"] = "false"
    
    # Run the Flask app
    app.run(debug=True)