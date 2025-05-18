import 'package:flutter/material.dart';
import 'package:flutter_app/resources/pages/all_group_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ChurchDetailsPage extends NyStatefulWidget {
  static RouteView path = ("/church-details", (_) => ChurchDetailsPage());

  ChurchDetailsPage({super.key})
      : super(child: () => _ChurchDetailsPageState());
}

class _ChurchDetailsPageState extends NyPage<ChurchDetailsPage> {
  // Mock data for church details
  Map<String, dynamic> churchData = {};
  bool isJoined = true;

  // Mock data for church groupsx
  List<Map<String, dynamic>> churchGroups = [];

  @override
  get init => () {
        // In a real app, you'd get this data from route parameters
        churchData = {
          'id': 'church1',
          'name': 'Grace Community Church',
          'imageUrl': 'church1.jpg',
          'address': '176 Bang street, holyway road San-Andreas',
          'memberCount': 205,
          'mainService': '9:00AM - 11:00AM',
          'pastor': 'Pastor Josh Brolin',
          'phoneNumber': '(213) 555-0824',
          'email': 'contact@gracecommunity.org',
          'joined': true,
        };

        // Mock data with more groups for better scrolling demonstration
        churchGroups = [
          {
            'id': 'group1',
            'name': 'Creative Worship Team',
            'imageUrl': 'group1.jpg',
          },
          {
            'id': 'group2',
            'name': 'Serve Squad',
            'imageUrl': 'group2.jpg',
          },
          {
            'id': 'group3',
            'name': 'Youth Ministry',
            'imageUrl': 'group3.jpg',
          },
          {
            'id': 'group4',
            'name': 'Bible Study',
            'imageUrl': 'group4.jpg',
          },
          {
            'id': 'group5',
            'name': 'Prayer Warriors',
            'imageUrl': 'group5.jpg',
          },
        ];

        // Initialize join status
        isJoined = churchData['joined'] ?? false;
      };

  void _toggleJoin() {
    setState(() {
      isJoined = !isJoined;
      churchData['joined'] = isJoined;
    });

    showToast(
      title: isJoined ? "Joined Church" : "Left Church",
      description: isJoined
          ? "You have joined ${churchData['name']}"
          : "You have left ${churchData['name']}",
      icon: isJoined ? Icons.check_circle : Icons.info,
    );
  }

  void _viewAllGroups() {
    // Navigate to all groups page
    routeTo(AllGroupPage.path);
    // showToast(
    //   title: "All Groups",
    //   description: "Viewing all church groups",
    //   icon: Icons.groups,
    // );
  }

  void _viewGroupDetails(Map<String, dynamic> group) {
    // Navigate to group details page
    showToast(
      title: group['name'],
      description: "Viewing group details",
      icon: Icons.group,
    );
  }

  void _makeCall() {
    // Handle phone call
    showToast(
      title: "Making Call",
      description: "Calling ${churchData['phoneNumber']}",
      icon: Icons.call,
    );
  }

  void _sendEmail() {
    // Handle sending email
    showToast(
      title: "Sending Email",
      description: "Opening email to ${churchData['email']}",
      icon: Icons.email,
    );
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Church image and header
            Stack(
              children: [
                // Church image
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[800],
                  child: churchData['imageUrl'] != null
                      ? Image.asset(
                          churchData['imageUrl'],
                          fit: BoxFit.cover,
                        ).localAsset()
                      : Center(
                          child: Icon(
                            Icons.church,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                        ),
                ),

                // Back button
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),

                // Action buttons (Website, Register)
                Positioned(
                  top: 16,
                  right: 16,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Navigate to website
                            showToast(
                              title: "Website",
                              description: "Opening church website",
                              icon: Icons.language,
                            );
                          },
                          child: Text(
                            "Website",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Register for service
                            showToast(
                              title: "Register",
                              description: "Opening registration form",
                              icon: Icons.app_registration,
                            );
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Image carousel indicators
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => Container(
                        width: 8,
                        height: 8,
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == 0
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),

                // Church name
                Positioned(
                  bottom: 30,
                  left: 16,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      churchData['name'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Church details
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Church details section
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Church details",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),

                          // Member count
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 16,
                                color: Color(0xFF0A2042),
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${churchData['memberCount']} Members",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),

                              SizedBox(width: 8),

                              // Join button
                              OutlinedButton(
                                onPressed: _toggleJoin,
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  side: BorderSide(
                                    color: isJoined
                                        ? Color(0xFF0A2042)
                                        : Colors.grey,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 0),
                                  minimumSize: Size(0, 30),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (isJoined)
                                      Icon(
                                        Icons.check,
                                        size: 16,
                                        color: Color(0xFF0A2042),
                                      ),
                                    SizedBox(width: 4),
                                    Text(
                                      isJoined ? "Joined" : "Join",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isJoined
                                            ? Color(0xFF0A2042)
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Location
                    _buildInfoItem(
                      icon: Icons.location_on,
                      iconColor: Color(0xFF0A2042),
                      title: "Location",
                      value: churchData['address'],
                    ),

                    // Main Service
                    _buildInfoItem(
                      icon: Icons.access_time,
                      iconColor: Color(0xFF0A2042),
                      title: "Main Service",
                      value: churchData['mainService'],
                    ),

                    // Pastor
                    _buildInfoItem(
                      icon: Icons.person,
                      iconColor: Color(0xFF0A2042),
                      title: "Pastor",
                      value: churchData['pastor'],
                    ),

                    // Contact info
                    Row(
                      children: [
                        // Phone number
                        Expanded(
                          child: InkWell(
                            onTap: _makeCall,
                            child: _buildInfoItem(
                              icon: Icons.phone,
                              iconColor: Color(0xFF0A2042),
                              title: "Phone Number",
                              value: churchData['phoneNumber'],
                              showTrailingIcon: true,
                            ),
                          ),
                        ),

                        // Email
                        Expanded(
                          child: InkWell(
                            onTap: _sendEmail,
                            child: _buildInfoItem(
                              icon: Icons.email,
                              iconColor: Color(0xFF0A2042),
                              title: "Email",
                              value: churchData['email'],
                              showTrailingIcon: true,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Church Groups section
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Church Groups",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),

                          // All Groups link
                          InkWell(
                            onTap: _viewAllGroups,
                            child: Row(
                              children: [
                                Text(
                                  "All Groups",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                  color: Colors.black87,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Church Groups horizontal scroll
                    Container(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: churchGroups.length,
                        itemBuilder: (context, index) {
                          return _buildGroupItem(churchGroups[index]);
                        },
                      ),
                    ),

                    SizedBox(height: 40), // Bottom padding
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build info items
  Widget _buildInfoItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    bool showTrailingIcon = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 46, // Increased height to accommodate both lines of text
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 2), // Adjust icon position
            child: Icon(
              icon,
              size: 22,
              color: iconColor,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13, // Smaller font size for title
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 2), // Reduced space between title and value
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 15, // Slightly smaller font size for value
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    if (showTrailingIcon)
                      Icon(
                        icon == Icons.phone ? Icons.call : Icons.send,
                        size: 18,
                        color: iconColor,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build group items
  Widget _buildGroupItem(Map<String, dynamic> group) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: () => _viewGroupDetails(group),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Group image
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.grey[300],
                child: group['imageUrl'] != null
                    ? Image.asset(
                        group['imageUrl'],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ).localAsset()
                    : Center(
                        child: Icon(
                          Icons.groups,
                          size: 40,
                          color: Colors.grey[400],
                        ),
                      ),
              ),
            ),

            SizedBox(height: 8),

            // Group name
            Text(
              group['name'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
