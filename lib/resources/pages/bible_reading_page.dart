import 'package:flutter/material.dart';
import 'package:flutter_app/app/models/bible_version.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'dart:convert';

import '../../app/models/bible_verse.dart';

class BibleReadingPage extends NyStatefulWidget {
  static RouteView path = ("/bible/reading", (_) => BibleReadingPage());

  BibleReadingPage({super.key}) : super(child: () => _BibleReadingPageState());
}

class _BibleReadingPageState extends NyPage<BibleReadingPage> {
  BibleVersion? version;
  final List<String> books = [
    "Genesis",
    "Exodus",
    "Leviticus",
    "Numbers",
    "Deuteronomy",
    "Joshua",
    "Judges",
    "Ruth",
    "1 Samuel",
    "2 Samuel",
    "1 Kings",
    "2 Kings",
    "1 Chronicles",
    "2 Chronicles",
    "Ezra",
    "Nehemiah",
    "Esther",
    "Job",
    "Psalms",
    "Proverbs",
    "Ecclesiastes",
    "Song of Solomon",
    "Isaiah",
    "Jeremiah",
    "Lamentations",
    "Ezekiel",
    "Daniel",
    "Hosea",
    "Joel",
    "Amos",
    "Obadiah",
    "Jonah",
    "Micah",
    "Nahum",
    "Habakkuk",
    "Zephaniah",
    "Haggai",
    "Zechariah",
    "Malachi",
    "Matthew",
    "Mark",
    "Luke",
    "John",
    "Acts",
    "Romans",
    "1 Corinthians",
    "2 Corinthians",
    "Galatians",
    "Ephesians",
    "Philippians",
    "Colossians",
    "1 Thessalonians",
    "2 Thessalonians",
    "1 Timothy",
    "2 Timothy",
    "Titus",
    "Philemon",
    "Hebrews",
    "James",
    "1 Peter",
    "2 Peter",
    "1 John",
    "2 John",
    "3 John",
    "Jude",
    "Revelation"
  ];

  // Map of books to their chapter counts for more accurate chapter selection
  final Map<String, int> bookChapters = {
    "Genesis": 50,
    "Exodus": 40,
    "Leviticus": 27,
    "Numbers": 36,
    "Deuteronomy": 34,
    "Joshua": 24,
    "Judges": 21,
    "Ruth": 4,
    "1 Samuel": 31,
    "2 Samuel": 24,
    "1 Kings": 22,
    "2 Kings": 25,
    "1 Chronicles": 29,
    "2 Chronicles": 36,
    "Ezra": 10,
    "Nehemiah": 13,
    "Esther": 10,
    "Job": 42,
    "Psalms": 150,
    "Proverbs": 31,
    "Ecclesiastes": 12,
    "Song of Solomon": 8,
    "Isaiah": 66,
    "Jeremiah": 52,
    "Lamentations": 5,
    "Ezekiel": 48,
    "Daniel": 12,
    "Hosea": 14,
    "Joel": 3,
    "Amos": 9,
    "Obadiah": 1,
    "Jonah": 4,
    "Micah": 7,
    "Nahum": 3,
    "Habakkuk": 3,
    "Zephaniah": 3,
    "Haggai": 2,
    "Zechariah": 14,
    "Malachi": 4,
    "Matthew": 28,
    "Mark": 16,
    "Luke": 24,
    "John": 21,
    "Acts": 28,
    "Romans": 16,
    "1 Corinthians": 16,
    "2 Corinthians": 13,
    "Galatians": 6,
    "Ephesians": 6,
    "Philippians": 4,
    "Colossians": 4,
    "1 Thessalonians": 5,
    "2 Thessalonians": 3,
    "1 Timothy": 6,
    "2 Timothy": 4,
    "Titus": 3,
    "Philemon": 1,
    "Hebrews": 13,
    "James": 5,
    "1 Peter": 5,
    "2 Peter": 3,
    "1 John": 5,
    "2 John": 1,
    "3 John": 1,
    "Jude": 1,
    "Revelation": 22
  };

