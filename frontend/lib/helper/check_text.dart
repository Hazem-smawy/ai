String detectLanguage(String text) {
  int arabicCount = 0;
  int englishCount = 0;

  for (int i = 0; i < text.length; i++) {
    int charCode = text.codeUnitAt(i);

    // Check if the character is Arabic
    if ((charCode >= 0x0600 && charCode <= 0x06FF) ||
        (charCode >= 0x0750 && charCode <= 0x077F)) {
      arabicCount++;
    }
    // Check if the character is English
    else if ((charCode >= 0x0041 && charCode <= 0x005A) ||
        (charCode >= 0x0061 && charCode <= 0x007A)) {
      englishCount++;
    }
  }

  if (arabicCount > englishCount) {
    return "ar";
  } else if (englishCount > arabicCount) {
    return "en";
  } else {
    return "mx";
  }
}
