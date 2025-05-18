import 'package:flutter/material.dart';
import 'package:flutter_app/resources/pages/group_details_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

class AllGroupPage extends NyStatefulWidget {
  static RouteView path = ("/all-group", (_) => AllGroupPage());

  AllGroupPage({super.key}) : super(child: () => _AllGroupPageState());
}

class _AllGroupPageState extends NyPage<AllGroupPage> {
  // Mock data for all available groups
  List<Map<String, dynamic>> allGroups = [];

  @override
  get init => () {
        // Initialize with sample data
        allGroups = [
          {
            'id': 'faith_fitness',
            'name': 'Faith and Fitness',
            'description':
                'Grow spiritually and physically in this unique group that combines light workouts, devotionals, and encouragement.',
            'imageUrl': 'group1.jpg',
            'nextMeeting': 'Next Meeting: Sat 25 Apr, 2025 by 9:00am',
          },
          {
            'id': 'community_food',
            'name': 'Community Food Outreach',
            'description':
                'A relaxed, open space for high schoolers to dive into Scripture, ask questions, and talk life.',
            'imageUrl': 'group2.jpg',
            'nextMeeting': 'Next Meeting: Sat 25 Apr, 2025 by 9:00am',
          },
          {
            'id': 'may_family',
            'name': 'May Family Picnic',
            'description':
                'Just starting your faith journey? This group is for those new to Christianity or rediscovering their relationship with God.',
            'imageUrl': 'group3.jpg',
            'nextMeeting': 'Next Meeting: Sat 25 Apr, 2025 by 9:00am',
          },
          {
            'id': 'faith_fitness_2',
            'name': 'Faith and Fitness',
            'description':
                'Grow spiritually and physically in this unique group that combines light workouts, devotionals, and encouragement.',
            'imageUrl': 'group1.jpg',
            'nextMeeting': 'Next Meeting: Sat 25 Apr, 2025 by 9:00am',
          },
          {
            'id': 'may_family_2',
            'name': 'May Family Picnic',
            'description':
                'Just starting your faith journey? This group is for those new to Christianity or rediscovering their relationship with God.',
            'imageUrl': 'group3.jpg',
            'nextMeeting': 'Next Meeting: Sat 25 Apr, 2025 by 9:00am',
          },
        ];
      };

  void _navigateToGroupDetails(Map<String, dynamic> group) {
    // In a real app, you'd navigate to the group details page
    // Navigator.pushNamed(context, '/group-details', arguments: {"groupData": group});
    routeTo(GroupDetailsPage.path);
    // showToast(
    //   title: group['name'],
    //   description: "Viewing group details",
    //   icon: Icons.group,
    // );
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with back button and title
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black87),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "All Groups",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            // "All Available Groups" heading
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              width: double.infinity,
              child: Text(
                "All Available Groups",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),

            // Groups list
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                itemCount: allGroups.length,
                itemBuilder: (context, index) {
                  final group = allGroups[index];
                  return GestureDetector(
                    onTap: () => _navigateToGroupDetails(group),
                    child: _buildGroupListItem(group),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build a group list item with image, name, description, and next meeting
  Widget _buildGroupListItem(Map<String, dynamic> group) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.all(16.0),
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
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Group image (circular)
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.grey[200],
                child: group['imageUrl'] != null
                    ? Image.asset(
                        group['imageUrl'],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ).localAsset()
                    : Center(
                        child: Icon(
                          Icons.image,
                          size: 32,
                          color: Colors.grey[400],
                        ),
                      ),
              ),
            ),

            SizedBox(width: 16),

            // Group details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Group name
                  Text(
                    group['name'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: 8),

                  // Group description
                  Text(
                    group['description'],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),

                  SizedBox(height: 8),

                  // Next meeting info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          group['nextMeeting'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      SizedBox(width: 8),

                      // Arrow icon
                      Icon(
                        Icons.arrow_forward,
                        size: 18,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