  String selectedBook = "John";
  int selectedChapter = 3;
  double fontSize = 16.0;
  List<BibleVerse> verses = [];

  @override
  get init => () async {
        // Get version from route data - CORRECTED FOR NYLO 6
        try {
          dynamic routeData = widget.data();
          if (routeData != null && routeData['version'] != null) {
            version = routeData['version'];

            // Load last reading location if available
            if (version!.isReading && version!.lastReadChapter != null) {
              // Parse book and chapter from last read
              List<String> parts = version!.lastReadChapter!.split(' ');
              if (parts.length > 1) {
                // Handle books with multi-part names like "1 Samuel"
                if (parts.length > 2) {
                  selectedBook = "${parts[0]} ${parts[1]}";
                  selectedChapter = int.parse(parts[2]);
                } else {
                  selectedBook = parts[0];
                  selectedChapter = int.parse(parts[1]);
                }
              }
            }
          } else {
            print("No Bible version provided in route data");
          }
        } catch (e) {
          print("Error loading Bible version: ${e.toString()}");
        }

        // Load font size preference
        try {
          final savedFontSize = await NyStorage.read("bible_font_size");
          if (savedFontSize != null) {
            fontSize = double.parse(savedFontSize.toString());
          }
        } catch (e) {
          print("Error loading font size: ${e.toString()}");
        }

        // Load Bible content
        await _loadBibleContent();
      };

  // Note: Load font size in init method instead of afterLoad
  // as afterLoad is a widget method, not a lifecycle method

  // Load Bible content
  Future<void> _loadBibleContent() async {
    // In a real app, you would load from API
    // First try to load from local storage
    // try {
    //   final localVerses = await BibleVerse.getVerses(selectedBook, selectedChapter);
    //   if (localVerses.isNotEmpty) {
    //     verses = localVerses;
    //     return;
    //   }
    // } catch (e) {
    //   logger.debug("No cached verses found: ${e.toString()}");
    // }

    // If not in local storage, fetch from API
    // try {
    //   final apiVerses = await api<BibleApi>((api) => api.getVerses(selectedBook, selectedChapter, version?.id ?? "kjv"));
    //   if (apiVerses != null) {
    //     await BibleVerse.saveVerses(selectedBook, selectedChapter, apiVerses);
    //     verses = apiVerses;
    //     return;
    //   }
    // } catch (e) {
    //   logger.error("API error: ${e.toString()}");
    // }

    // For now, using sample data with Nylo's delay helper
    await Future.delayed(Duration(milliseconds: 500));

    try {
      if (selectedBook == "John" && selectedChapter == 3) {
        verses = [
          BibleVerse(
              number: 1,
              text:
                  "There was a man of the Pharisees, named Nicodemus, a ruler of the Jews:"),
          BibleVerse(
              number: 2,
              text:
                  "The same came to Jesus by night, and said unto him, Rabbi, we know that thou art a teacher come from God: for no man can do these miracles that thou doest, except God be with him."),
          BibleVerse(
              number: 3,
              text:
                  "Jesus answered and said unto him, Verily, verily, I say unto thee, Except a man be born again, he cannot see the kingdom of God."),
          BibleVerse(
              number: 4,
              text:
                  "Nicodemus saith unto him, How can a man be born when he is old? can he enter the second time into his mother's womb, and be born?"),
          BibleVerse(
              number: 5,
              text:
                  "Jesus answered, Verily, verily, I say unto thee, Except a man be born of water and of the Spirit, he cannot enter into the kingdom of God."),
          BibleVerse(
              number: 6,
              text:
                  "That which is born of the flesh is flesh; and that which is born of the Spirit is spirit."),
          BibleVerse(
              number: 7,
              text: "Marvel not that I said unto thee, Ye must be born again."),
          BibleVerse(
              number: 8,
              text:
                  "The wind bloweth where it listeth, and thou hearest the sound thereof, but canst not tell whence it cometh, and whither it goeth: so is every one that is born of the Spirit."),
          BibleVerse(
              number: 9,
              text:
                  "Nicodemus answered and said unto him, How can these things be?"),
          BibleVerse(
              number: 10,
              text:
                  "Jesus answered and said unto him, Art thou a master of Israel, and knowest not these things?"),
          BibleVerse(
              number: 11,
              text:
                  "Verily, verily, I say unto thee, We speak that we do know, and testify that we have seen; and ye receive not our witness."),
          BibleVerse(
              number: 12,
              text:
                  "If I have told you earthly things, and ye believe not, how shall ye believe, if I tell you of heavenly things?"),
          BibleVerse(
              number: 13,
              text:
                  "And no man hath ascended up to heaven, but he that came down from heaven, even the Son of man which is in heaven."),
          BibleVerse(
              number: 14,
              text:
                  "And as Moses lifted up the serpent in the wilderness, even so must the Son of man be lifted up:"),
          BibleVerse(
              number: 15,
              text:
                  "That whosoever believeth in him should not perish, but have eternal life."),
          BibleVerse(
              number: 16,
              text:
                  "For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life."),
        ];
      } else {
        // Generate some sample verses for other books/chapters
        verses = List.generate(
            20,
            (i) => BibleVerse(
                number: i + 1,
                text:
                    "Sample verse text for $selectedBook chapter $selectedChapter verse ${i + 1}."));
      }

      // Optional: Save to cache
      // await BibleVerse.saveVerses(selectedBook, selectedChapter, verses);
    } catch (e) {
      // Handle error with Nylo's showToast
      showToast(
        title: "Failed to load content",
        description: "Unable to load Bible content: ${e.toString()}",
        icon: Icons.error,
      );
    }
  }

