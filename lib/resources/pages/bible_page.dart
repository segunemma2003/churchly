import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'dart:convert';

import '../../app/models/bible_version.dart';

class BiblePage extends NyStatefulWidget {
  static RouteView path = ("/bible", (_) => BiblePage());

  BiblePage({super.key}) : super(child: () => _BiblePageState());
}

class _BiblePageState extends NyPage<BiblePage> {
  bool isFilterOpen = false;
  List<BibleVersion> bibleVersions = [];
  BibleVersion? selectedVersion;

  // Filter options
  String selectedBibleVersionFilter = "All Specialization";
  String selectedLanguageFilter = "All Specialization";

  @override
  get init => () {
        _loadBibleVersions();
      };

  // Load Bible versions from API or local data
  void _loadBibleVersions() {
    // In a real app, this would fetch from an API
    // For now, we'll use sample data
    setState(() {
      bibleVersions = [
        BibleVersion(
          id: "kjv",
          name: "King James Version",
          language: "Modern English",
          lastReadChapter: "John 3",
          lastReadVerse: 16,
          coverImage: "bible_cover.jpg",
          isReading: true,
        ),
        BibleVersion(
          id: "niv",
          name: "King James Version",
          language: "Modern English",
          coverImage: "bible_cover.jpg",
          isReading: false,
        ),
        BibleVersion(
          id: "esv",
          name: "King James Version",
          language: "Modern English",
          coverImage: "bible_cover.jpg",
          isReading: true,
        ),
        BibleVersion(
          id: "amp",
          name: "King James Version",
          language: "Modern English",
          coverImage: "bible_cover.jpg",
          isReading: true,
        ),
        BibleVersion(
          id: "nlt",
          name: "King James Version",
          language: "Modern English",
          coverImage: "bible_cover.jpg",
          isReading: true,
        ),
      ];

      // Set first version as selected by default
      if (bibleVersions.isNotEmpty) {
        selectedVersion = bibleVersions.first;
      }
    });
  }

  // Open the Bible filter dialog
  void _openBibleFilter() {
    setState(() {
      isFilterOpen = true;
    });
  }

  // Close the Bible filter dialog
  void _closeBibleFilter() {
    setState(() {
      isFilterOpen = false;
    });
  }

  // Apply the Bible filter
  void _applyFilter() {
    // In a real app, this would filter the Bible versions
    // based on the selected filters

    // For now, we'll just close the filter
    _closeBibleFilter();
  }

  // Navigate to Bible reading page
  void _navigateToBibleReading(BibleVersion version) {
    routeTo('/bible/reading', data: {"version": version});
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Bible",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bible version selector
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select Bible Version",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.filter_list,
                          color: Colors.black54,
                        ),
                        onPressed: _openBibleFilter,
                      ),
                    ],
                  ),
                ),

                // Bible versions list
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: bibleVersions.length,
                    itemBuilder: (context, index) {
                      final version = bibleVersions[index];
                      return _buildBibleVersionCard(version, index);
                    },
                  ),
                ),
              ],
            ),

            // Filter overlay
            if (isFilterOpen) _buildFilterOverlay(),
          ],
        ),
      ),
    );
  }

  // Build Bible version card
  Widget _buildBibleVersionCard(BibleVersion version, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bible cover image
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
            ),
            child: Container(
              width: 72,
              height: 100,
              color: Color(0xFF0A2042), // Dark blue color for Bible cover
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "THE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "HOLY",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "BIBLE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "KING JAMES VERSION",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bible info and actions
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    version.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    version.language,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 12),

                  // Continue Reading or Start Reading button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _navigateToBibleReading(version),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: version.isReading
                            ? (index % 2 == 0
                                ? Colors.green
                                : Color(0xFF0A2042))
                            : Color(0xFF0A2042),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      child: Text(
                        version.isReading
                            ? "Continue Reading"
                            : "Start Reading",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build filter overlay
  Widget _buildFilterOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter title and close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Filter Bible",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.black54),
                    onPressed: _closeBibleFilter,
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Bible version filter
              Text(
                "Bible version",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              _buildDropdown(
                value: selectedBibleVersionFilter,
                onChanged: (value) {
                  setState(() {
                    selectedBibleVersionFilter = value!;
                  });
                },
              ),
              SizedBox(height: 16),

              // Language filter
              Text(
                "Language",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              _buildDropdown(
                value: selectedLanguageFilter,
                onChanged: (value) {
                  setState(() {
                    selectedLanguageFilter = value!;
                  });
                },
              ),
              SizedBox(height: 24),

              // Apply filter button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _applyFilter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0A2042),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: Text(
                    "Apply Filter",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build dropdown for filters
  Widget _buildDropdown({
    required String value,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down),
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          items: [
            DropdownMenuItem(
              value: "All Specialization",
              child: Text("All Specialization"),
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
