import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class GroupDetailsPage extends NyStatefulWidget {
  static RouteView path = ("/group-details", (_) => GroupDetailsPage());

  GroupDetailsPage({super.key}) : super(child: () => _GroupDetailsPageState());
}

class _GroupDetailsPageState extends NyPage<GroupDetailsPage> {
  // Mock data - in a real app, this would come from API or route arguments
  late Map<String, dynamic> groupData;
  bool isJoined = true;

  @override
  get init => () {
        // Initialize with sample data
        groupData = {
          'id': 'faith_fitness',
          'name': 'Faith and Fitness',
          'imageUrl': 'group1.jpg',
          'memberCount': 35,
          'meetingInfo': 'Mondays & Wednesdays at 6:00 PM, Church Lawn',
          'leaders': 'Pastor Josh and Hank Pym',
          'description':
              'Grow spiritually and physically in this unique group that combines light workouts, devotionals, and encouragement.',
          'announcements': [
            {
              'title': 'Let\'s take our workout to the waves!',
              'content':
                  'Let\'s take our workout to the waves! Join us this Saturday for a fun and refreshing cardio session at the beach. Don\'t forget water, sunscreen, and your energy!',
              'date': 'Sat 20th April, 2025 by 9:00am',
              'postedBy': 'Pastor Josh'
            },
            {
              'title': 'Let\'s take our workout to the waves!',
              'content':
                  'Let\'s take our workout to the waves! Join us this Saturday for a fun and refreshing cardio session at the beach. Don\'t forget water, sunscreen, and your energy!',
              'date': 'Sat 20th April, 2025 by 9:00am',
              'postedBy': 'Pastor Josh'
            },
            {
              'title': 'Let\'s take our workout to the waves!',
              'content':
                  'Let\'s take our workout to the waves! Join us this Saturday for a fun and refreshing cardio session at the beach. Don\'t forget water, sunscreen, and your energy!',
              'date': 'Sat 20th April, 2025 by 9:00am',
              'postedBy': 'Pastor Josh'
            }
          ]
        };
      };

  void _toggleJoinGroup() {
    setState(() {
      isJoined = !isJoined;
    });

    showToast(
      title: isJoined ? "Joined Group" : "Left Group",
      description: isJoined
          ? "You have successfully joined ${groupData['name']}"
          : "You have left ${groupData['name']}",
      icon: isJoined ? Icons.check_circle : Icons.info,
    );
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Back button and title
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black87),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "Group Details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            // Content area (scrollable)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cover image with group name
                    Stack(
                      children: [
                        // Group cover image
                        Container(
                          width: double.infinity,
                          height: 220,
                          color: Colors.grey[800],
                          // In a real app, you would use Image.asset or Image.network
                          child: groupData['imageUrl'] != null
                              ? Image.asset(
                                  groupData['imageUrl'],
                                  fit: BoxFit.cover,
                                ).localAsset()
                              : Center(
                                  child: Icon(
                                    Icons.image,
                                    color: Colors.grey[500],
                                    size: 48,
                                  ),
                                ),
                        ),

                        // Group name overlay at the bottom of the image
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Text(
                              groupData['name'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Group details section
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Group details with member count
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Group details",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),

                              // Member count with icon
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 16,
                                    color: Color(0xFF0A2042),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${groupData['memberCount']} Members",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(width: 8),

                                  // Join/Leave button
                                  OutlinedButton(
                                    onPressed: _toggleJoinGroup,
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

                          SizedBox(height: 16),

                          // Meeting details
                          _buildInfoRow(
                            icon: Icons.event,
                            iconColor: Color(0xFF0A2042),
                            title: "Meetings",
                            value: groupData['meetingInfo'],
                          ),

                          SizedBox(height: 16),

                          // Group leaders
                          _buildInfoRow(
                            icon: Icons.person,
                            iconColor: Color(0xFF0A2042),
                            title: "Group Leaders",
                            value: groupData['leaders'],
                          ),

                          SizedBox(height: 16),

                          // Group description
                          Text(
                            "Group description",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            groupData['description'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                          ),

                          SizedBox(height: 24),

                          // Announcements section
                          Text(
                            "Announcements",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 16),

                          // Announcement cards
                          ...groupData['announcements']
                              .map((announcement) =>
                                  _buildAnnouncementCard(announcement))
                              .toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build info rows
  Widget _buildInfoRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper method to build announcement cards
  Widget _buildAnnouncementCard(Map<String, dynamic> announcement) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            announcement['title'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),

          // Content
          Text(
            announcement['content'],
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          SizedBox(height: 8),

          // Date and posted by
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                announcement['date'],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              Text(
                "--${announcement['postedBy']}",
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
