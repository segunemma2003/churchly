import 'package:flutter/material.dart';
import 'package:flutter_app/resources/pages/event_details_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({super.key});

  @override
  createState() => _EventsTabState();
}

class _EventsTabState extends NyState<EventsTab> {
  // Mock event data
  List<Map<String, dynamic>> events = [];
  String nextEventId = '';

  @override
  get init => () {
        // Initialize event data
        // Note: To test empty state, set this to an empty list: events = [];
        events = [
          {
            'id': 'youth_worship',
            'title': 'Youth Worship Night',
            'description':
                'Come experience a powerful evening of worship, prayer, and fellowship at Youth Worship Night. Whether you\'re new to ...',
            'date': 'Sat 26th April, 2023',
            'imageTag': 'Youth',
            'category': 'youth'
          },
          {
            'id': 'bible_study',
            'title': 'Bible Study Group',
            'description':
                'Join us for a weekly Bible study where we explore Scripture, share insights, and support each other in our walk with Chr ...',
            'date': 'Sat 26th April, 2023',
            'imageTag': 'Bible Study',
            'category': 'study'
          },
          {
            'id': 'food_outreach',
            'title': 'Community Food Outreach',
            'description':
                'Be the hands and feet of Jesus by helping us provide meals and essential supplies to those in need. Volunteers are welcome t...',
            'date': 'Sat 26th April, 2023',
            'imageTag': 'Outreach',
            'category': 'outreach'
          },
          {
            'id': 'family_picnic',
            'title': 'May Family Picnic',
            'description':
                'Bring the whole family out for a joyful afternoon at the park! There\'ll be games, music, food, and time to connect with ...',
            'date': 'Sat 26th April, 2023',
            'imageTag': 'Picnic',
            'category': 'family'
          },
        ];

        // Set the next event ID (could be determined by date in a real app)
        nextEventId = events.isNotEmpty ? 'youth_worship' : '';
      };

  void _navigateToEventDetails(Map<String, dynamic> event) {
    // In a real app, you'd navigate to event details
    // e.g., Navigator.pushNamed(context, '/event_details', arguments: event);

    routeTo(EventDetailsPage.path);
    // For now, just show a toast
    // showToast(
    //   title: event['title'],
    //   description: "Viewing event details",
    //   icon: Icons.event,
    // );
  }

  @override
  Widget view(BuildContext context) {
    return afterLoad(child: () {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          // Title
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
            child: Text(
              "Events",
              style: TextStyle(
                color: Color(0xFF0A2042),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          Expanded(
            child: events.isEmpty
                ? _buildEmptyState()
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Next Event Section
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          child: Text(
                            "This is the Next Event",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ),

                        // Feature next event card
                        _buildFeatureEventCard(events
                            .firstWhere((event) => event['id'] == nextEventId)),

                        // After Youth Worship Night Section
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          child: Text(
                            "After Youth Worship Night",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ),

                        // Other events
                        ...events
                            .where((event) => event['id'] != nextEventId)
                            .map((event) => _buildEventCard(event))
                            .toList(),

                        SizedBox(height: 24), // Extra space at bottom
                      ],
                    ),
                  ),
          ),
        ],
      );
    });
  }

  // Build the featured event card
  Widget _buildFeatureEventCard(Map<String, dynamic> event) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          onTap: () => _navigateToEventDetails(event),
          borderRadius: BorderRadius.circular(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Image Container (left placeholder for actual image)
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: Container(
                  width: 120,
                  height: 140,
                  color: Colors.grey[200],
                  child: Stack(
                    children: [
                      // Image placeholder - you can replace this with your image loading
                      Center(
                        child: Icon(
                          Icons.image,
                          size: 40,
                          color: Colors.grey[400],
                        ),
                      ),

                      // Category Tag
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xFF0A2042).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            event['imageTag'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Event details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        event['description'],
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            event['date'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black45,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build regular event cards
  Widget _buildEventCard(Map<String, dynamic> event) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          onTap: () => _navigateToEventDetails(event),
          borderRadius: BorderRadius.circular(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Image Container (left placeholder for actual image)
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: Container(
                  width: 94,
                  height: 94,
                  color: Colors.grey[200],
                  child: Stack(
                    children: [
                      // Image placeholder - you can replace this with your image loading
                      Center(
                        child: Icon(
                          Icons.image,
                          size: 32,
                          color: Colors.grey[400],
                        ),
                      ),

                      // Category Tag
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xFF0A2042).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            event['imageTag'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Event details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event['title'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        event['description'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            event['date'],
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black45,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Empty state when no events are available - for ListView
  Widget _buildEmptyState() {
    return Container(
      height: 500, // Provide enough height to center content
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "There's Nothing to see here",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                "You have no Events yet. Join a church and group to get started",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
