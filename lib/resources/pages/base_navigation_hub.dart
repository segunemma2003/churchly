import 'package:flutter/material.dart';
import 'package:flutter_app/resources/widgets/church_tab_widget.dart';
import 'package:flutter_app/resources/widgets/events_tab_widget.dart';
import 'package:flutter_app/resources/widgets/groups_tab_widget.dart';
import 'package:flutter_app/resources/widgets/home_tab_widget.dart';
import 'package:flutter_app/resources/widgets/profile_tab_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';

class BaseNavigationHub extends NyStatefulWidget with BottomNavPageControls {
  static RouteView path = ("/base", (_) => BaseNavigationHub());

  BaseNavigationHub()
      : super(
            child: () => _BaseNavigationHubState(),
            stateName: path.stateName());

  /// State actions
  static NavigationHubStateActions stateActions =
      NavigationHubStateActions(path.stateName());
}

class _BaseNavigationHubState extends NavigationHub<BaseNavigationHub> {
  /// Layouts:
  /// - [NavigationHubLayout.bottomNav] Bottom navigation
  /// - [NavigationHubLayout.topNav] Top navigation
  /// - [NavigationHubLayout.journey] Journey navigation
  NavigationHubLayout? layout = NavigationHubLayout.bottomNav(
    // Default settings, will be overridden in the builder
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: true,
    showUnselectedLabels: true,
  );

  /// Should the state be maintained
  @override
  bool get maintainState => true;

  /// Navigation pages
  _BaseNavigationHubState()
      : super(() async {
          return {
            0: NavigationTab(
              title: "Home",
              page: HomeTab(),
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
            ),
            1: NavigationTab(
              title: "Events",
              page: EventsTab(),
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
            ),
            2: NavigationTab(
              title: "Church",
              page: ChurchTab(),
              icon: Icon(Icons.church_outlined),
              activeIcon: Icon(Icons.church),
            ),
            3: NavigationTab(
              title: "Groups",
              page: GroupsTab(),
              icon: Icon(Icons.bubble_chart_outlined),
              activeIcon: Icon(Icons.bubble_chart),
            ),
            4: NavigationTab(
              title: "Profile",
              page: ProfileTab(),
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
            ),
          };
        });

  @override
  Widget bottomNavBuilder(
      BuildContext context, Widget body, Widget? bottomNavigationBar) {
    // Get access to the original navigation items
    final BottomNavigationBar originalBar =
        bottomNavigationBar as BottomNavigationBar;

    // Define the exact color from your design - UPDATED to match the image
    final Color activeIconColor = Colors.black; // Black for active icons
    final Color inactiveIconColor = Colors.grey; // Grey for inactive icons
    final Color backgroundColor = Colors.white; // White background

    return Scaffold(
      body: body,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildNavItem(0, Icons.home_outlined, Icons.home, "Home",
                  activeIconColor, inactiveIconColor),
              _buildNavItem(
                  1,
                  Icons.calendar_today_outlined,
                  Icons.calendar_today,
                  "Events",
                  activeIconColor,
                  inactiveIconColor),
              _buildNavItem(2, Icons.church_outlined, Icons.church, "Church",
                  activeIconColor, inactiveIconColor),
              _buildGroupsNavItem(3, activeIconColor, inactiveIconColor),
              _buildNavItem(4, Icons.person_outline, Icons.person, "Profile",
                  activeIconColor, inactiveIconColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index,
      IconData inactiveIconData,
      IconData activeIconData,
      String label,
      Color activeColor,
      Color inactiveColor) {
    bool isActive = getCurrentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        child: Container(
          height: 70,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isActive ? activeIconData : inactiveIconData,
                  color: isActive ? activeColor : inactiveColor,
                  size: 24,
                ),
                SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    color: isActive ? activeColor : inactiveColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGroupsNavItem(
      int index, Color activeColor, Color inactiveColor) {
    bool isActive = getCurrentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        child: Container(
          height: 70,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CustomPaint(
                    painter: CirclePatternPainter(
                      isActive: isActive,
                      activeColor: activeColor,
                      inactiveColor: inactiveColor,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Groups",
                  style: TextStyle(
                    fontSize: 10,
                    color: isActive ? activeColor : inactiveColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Handle the tap event
  @override
  onTap(int index) {
    super.onTap(index);
  }
}

class CirclePatternPainter extends CustomPainter {
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;

  CirclePatternPainter({
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isActive ? activeColor : inactiveColor
      ..style = PaintingStyle.fill;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = 2.0;

    // Center circle
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);

    // Create the pattern of circles as shown in the image
    final double distanceFromCenter = 6.0;

    // Top
    canvas.drawCircle(
        Offset(centerX, centerY - distanceFromCenter), radius, paint);

    // Right
    canvas.drawCircle(
        Offset(centerX + distanceFromCenter, centerY), radius, paint);

    // Bottom
    canvas.drawCircle(
        Offset(centerX, centerY + distanceFromCenter), radius, paint);

    // Left
    canvas.drawCircle(
        Offset(centerX - distanceFromCenter, centerY), radius, paint);

    // Diagonal circles
    final double diagonalDistance = distanceFromCenter * 0.7;

    // Top-right
    canvas.drawCircle(
        Offset(centerX + diagonalDistance, centerY - diagonalDistance),
        radius,
        paint);

    // Bottom-right
    canvas.drawCircle(
        Offset(centerX + diagonalDistance, centerY + diagonalDistance),
        radius,
        paint);

    // Bottom-left
    canvas.drawCircle(
        Offset(centerX - diagonalDistance, centerY + diagonalDistance),
        radius,
        paint);

    // Top-left
    canvas.drawCircle(
        Offset(centerX - diagonalDistance, centerY - diagonalDistance),
        radius,
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
