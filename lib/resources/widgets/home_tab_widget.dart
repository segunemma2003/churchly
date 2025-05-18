import 'package:flutter/material.dart';
import 'package:flutter_app/resources/pages/announcement_page.dart';
import 'package:flutter_app/resources/pages/base_navigation_hub.dart';
import 'package:flutter_app/resources/pages/bible_page.dart';
import 'package:flutter_app/resources/pages/donation_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  createState() => _HomeTabState();
}

class _HomeTabState extends NyState<HomeTab> {
  String userName = "Vanesse";
  String nextServiceTime = "00:16hrs:22m:12";
  String serviceDate = "Friday April 25, 2025";
  String serviceTime = "5:30PM";
  String verseOfDay =
      "In the beginning was the Word, and the Word was with God, and the Word was God.";
  String verseReference = "John 1:1";
  String journeyTitle = "Join the journey";
  String journeyDesc = "Discover faith communities where you truly belong.";

  // Sample events data - in a real app this would come from an API
  final List<Map<String, dynamic>> upcomingEvents = [
    {
      "title": "Youth Worship Night",
      "date": "Sat 26th April, 2025",
      "image": "bg.jpg",
      "route": "/events/youth-worship"
    },
    {
      "title": "Bible Study Group",
      "date": "Sat 26th April, 2025",
      "image": "study1.jpg",
      "route": "/events/bible-study"
    },
    {
      "title": "Community Outreach",
      "date": "Sun 27th April, 2025",
      "image": "youth1.jpg",
      "route": "/events/community"
    },
    {
      "title": "Prayer Meeting",
      "date": "Mon 28th April, 2025",
      "image": "bg.jpg",
      "route": "/events/prayer"
    },
    {
      "title": "Choir Practice",
      "date": "Tue 29th April, 2025",
      "image": "study1.jpg",
      "route": "/events/choir"
    }
  ];

  @override
  get init => () {
        // You can initialize data here, like fetching from an API
        loadUser();
        loadNextService();
        loadVerseOfTheDay();
        loadUpcomingEvents();
      };

  // Load user profile data
  void loadUser() async {
    // Example of how you might fetch user data using Nylo
    // final user = await api<UserApi>((api) => api.getUser());
    // setState(() {
    //   userName = user.name;
    // });
  }

  // Load next service information
  void loadNextService() async {
    // Example API call using Nylo
    // final service = await api<ChurchApi>((api) => api.getNextService());
    // setState(() {
    //   nextServiceTime = service.countdown;
    //   serviceDate = service.date;
    //   serviceTime = service.time;
    // });
  }

  // Load verse of the day
  void loadVerseOfTheDay() async {
    // Example of using Nylo storage
    // final verse = await NyStorage.read("verse_of_day");
    // if (verse != null) {
    //   setState(() {
    //     verseOfDay = verse["text"];
    //     verseReference = verse["reference"];
    //   });
    // }
  }

  // Load upcoming events
  void loadUpcomingEvents() async {
    // Example of using Nylo API service
    // final events = await api<EventsApi>((api) => api.getUpcomingEvents());
    // setState(() {
    //   upcomingEvents = events;
    // });
  }

