import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class EventDetailsPage extends NyStatefulWidget {
  static RouteView path = ("/event-details", (_) => EventDetailsPage());

  EventDetailsPage({super.key}) : super(child: () => _EventDetailsPageState());
}

class _EventDetailsPageState extends NyPage<EventDetailsPage> {
  // Event data - in a real app, this would be passed via route parameters
  Map<String, dynamic>? eventData;
  bool seatsReserved = false;

  @override
  get init => () async {
        // In a real app, you would get the event data from the route parameters
        // Sample data for demonstration
        eventData = {
          'id': 'youth_worship',
          'title': 'Youth Worship Night',
          'description':
              'Come experience a powerful evening of worship, prayer, and fellowship at Youth Worship Night. Whether you\'re new to the faith or growing deeper in your walk with God, this is a space for young hearts to gather, lift their voices, and encounter the presence of God together. Expect live worship, real conversations, and a spirit-filled atmosphere that will leave you refreshed and inspired.',
          'date': 'Saturday 26th April,2025',
          'time': '9:00PM -11:00PM',
          'location': 'The Bridge Church, Main Hall, Off Crawashore road.',
          'hosts': 'Pastor Josh and the Worship team',
          'imageUrl':
              "youth1.jpg", // This would be the actual image URL in a real app
          'totalSeats': 100,
          'availableSeats': 35,
        };
      };

  void _toggleSeatReservation() {
    setState(() {
      seatsReserved = !seatsReserved;
    });

    if (seatsReserved) {
      showToast(
        title: "Seat Reserved",
        description: "You have successfully reserved a seat for this event.",
        icon: Icons.check_circle,
        style: ToastNotificationStyleType.success,
      );
    }
  }

  @override
  Widget view(BuildContext context) {
    if (eventData == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Column(
        children: [
          // App bar with back button
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black87),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "Event Details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content area (scrollable)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event image section
                  Stack(
                    children: [
                      // Image placeholder
                      Container(
                          width: double.infinity,
                          height: 220,
                          color: Colors.grey[800],
                          // In a real app, you would use Image.network or Image.asset
                          // Image.network(eventData!['imageUrl'], fit: BoxFit.cover)

                          child: Image.asset(
                            eventData!['imageUrl'],
                            fit: BoxFit.cover,
                          ).localAsset()),

                      // Event title overlay at the bottom of the image
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
                            eventData!['title'],
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

                  // Event details section
                  Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Event details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 16),

                        // Date
                        _buildDetailRow(
                          icon: Icons.calendar_today,
                          iconColor: Color(0xFF0A2042),
                          title: "Date",
                          value: eventData!['date'],
                        ),

                        SizedBox(height: 16),

                        // Time
                        _buildDetailRow(
                          icon: Icons.access_time,
                          iconColor: Color(0xFF0A2042),
                          title: "Time",
                          value: eventData!['time'],
                        ),

                        SizedBox(height: 16),

                        // Location
                        _buildDetailRow(
                          icon: Icons.location_on,
                          iconColor: Color(0xFF0A2042),
                          title: "Location",
                          value: eventData!['location'],
                        ),

                        SizedBox(height: 16),

                        // Hosts
                        _buildDetailRow(
                          icon: Icons.person,
                          iconColor: Color(0xFF0A2042),
                          title: "Event Hosts",
                          value: eventData!['hosts'],
                        ),

                        SizedBox(height: 24),

                        // Event description
                        Text(
                          "Event description",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          eventData!['description'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),

                        SizedBox(height: 16),

                        // Additional info
                        Text(
                          "Open to all teens and young adults. Bring a friend",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),

                        SizedBox(height: 24),

                        // Available seats
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.event_seat, color: Color(0xFF0A2042)),
                            SizedBox(width: 8),
                            Text(
                              "${eventData!['availableSeats']} seats saved",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16),

                        // "Are you interested?" text
                        Center(
                          child: Text(
                            "Are you interested?",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),

                        SizedBox(height: 16),

                        // Save a seat button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _toggleSeatReservation,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0A2042),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              seatsReserved
                                  ? "Cancel Reservation"
                                  : "Save a seat",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 24),
                      ],
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

  // Helper method to build detail rows
  Widget _buildDetailRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: iconColor.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(8),
          child: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
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
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
