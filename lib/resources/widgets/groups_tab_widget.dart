import 'package:flutter/material.dart';
import 'package:flutter_app/resources/pages/all_group_page.dart';
import 'package:flutter_app/resources/pages/group_details_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

class GroupsTab extends StatefulWidget {
  const GroupsTab({super.key});

  @override
  createState() => _GroupsTabState();
}

class _GroupsTabState extends NyState<GroupsTab> {
  // Your groups
  List<Map<String, dynamic>> yourGroups = [];

  // Other groups
  List<Map<String, dynamic>> otherGroups = [];

  @override
  get init => () {
        // Initialize with sample data
        yourGroups = [
          {
            'id': 'faith_fitness',
            'name': 'Faith & Fitness',
            'imageUrl':
                'group1.jpg', // This would be the actual asset path in your app
          },
          {
            'id': 'teen_bible',
            'name': 'Teen Bible Circle',
            'imageUrl': 'group2.jpg',
          },
          {
            'id': 'young_adults',
            'name': 'Young Adults Connect',
            'imageUrl': 'group3.jpg',
          },
          {
            'id': 'new_believers',
            'name': 'New Believers Group',
            'imageUrl': 'group5.jpg',
          },
        ];

        otherGroups = [
          {
            'id': 'creative_worship',
            'name': 'Creative Worship Team',
            'imageUrl': 'group4.jpg',
          },
          {
            'id': 'serve_squad',
            'name': 'Serve Squad',
            'imageUrl': 'group6.jpg',
          },
        ];
      };

  void _navigateToGroupDetails(Map<String, dynamic> group) {
    // In a real app, navigate to group details
    // Navigator.pushNamed(context, '/group-details', arguments: group);

    routeTo(GroupDetailsPage.path, data: group);
    // showToast(
    //   title: group['name'],
    //   description: "Viewing group details",
    //   icon: Icons.group,
    // );
  }

  void _viewAllGroups() {
    // In a real app, navigate to all groups page
    // Navigator.pushNamed(context, '/all-groups');
    routeTo(AllGroupPage.path);
    // showToast(
    //   title: "All Groups",
    //   description: "Viewing all available groups",
    //   icon: Icons.groups,
    // );
  }

  @override
  Widget view(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 16, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
              child: Text(
                "Groups",
                style: TextStyle(
                  color: Color(0xFF0A2042),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),

            // Your Groups Section
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Your Groups",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),

            // Your Groups Grid
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 0.9,
                children:
                    yourGroups.map((group) => _buildGroupCard(group)).toList(),
              ),
            ),

            SizedBox(height: 16),

            // Explore Other Groups Section
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Explore other Groups",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  TextButton(
                    onPressed: _viewAllGroups,
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

            // Other Groups Grid
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 0.9,
                children:
                    otherGroups.map((group) => _buildGroupCard(group)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build a group card with image and name
  Widget _buildGroupCard(Map<String, dynamic> group) {
    return GestureDetector(
      onTap: () => _navigateToGroupDetails(group),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Group image (circular)
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[200],
                  child: group['imageUrl'] != null
                      ? Image.asset(
                          group['imageUrl'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ).localAsset()
                      : Center(
                          child: Icon(
                            Icons.image,
                            size: 36,
                            color: Colors.grey[400],
                          ),
                        ),
                ),
              ),

              SizedBox(height: 12),

              // Group name
              Text(
                group['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