  // Change book and chapter
  Future<void> _changeBookAndChapter(String? book, int? chapter) async {
    if (book != null) {
      selectedBook = book;
    }

    if (chapter != null) {
      selectedChapter = chapter;
    }

    // Save reading position if version exists
    if (version != null) {
      try {
        await version!.saveReadingPosition("$selectedBook $selectedChapter", 1);
      } catch (e) {
        print("Error saving reading position: ${e.toString()}");
      }
    }

    // Load new content
    await _loadBibleContent();
  }

  // Change font size
  void _changeFontSize(double size) {
    setState(() {
      fontSize = size;
    });

    // Save font size preference using the correct Nylo 6 method
    try {
      NyStorage.save("bible_font_size", fontSize);
    } catch (e) {
      print("Error saving font size: ${e.toString()}");
    }
  }

  // Show font size picker
  void _showFontSizePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Font Size",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              StatefulBuilder(builder: (context, setModalState) {
                return Slider(
                  value: fontSize,
                  min: 12.0,
                  max: 24.0,
                  divisions: 6,
                  label: fontSize.round().toString(),
                  onChanged: (value) {
                    setModalState(() {
                      fontSize = value;
                    });
                  },
                );
              }),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Small", style: TextStyle(fontSize: 14)),
                  Text("Medium", style: TextStyle(fontSize: 16)),
                  Text("Large", style: TextStyle(fontSize: 18)),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _changeFontSize(fontSize);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0A2042),
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Apply"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget view(BuildContext context) {
    // If version is null, return error or default view
    if (version == null) {
      print("No Bible version provided, showing default view");
      // Instead of showing an error, we might want to load a default version
      // return Scaffold(
      //   appBar: AppBar(
      //     title: Text("Error"),
      //   ),
      //   body: Center(
      //     child: Text("Bible version not found"),
      //   ),
      // );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "$selectedBook $selectedChapter",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.format_size, color: Colors.black87),
            onPressed: _showFontSizePicker,
          ),
          IconButton(
            icon: Icon(Icons.bookmark_border, color: Colors.black87),
            onPressed: () {
              // Add bookmark functionality
              showToast(
                title: "Bookmark Added",
                description:
                    "$selectedBook $selectedChapter has been bookmarked",
                icon: Icons.bookmark,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black87),
            onPressed: () => _showOptions(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Book and chapter selector
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Colors.grey[100],
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedBook,
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down),
                    underline: SizedBox(),
                    items: books.map((String book) {
                      return DropdownMenuItem<String>(
                        value: book,
                        child: Text(book),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      _changeBookAndChapter(newValue, 1);
                    },
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  width: 60,
                  child: DropdownButton<int>(
                    value: selectedChapter,
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down),
                    underline: SizedBox(),
                    items: List.generate(bookChapters[selectedBook] ?? 50,
                        (index) => index + 1).map((int chapter) {
                      return DropdownMenuItem<int>(
                        value: chapter,
                        child: Text(chapter.toString()),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      _changeBookAndChapter(null, newValue);
                    },
                  ),
                ),
              ],
            ),
          ),

          // Bible content - Use afterLoad widget helper for conditional loading in Nylo 6
          Expanded(
            child: afterLoad(child: () {
              return Container(
                color: Colors.white,
                padding: EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: verses.length,
                  itemBuilder: (context, index) {
                    final verse = verses[index];
                    return GestureDetector(
                      onLongPress: () => _showVerseOptions(verse),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${verse.number} ",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: verse.text,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: fontSize,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
      // Bottom navigation for chapter navigation
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: selectedChapter > 1
                  ? () => _changeBookAndChapter(null, selectedChapter - 1)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0A2042),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
              child: Text("Previous Chapter"),
            ),
            ElevatedButton(
              onPressed: selectedChapter < (bookChapters[selectedBook] ?? 50)
                  ? () => _changeBookAndChapter(null, selectedChapter + 1)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0A2042),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
              child: Text("Next Chapter"),
            ),
          ],
        ),
      ),
    );
  }

  // Show verse options modal
  void _showVerseOptions(BibleVerse verse) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: Wrap(
            children: [
              Text(
                "$selectedBook $selectedChapter:${verse.number}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.content_copy),
                title: Text("Copy Verse"),
                onTap: () {
                  Navigator.pop(context);
                  // Copy verse functionality
                  showToast(
                    title: "Verse Copied",
                    description: "Verse copied to clipboard",
                    icon: Icons.content_copy,
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Share Verse"),
                onTap: () {
                  Navigator.pop(context);
                  // Share verse functionality
                  showToast(
                    title: "Sharing",
                    description: "Opening share dialog...",
                    icon: Icons.share,
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text("Bookmark Verse"),
                onTap: () {
                  Navigator.pop(context);
                  // Bookmark verse functionality
                  showToast(
                    title: "Verse Bookmarked",
                    description:
                        "$selectedBook $selectedChapter:${verse.number} has been bookmarked",
                    icon: Icons.bookmark,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Show more options modal
  void _showOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Share"),
                onTap: () {
                  Navigator.pop(context);
                  // Share functionality
                  showToast(
                    title: "Sharing",
                    description: "Opening share dialog...",
                    icon: Icons.share,
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.content_copy),
                title: Text("Copy Chapter"),
                onTap: () {
                  Navigator.pop(context);
                  // Copy functionality
                  showToast(
                    title: "Chapter Copied",
                    description: "Chapter content copied to clipboard",
                    icon: Icons.content_copy,
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.textsms),
                title: Text("Add Note"),
                onTap: () {
                  Navigator.pop(context);
                  // Add note functionality
                  _showAddNoteDialog();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Show add note dialog
  void _showAddNoteDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Note"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Enter your notes here",
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                if (controller.text.isNotEmpty) {
                  // Save note functionality
                  showToast(
                    title: "Note Added",
                    description: "Your note has been saved",
                    icon: Icons.textsms,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0A2042),
              ),
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
