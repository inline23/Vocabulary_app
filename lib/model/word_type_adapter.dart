import 'package:hive/hive.dart';
import 'package:vocabulary_app/model/word_model.dart';

class WordTypeAdapter extends TypeAdapter<WordModel> {
  @override
  WordModel read(BinaryReader reader) {
    return WordModel(
      indexAtDatabase: reader.readInt(),
      text: reader.readString(),
      isArabic: reader.readBool(),
      colorCode: reader.readInt(),
      arabicSimilarWords: reader.readStringList(),
      englishSimilarWords: reader.readStringList(),
      arabicExamples: reader.readStringList(),
      englishExamples: reader.readStringList(),
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, WordModel word) {
    writer.writeInt(word.indexAtDatabase);
    writer.writeString(word.text);
    writer.writeBool(word.isArabic);
    writer.writeInt(word.colorCode);
    writer.writeStringList(word.arabicSimilarWords);
    writer.writeStringList(word.englishSimilarWords);
    writer.writeStringList(word.arabicExamples);
    writer.writeStringList(word.englishExamples);
  }
}
