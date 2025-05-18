import 'package:nylo_framework/nylo_framework.dart';

class BibleVerse extends Model {
  int number;
  String text;
  static StorageKey key = "bible_verse";

  BibleVerse({required this.number, required this.text}) : super(key: key);

  BibleVerse.fromJson(Map<String, dynamic> data)
      : number = data['number'] ?? 0,
        text = data['text'] ?? "",
        super(key: key);

  @override
  toJson() {
    return {'number': number, 'text': text};
  }

  // Helper method to create a BibleVerse instance quickly
  static BibleVerse create(int number, String text) {
    return BibleVerse(number: number, text: text);
  }
}