  @override
  Widget view(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header with gradient background
            _buildHeader(),

            // Quick Action Buttons
            _buildQuickActions(),

            // Verse of the day section
            _buildVerseOfTheDay(),

            // Join the journey section
            _buildJoinJourney(),

            // Upcoming events section
            _buildUpcomingEvents(),

            // Bottom padding to account for nav bar
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  // Gradient header with user info and next service
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            getColorFromHex("#5353c6"), // Dark purple
            getColorFromHex("#7a94e5"), // Light blue
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Profile picture
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    "profile_image.jpg",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ).localAsset(),
                ),
              ),
              SizedBox(width: 12),
              Text(
                "Hi $userName",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Next service timer
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Next Service in $nextServiceTime",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(height: 16),
          // Service date and time
          Text(
            serviceDate,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Join us for this Friday service starting at $serviceTime",
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  // Quick action buttons (Bible, Donations, Announcement)
  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24),
      color: Colors.grey[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            icon: Icons.book,
            label: "Bible",
            color: getColorFromHex("#152642"),
            onTap: () {
              // Example of navigation in Nylo
              routeTo(BiblePage.path);
            },
          ),
          _buildActionButton(
            icon: Icons.volunteer_activism,
            label: "Donations",
            color: getColorFromHex("#152642"),
            onTap: () {
              routeTo(DonationPage.path);
            },
          ),
          _buildActionButton(
            icon: Icons.campaign,
            label: "Announcement",
            color: getColorFromHex("#152642"),
            onTap: () {
              routeTo(AnnouncementPage.path);
            },
          ),
        ],
      ),
    );
  }

  // Helper to build circular action button
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue[50],
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // Verse of the day section
  Widget _buildVerseOfTheDay() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Verse of the day",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  routeTo('/verses');
                },
                icon: Text(
                  "All this week",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                label: Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          // Verse card
          Container(
            width: double.infinity,
            height: 200, // Fixed height to match the image
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  // Bible image with proper fit
                  Positioned.fill(
                    child: Image.asset(
                      "bg.jpg",
                      fit: BoxFit.cover,
                    ).localAsset(),
                  ),

                  // Semi-transparent overlay
                  Positioned.fill(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      color: Colors.black.withOpacity(0.4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Date
                          Text(
                            "24th april, 2025",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          SizedBox(height: 16),
                          // Verse text
                          Text(
                            '"$verseOfDay"',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 16),
                          // Verse reference
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.8)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              verseReference,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
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

  // Join the journey section
  Widget _buildJoinJourney() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Circle pattern
          Container(
            width: 60,
            height: 60,
            child: CustomPaint(
              painter: CirclePatternPainter(),
            ),
          ),
          SizedBox(width: 16),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  journeyTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  journeyDesc,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          // Arrow icon
          Icon(
            Icons.arrow_forward,
            color: Colors.black87,
          ),
        ],
      ),
    );
  }

  // Upcoming events section with horizontal scrolling
  Widget _buildUpcomingEvents() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Upcoming Events",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  routeTo(BaseNavigationHub.path, tabIndex: 1);
                },
                icon: Text(
                  "Events",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                label: Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Horizontal scrollable event cards
          Container(
            height: 180, // Fixed height for the scrollable area
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: upcomingEvents.length,
              itemBuilder: (context, index) {
                final event = upcomingEvents[index];
                return Container(
                  width: 170, // Fixed width for each card
                  margin: EdgeInsets.only(
                      right: index == upcomingEvents.length - 1 ? 0 : 12),
                  child: _buildEventCard(
                    title: event["title"],
                    date: event["date"],
                    assetImage: event["image"],
                    imageHeight: 120,
                    onTap: () => routeTo(event["route"]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Event card widget
  Widget _buildEventCard({
    required String title,
    required String date,
    required double imageHeight,
    required VoidCallback onTap,
    String? assetImage,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Container(
                width: double.infinity, // Ensure full width
                height: imageHeight,
                child: assetImage != null
                    ? Image.asset(
                        assetImage,
                        fit: BoxFit.cover, // Ensure image fills container
                      ).localAsset()
                    : placeholderImage(height: imageHeight, fit: BoxFit.cover),
              ),
            ),
            // Event details
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          date,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: 14,
                        color: Colors.grey[600],
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

  // Helper to create image placeholders until you add real images
  Widget placeholderImage({
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: Center(
        child: Icon(
          Icons.image,
          color: Colors.grey[400],
          size: 24,
        ),
      ),
    );
  }

  // Helper function to convert hex color string to Color
  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}

// Custom painter for the circle pattern in "Join the journey" section
class CirclePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF0f4c81) // Use direct color value instead of HexColor
      ..style = PaintingStyle.fill;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = 4.0;

    // Circle pattern as shown in the image
    // Center circle
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);

    // Outer circles
    final double distanceFromCenter = 12.0;

    // Top, Right, Bottom, Left circles
    canvas.drawCircle(
        Offset(centerX, centerY - distanceFromCenter), radius, paint);
    canvas.drawCircle(
        Offset(centerX + distanceFromCenter, centerY), radius, paint);
    canvas.drawCircle(
        Offset(centerX, centerY + distanceFromCenter), radius, paint);
    canvas.drawCircle(
        Offset(centerX - distanceFromCenter, centerY), radius, paint);

    // Diagonal circles
    final double diagonalDistance = distanceFromCenter * 0.7;

    // Top-right, Bottom-right, Bottom-left, Top-left
    canvas.drawCircle(
        Offset(centerX + diagonalDistance, centerY - diagonalDistance),
        radius,
        paint);
    canvas.drawCircle(
        Offset(centerX + diagonalDistance, centerY + diagonalDistance),
        radius,
        paint);
    canvas.drawCircle(
        Offset(centerX - diagonalDistance, centerY + diagonalDistance),
        radius,
        paint);
    canvas.drawCircle(
        Offset(centerX - diagonalDistance, centerY - diagonalDistance),
        radius,
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
