class WordModel {
  final int indexAtDatabase;
  final String text;
  final bool isArabic;
  final int colorCode;
  final List<String> arabicSimilarWords;
  final List<String> englishSimilarWords;
  final List<String> arabicExamples;
  final List<String> englishExamples;

  WordModel({
    required this.indexAtDatabase,
    required this.text,
    required this.isArabic,
    required this.colorCode,
    this.arabicSimilarWords = const [],
    this.englishSimilarWords = const [],
    this.arabicExamples = const [],
    this.englishExamples = const [],
  });

  // i need this function when i want to delete word
  WordModel decremantIndexAtDatabase() {
    return WordModel(
      indexAtDatabase: indexAtDatabase-1,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicExamples: arabicExamples,
      englishExamples: englishExamples,
      arabicSimilarWords: arabicSimilarWords,
      englishSimilarWords: englishSimilarWords,
    );
  }

  WordModel deleteExample(int indexAtExamplesList, bool isExampleArabic) {
    List<String> newExamples = _initializeNewExamples(isExampleArabic);
    newExamples.removeAt(indexAtExamplesList);
    return _getWordAfterCheckWordExamples(newExamples, isExampleArabic);
  }

  WordModel addExample(String example, bool isExampleArabic) {
    List<String> newExamples = _initializeNewExamples(isExampleArabic);
    newExamples.add(example);
    return _getWordAfterCheckWordExamples(newExamples, isExampleArabic);
  }

  WordModel addSimilarWord(String similarWord, bool isArabicSimilarWord) {
    List<String> newSimilarWords = _initializeNewSimilarWords(
      isArabicSimilarWord,
    );
    newSimilarWords.add(similarWord);
    return _getWordAfterCheckSimilarWords(newSimilarWords, isArabicSimilarWord);
  }

  WordModel deleteSimilarWord(
    int indexAtSimilarWord,
    bool isArabicSimilarWord,
  ) {
    List<String> newSimilarWords = _initializeNewSimilarWords(
      isArabicSimilarWord,
    );
    newSimilarWords.removeAt(indexAtSimilarWord);
    return _getWordAfterCheckSimilarWords(newSimilarWords, isArabicSimilarWord);
  }

  // this func return the similarWords list depend on language isArabic or not
  List<String> _initializeNewSimilarWords(bool isArabicSimilarWord) {
    if (isArabicSimilarWord) {
      // list.from -> create new list and take values from anouther list Call By Value
      return List.from(arabicSimilarWords);
    } else {
      return List.from(englishSimilarWords);
    }
  }

  // this func return wordModel after update similarWords depend on laguage isArabic or not
  WordModel _getWordAfterCheckSimilarWords(
    List<String> newSimilarWords,
    bool isArabicSimilarWord,
  ) {
    return WordModel(
      indexAtDatabase: indexAtDatabase,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicExamples: arabicExamples,
      englishExamples: englishExamples,
      arabicSimilarWords:
          isArabicSimilarWord ? newSimilarWords : arabicSimilarWords,
      englishSimilarWords:
          !isArabicSimilarWord ? newSimilarWords : englishSimilarWords,
    );
  }

  List<String> _initializeNewExamples(bool isExampleArabic) {
    if (isExampleArabic) {
      return List.from(arabicExamples);
    }
    return List.from(englishExamples);
  }

  WordModel _getWordAfterCheckWordExamples(
    List<String> newExamples,
    isExampleArabic,
  ) {
    return WordModel(
      indexAtDatabase: indexAtDatabase,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicSimilarWords: arabicSimilarWords,
      englishSimilarWords: englishSimilarWords,
      arabicExamples: isExampleArabic ? newExamples : arabicExamples,
      englishExamples: !isExampleArabic ? newExamples : englishExamples,
    );
  }
}
