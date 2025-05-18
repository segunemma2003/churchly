import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class AddressesPage extends NyStatefulWidget {
  static RouteView path = ("/addresses", (_) => AddressesPage());

  AddressesPage({super.key}) : super(child: () => _AddressesPageState());
}

class _AddressesPageState extends NyPage<AddressesPage> {
  // List of saved addresses
  List<String> savedAddresses =
      List.filled(6, "Five through Courseway, Los Angeles", growable: true);

  // Sample locations for search (you can expand this list or load from a file/database)
  final List<String> sampleLocations = [
    "123 Main Street, New York, NY",
    "456 Oak Avenue, Los Angeles, CA",
    "789 Pine Road, Chicago, IL",
    "101 Maple Lane, Miami, FL",
    "202 Cedar Boulevard, Seattle, WA",
    "303 Elm Drive, Dallas, TX",
    "404 Birch Court, Boston, MA",
    "505 Willow Way, San Francisco, CA",
    "606 Spruce Street, Denver, CO",
    "707 Redwood Place, Atlanta, GA",
    "Five through Courseway, Los Angeles, CA",
    "1010 Palm Avenue, Phoenix, AZ",
    "1111 Beach Boulevard, San Diego, CA",
    "1212 Mountain View, Las Vegas, NV",
    "1313 River Road, Portland, OR",
    "1414 Lake Drive, Minneapolis, MN",
    "1515 Park Place, Philadelphia, PA",
    "1616 Valley Lane, Houston, TX",
    "1717 Sunset Boulevard, Los Angeles, CA",
    "1818 Sunrise Avenue, Orlando, FL",
  ];

  // Controller for the search field
  final TextEditingController _searchController = TextEditingController();

  // Filtered locations based on search
  List<String> filteredLocations = [];

  // Flag to show/hide search results
  bool _showSearchResults = false;

  @override
  get init => () {
        // Initialize the filtered locations with the full list
        filteredLocations = List.from(sampleLocations);

        // Add listener to the search controller to filter locations as the user types
        _searchController.addListener(() {
          _filterLocations(_searchController.text);
        });
      };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter locations based on search text
  void _filterLocations(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filteredLocations = List.from(sampleLocations);
      } else {
        filteredLocations = sampleLocations
            .where((location) =>
                location.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      }
    });
  }

  // Add a new address to the saved list
  void _addAddress(String address) {
    setState(() {
      savedAddresses.add(address);
      _searchController.clear();
      _showSearchResults = false;
    });
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Addresses",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.indigo, // Adjust to match your app's theme
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.indigo, // Adjust to match your app's theme
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: _searchController,
                  onTap: () {
                    setState(() {
                      _showSearchResults = true;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Add a new Address",
                    prefixIcon: Icon(Icons.location_on_outlined,
                        color: Colors.grey[600]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _showSearchResults = false;
                              });
                            },
                          )
                        : null,
                  ),
                ),
              ),
            ),

            // Search results
            if (_showSearchResults)
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView.separated(
                    itemCount: filteredLocations.length,
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      thickness: 1,
                      indent: 56,
                    ),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.location_on_outlined),
                        title: Text(filteredLocations[index]),
                        onTap: () {
                          _addAddress(filteredLocations[index]);
                        },
                      );
                    },
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.separated(
                  itemCount: savedAddresses.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      title: Text(
                        savedAddresses[index],
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            savedAddresses.removeAt(index);
                          });
                        },
                      ),
                      onTap: () {
                        // Handle address selection
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
