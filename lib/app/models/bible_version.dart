import 'package:nylo_framework/nylo_framework.dart';

class BibleVersion extends Model {
  String id;
  String name;
  String language;
  String coverImage;
  bool isReading;
  String? lastReadChapter;
  int? lastReadVerse;

  static StorageKey key = "bible_verse";

  BibleVersion({
    required this.id,
    required this.name,
    required this.language,
    required this.coverImage,
    required this.isReading,
    this.lastReadChapter,
    this.lastReadVerse,
  }) : super(key: key);

  BibleVersion.fromJson(Map<String, dynamic> data)
      : id = data['id'] ?? "",
        name = data['name'] ?? "",
        language = data['language'] ?? "",
        coverImage = data['coverImage'] ?? "",
        isReading = data['isReading'] ?? false,
        lastReadChapter = data['lastReadChapter'],
        lastReadVerse = data['lastReadVerse'];

  @override
  toJson() {
    return {
      'id': id,
      'name': name,
      'language': language,
      'coverImage': coverImage,
      'isReading': isReading,
      'lastReadChapter': lastReadChapter,
      'lastReadVerse': lastReadVerse,
    };
  }

  // Helper method to save the current reading position
  Future<bool> saveReadingPosition(String chapter, int verse) async {
    lastReadChapter = chapter;
    lastReadVerse = verse;
    isReading = true;
    return await save();
  }

  // Helper method to get all saved Bible versions
  static Future<List<BibleVersion>> getAllVersions() async {
    try {
      final data = await NyStorage.read("bible_verse");
      if (data != null && data is List) {
        return data
            .map((item) => BibleVersion.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Helper method to get a specific Bible version
  static Future<BibleVersion?> getById(String id) async {
    final versions = await getAllVersions();
    try {
      return versions.firstWhere((v) => v.id == id);
    } catch (e) {
      return null;
    }
  }

  // Save this version to storage
}
