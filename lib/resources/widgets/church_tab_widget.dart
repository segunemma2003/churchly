import 'package:flutter/material.dart';
import 'package:flutter_app/resources/pages/church_details_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ChurchTab extends StatefulWidget {
  const ChurchTab({super.key});

  @override
  createState() => _ChurchTabState();
}

class _ChurchTabState extends NyState<ChurchTab> {
  // Current location
  String currentLocation = "Los Angeles";
  List<String> availableLocations = [
    "Los Angeles",
    "New York",
    "Chicago",
    "Houston",
    "Miami",
    "San Francisco",
    "Seattle"
  ];

  // Search controller
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  // Filter options
  String selectedChurchType = "Catholic";
  List<String> churchTypes = [
    'Catholic',
    'Protestant',
    'Orthodox',
    'Non-denominational',
    'Baptist',
    'Methodist',
    'Lutheran',
    'Presbyterian'
  ];

  List<String> selectedLanguages = ["English", "Spanish"];
  List<String> availableLanguages = [
    "English",
    "Spanish",
    "French",
    "Mandarin",
    "Korean",
    "Russian",
    "Portuguese",
    "Arabic",
    "Tagalog"
  ];

  // Additional filter options
  bool hasChildcare = false;
  bool hasYouthGroup = false;
  bool hasAccessibility = false;

  // View state
  bool showFilter = false;
  bool showJoinedChurches = false;

  // Mock data for churches
  List<Map<String, dynamic>> churches = [];
  List<Map<String, dynamic>> joinedChurches = [];

  // All original churches before filtering
  List<Map<String, dynamic>> _allChurches = [];
  List<Map<String, dynamic>> _allJoinedChurches = [];

  @override
  get init => () {
        // Initialize with sample data
        churches = [
          {
            'id': 'church1',
            'name': 'Grace Community Church',
            'imageUrl': 'church1.jpg',
            'address': '176 Bang street, holyway road San-Andreas',
            'serviceTime': 'Sunday service: 9:00am - 11:00am',
            'tags': ['Family', 'Youth'],
            'joined': false,
            'type': 'Non-denominational',
            'languages': ['English', 'Spanish'],
            'hasChildcare': true,
            'hasYouthGroup': true,
            'hasAccessibility': false,
          },
          {
            'id': 'church2',
            'name': 'St. Mary Catholic Church',
            'imageUrl': 'church1.jpg',
            'address': '350 Wilshire Blvd, Los Angeles',
            'serviceTime': 'Sunday service: 8:30am - 10:00am',
            'tags': ['Family', 'Traditional'],
            'joined': false,
            'type': 'Catholic',
            'languages': ['English', 'Spanish', 'Latin'],
            'hasChildcare': true,
            'hasYouthGroup': false,
            'hasAccessibility': true,
          },
          {
            'id': 'church3',
            'name': 'First Baptist Church',
            'imageUrl': 'church1.jpg',
            'address': '412 Pine Street, Downtown',
            'serviceTime': 'Sunday service: 10:00am - 12:00pm',
            'tags': ['Contemporary', 'Youth'],
            'joined': false,
            'type': 'Baptist',
            'languages': ['English'],
            'hasChildcare': true,
            'hasYouthGroup': true,
            'hasAccessibility': true,
          },
          {
            'id': 'church4',
            'name': 'Orthodox Cathedral',
            'imageUrl': 'church1.jpg',
            'address': '789 Heritage Ave, East Side',
            'serviceTime': 'Sunday service: 9:30am - 11:30am',
            'tags': ['Traditional', 'Cultural'],
            'joined': false,
            'type': 'Orthodox',
            'languages': ['English', 'Russian'],
            'hasChildcare': false,
            'hasYouthGroup': true,
            'hasAccessibility': true,
          },
          {
            'id': 'church5',
            'name': 'Calvary Chapel',
            'imageUrl': 'church1.jpg',
            'address': '123 Sunset Blvd, West LA',
            'serviceTime': 'Sunday service: 8:00am, 10:00am, 12:00pm',
            'tags': ['Contemporary', 'Family'],
            'joined': false,
            'type': 'Non-denominational',
            'languages': ['English', 'Spanish', 'Korean'],
            'hasChildcare': true,
            'hasYouthGroup': true,
            'hasAccessibility': true,
          },
        ];

        joinedChurches = [
          {
            'id': 'church6',
            'name': 'Grace Community Church',
            'imageUrl': 'church1.jpg',
            'address': '176 Bang street, holyway road San-Andreas',
            'serviceTime': 'Sunday service: 9:00am - 11:00am',
            'tags': ['Family', 'Youth'],
            'joined': true,
            'type': 'Non-denominational',
            'languages': ['English', 'Spanish'],
            'hasChildcare': true,
            'hasYouthGroup': true,
            'hasAccessibility': false,
          },
        ];

        // Set up search listener for real-time filtering
        _searchController.addListener(_onSearchChanged);
      };

