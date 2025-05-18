import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class AnnouncementPage extends NyStatefulWidget {
  static RouteView path = ("/announcement", (_) => AnnouncementPage());

  AnnouncementPage({super.key}) : super(child: () => _AnnouncementPageState());
}

class _AnnouncementPageState extends NyPage<AnnouncementPage> {
  // Mock announcements data
  List<Map<String, dynamic>> announcements = [];

  @override
  get init => () {
        // Initialize mock announcements data
        announcements = [
          {
            'type': 'reminder',
            'title': 'Weekly Giving Reminder',
            'message':
                'Hi Vanessa, your weekly donation to Grace Community Church is due today. Tap here to complete your giving or update your schedule.',
            'date': '07/04/25',
            'action': '/donation'
          },
          {
            'type': 'reminder',
            'title': 'Weekly Giving Reminder',
            'message':
                'Hi Vanessa, your weekly donation to Grace Community Church is due today. Tap here to complete your giving or update your schedule.',
            'date': '07/04/25',
            'action': '/donation'
          },
          {
            'type': 'event',
            'title': 'Beach Cardio This Saturday',
            'message':
                'Faith & Fitness is heading to Seaview Beach at 9 AM. Bring water and energy!',
            'date': '07/04/25',
            'action': null
          },
          {
            'type': 'outreach',
            'title': 'Community Food Outreach Tomorrow',
            'message':
                'The Outreach Team meets at 11 AM to distribute meals downtown. Volunteers still needed!',
            'date': '07/04/25',
            'action': '/volunteer'
          },
          {
            'type': 'event',
            'title': 'May Family Picnic',
            'message':
                'Join us for fun, games, and fellowship! Sunday, May 5th at Central Park.',
            'date': '07/04/25',
            'action': '/events'
          },
          {
            'type': 'study',
            'title': 'Bible Study Group Tonight at 7 PM',
            'message':
                'Don\'t forget! We\'re diving into the Book of James together. Zoom link available in the group chat.',
            'date': '07/04/25',
            'action': null
          },
        ];
      };

  // Navigate to the target page when announcement is tapped
  void _handleAnnouncementTap(Map<String, dynamic> announcement) {
    if (announcement['action'] != null) {
      Navigator.pushNamed(context, announcement['action']);
    }
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Announcement",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: afterLoad(child: () {
          return ListView.builder(
            padding: EdgeInsets.only(top: 8),
            itemCount: announcements.length,
            itemBuilder: (context, index) {
              final announcement = announcements[index];
              return _buildAnnouncementCard(announcement);
            },
          );
        }),
      ),
    );
  }

  // Build individual announcement card
  Widget _buildAnnouncementCard(Map<String, dynamic> announcement) {
    // Determine if this is a giving reminder (which has a star indicator)
    final bool isGivingReminder =
        announcement['title'] == 'Weekly Giving Reminder';

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleAnnouncementTap(announcement),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with optional star for reminders
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        announcement['title'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    if (isGivingReminder)
                      Text(
                        " *",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8),

                // Message content
                Text(
                  announcement['message'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 8),

                // Date
                Text(
                  announcement['date'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to get icon based on announcement type
  IconData _getAnnouncementIcon(String type) {
    switch (type) {
      case 'reminder':
        return Icons.notifications;
      case 'event':
        return Icons.event;
      case 'outreach':
        return Icons.volunteer_activism;
      case 'study':
        return Icons.book;
      default:
        return Icons.announcement;
    }
  }
}