  // Real-time search handler
  void _onSearchChanged() {
    setState(() {
      searchQuery = _searchController.text.toLowerCase();
      _filterChurches();
    });
  }

  // Apply all filters (search + filter criteria)
  void _filterChurches() {
    if (_allChurches.isEmpty) {
      // First time filtering, save original lists
      _allChurches = List.from(churches);
      _allJoinedChurches = List.from(joinedChurches);
    }

    // Reset to all churches first
    churches = List.from(_allChurches);
    joinedChurches = List.from(_allJoinedChurches);

    // Apply search query filter if not empty
    if (searchQuery.isNotEmpty) {
      churches = churches
          .where((church) =>
              church['name'].toLowerCase().contains(searchQuery) ||
              church['address'].toLowerCase().contains(searchQuery))
          .toList();

      joinedChurches = joinedChurches
          .where((church) =>
              church['name'].toLowerCase().contains(searchQuery) ||
              church['address'].toLowerCase().contains(searchQuery))
          .toList();
    }

    // Apply church type filter
    if (selectedChurchType != 'All') {
      churches = churches
          .where((church) => church['type'] == selectedChurchType)
          .toList();

      joinedChurches = joinedChurches
          .where((church) => church['type'] == selectedChurchType)
          .toList();
    }

    // Apply language filter
    if (selectedLanguages.isNotEmpty) {
      churches = churches
          .where((church) => church['languages']
              .any((lang) => selectedLanguages.contains(lang)))
          .toList();

      joinedChurches = joinedChurches
          .where((church) => church['languages']
              .any((lang) => selectedLanguages.contains(lang)))
          .toList();
    }

    // Apply additional filters if enabled
    if (hasChildcare) {
      churches =
          churches.where((church) => church['hasChildcare'] == true).toList();
      joinedChurches = joinedChurches
          .where((church) => church['hasChildcare'] == true)
          .toList();
    }

    if (hasYouthGroup) {
      churches =
          churches.where((church) => church['hasYouthGroup'] == true).toList();
      joinedChurches = joinedChurches
          .where((church) => church['hasYouthGroup'] == true)
          .toList();
    }

    if (hasAccessibility) {
      churches = churches
          .where((church) => church['hasAccessibility'] == true)
          .toList();
      joinedChurches = joinedChurches
          .where((church) => church['hasAccessibility'] == true)
          .toList();
    }
  }

  void _toggleShowFilter() {
    setState(() {
      showFilter = !showFilter;
    });
  }

  void _applyFilter() {
    setState(() {
      showFilter = false;
    });

    // Apply all filters
    _filterChurches();

    showToast(
      title: "Filter Applied",
      description:
          "Showing $selectedChurchType churches with ${selectedLanguages.join(', ')} services",
      icon: Icons.filter_list,
    );
  }

  void _addLanguage(String language) {
    if (!selectedLanguages.contains(language)) {
      setState(() {
        selectedLanguages.add(language);
      });
    }
  }

  void _showLocationPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Text(
                  "Select Location",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: availableLocations.length,
                  itemBuilder: (context, index) {
                    final location = availableLocations[index];
                    return ListTile(
                      title: Text(location),
                      trailing: location == currentLocation
                          ? Icon(Icons.check, color: Color(0xFF0A2042))
                          : null,
                      onTap: () {
                        setState(() {
                          currentLocation = location;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleJoinChurch(Map<String, dynamic> church) {
    setState(() {
      if (church['joined']) {
        // Remove from joined churches
        joinedChurches.removeWhere((item) => item['id'] == church['id']);
        church['joined'] = false;
        churches.add(church);
      } else {
        // Add to joined churches
        churches.removeWhere((item) => item['id'] == church['id']);
        church['joined'] = true;
        joinedChurches.add(church);
      }
    });

    showToast(
      title: church['joined'] ? "Church Joined" : "Left Church",
      description: church['joined']
          ? "You have joined ${church['name']}"
          : "You have left ${church['name']}",
      icon: church['joined'] ? Icons.check_circle : Icons.info,
    );
  }

  void _viewChurchDetails(Map<String, dynamic> church) {
    // In a real app, you would navigate to the church details page
    routeTo(ChurchDetailsPage.path);
    // showToast(
    //   title: church['name'],
    //   description: "Viewing church details",
    //   icon: Icons.church,
    // );
  }

  void _toggleNearestToMe() {
    // In a real app, you would sort churches by distance from user

    showToast(
      title: "Sorting by Distance",
      description: "Showing churches nearest to your location",
      icon: Icons.location_on,
    );
  }

  @override
  Widget view(BuildContext context) {
    return Stack(
      children: [
        // Main content
        Scaffold(
          backgroundColor: Colors.grey[50],
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Location",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),

                      // Location dropdown
                      InkWell(
                        onTap: _showLocationPicker,
                        child: Row(
                          children: [
                            Text(
                              currentLocation,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black87,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16),

                      // Search bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: "Search Church name or city",
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          onChanged: (value) => _onSearchChanged(),
                        ),
                      ),

                      SizedBox(height: 16),

                      // Filter options
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Nearest to me button
                          OutlinedButton(
                            onPressed: _toggleNearestToMe,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey[300]!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Text(
                              "Nearest to me",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                          ),

                          SizedBox(width: 8),

                          // Filter button
                          IconButton(
                            onPressed: _toggleShowFilter,
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(color: Colors.grey[300]!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            icon: Icon(
                              Icons.filter_list,
                              size: 20,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Churches list section
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        showJoinedChurches
                            ? "Joined Churches"
                            : "Search results",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),

                      // Toggle between all and joined churches
                      TextButton(
                        onPressed: () {
                          setState(() {
                            showJoinedChurches = !showJoinedChurches;
                          });
                        },
                        child: Text(
                          showJoinedChurches ? "Show All" : "Show Joined",
                          style: TextStyle(
                            color: Color(0xFF0A2042),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Empty state or list of churches
                Expanded(
                  child: (showJoinedChurches && joinedChurches.isEmpty) ||
                          (!showJoinedChurches && churches.isEmpty)
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          itemCount: showJoinedChurches
                              ? joinedChurches.length
                              : churches.length,
                          itemBuilder: (context, index) {
                            final church = showJoinedChurches
                                ? joinedChurches[index]
                                : churches[index];
                            return _buildChurchListItem(church);
                          },
                        ),
                ),
              ],
            ),
          ),
        ),

        // Filter overlay
        if (showFilter) _buildFilterOverlay(),
      ],
    );
  }

  // Build a church list item
  Widget _buildChurchListItem(Map<String, dynamic> church) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 3,
            spreadRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Church info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Church image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: church['imageUrl'] != null
                        ? Image.asset(
                            church['imageUrl'],
                            fit: BoxFit.cover,
                          ).localAsset()
                        : Icon(
                            Icons.church,
                            size: 40,
                            color: Colors.grey[500],
                          ),
                  ),
                ),

                SizedBox(width: 16),

                // Church details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Church name
                      Text(
                        church['name'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),

                      SizedBox(height: 8),

                      // Church address
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              church['address'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 4),

                      // Service time
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              church['serviceTime'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tags
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: church['tags'].map<Widget>((tag) {
                return Container(
                  margin: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFF5B9BD5).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color(0xFF5B9BD5).withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF5B9BD5),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 16),

          // Buttons
          Row(
            children: [
              // View details button
              Expanded(
                child: InkWell(
                  onTap: () => _viewChurchDetails(church),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[300]!,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "View details",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),

              // Join/Joined button
              Expanded(
                child: InkWell(
                  onTap: () => _toggleJoinChurch(church),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: church['joined']
                          ? Colors.grey[300]
                          : Color(0xFF0A2042),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (church['joined'])
                          Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.black87,
                          ),
                        SizedBox(width: 4),
                        Text(
                          church['joined'] ? "Joined" : "Join",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: church['joined']
                                ? Colors.black87
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Build filter overlay
  Widget _buildFilterOverlay() {
    return GestureDetector(
      onTap: _toggleShowFilter, // Close filter when tapping outside
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: GestureDetector(
            onTap: () {}, // Prevent tap from closing when on the modal itself
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              margin: EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Filter header
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Church Filter",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          IconButton(
                            onPressed: _toggleShowFilter,
                            icon: Icon(Icons.close),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                          ),
                        ],
                      ),
                    ),

                    // Church type
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        "Church",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    // Church type dropdown - corrected version
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedChurchType,
                            isExpanded: true,
                            icon: Icon(Icons.keyboard_arrow_down),
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selectedChurchType = newValue;
                                });
                              }
                            },
                            items: <DropdownMenuItem<String>>[
                              DropdownMenuItem<String>(
                                value: 'All',
                                child: Text('All'),
                              ),
                              ...churchTypes.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    // Language
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Language",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Show language selector
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                      builder: (context, setModalState) {
                                    return Container(
                                      height: 400,
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Select Languages",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount:
                                                  availableLanguages.length,
                                              itemBuilder: (context, index) {
                                                final language =
                                                    availableLanguages[index];
                                                final isSelected =
                                                    selectedLanguages
                                                        .contains(language);

                                                return CheckboxListTile(
                                                  title: Text(language),
                                                  value: isSelected,
                                                  onChanged: (bool? value) {
                                                    setModalState(() {
                                                      if (value == true) {
                                                        if (!selectedLanguages
                                                            .contains(
                                                                language)) {
                                                          selectedLanguages
                                                              .add(language);
                                                        }
                                                      } else {
                                                        selectedLanguages
                                                            .remove(language);
                                                      }
                                                    });

                                                    // Also update the parent state
                                                    setState(() {});
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xFF0A2042),
                                                foregroundColor: Colors.white,
                                              ),
                                              child: Text("Done"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                },
                              );
                            },
                            child: Text(
                              "Select",
                              style: TextStyle(
                                color: Color(0xFF0A2042),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Selected languages display
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: selectedLanguages.map((lang) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 4),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    lang,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedLanguages.remove(lang);
                                      });
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    // Additional filters
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        "Additional Filters",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    // Childcare filter
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: CheckboxListTile(
                        title: Text(
                          "Has Childcare",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        value: hasChildcare,
                        onChanged: (value) {
                          setState(() {
                            hasChildcare = value ?? false;
                          });
                        },
                      ),
                    ),

                    // Youth Group filter
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: CheckboxListTile(
                        title: Text(
                          "Has Youth Group",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        value: hasYouthGroup,
                        onChanged: (value) {
                          setState(() {
                            hasYouthGroup = value ?? false;
                          });
                        },
                      ),
                    ),

                    // Accessibility filter
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: CheckboxListTile(
                        title: Text(
                          "Wheelchair Accessible",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        value: hasAccessibility,
                        onChanged: (value) {
                          setState(() {
                            hasAccessibility = value ?? false;
                          });
                        },
                      ),
                    ),

                    SizedBox(height: 24),

                    // Apply button
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _applyFilter,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0A2042),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            "Apply Filter",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Empty state widget
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            "No churches found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            showJoinedChurches
                ? "You haven't joined any churches yet"
                : "Try adjusting your filters or search terms",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Remove the listener when the widget is disposed
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
}
