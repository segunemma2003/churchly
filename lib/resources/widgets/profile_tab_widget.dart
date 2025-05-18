import 'package:flutter/material.dart';
import 'package:flutter_app/resources/pages/addresses_page.dart';
import 'package:flutter_app/resources/pages/contactus_page.dart';
import 'package:flutter_app/resources/pages/faq_page.dart';
import 'package:flutter_app/resources/pages/payment_details_page.dart';
import 'package:flutter_app/resources/pages/privacy_page.dart';
import 'package:flutter_app/resources/pages/profile_details_page.dart';
import 'package:flutter_app/resources/pages/terms_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  createState() => _ProfileTabState();
}

class _ProfileTabState extends NyState {
  @override
  get init => () {};

  @override
  Widget view(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background elements
          Column(
            children: [
              // Background image
              Container(
                height: 200, // Adjust this height as needed
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('background.png').localAsset(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // White space below the background image
              Container(
                color: Colors.white,
                height: 60, // Half the profile picture height
              ),
              // Rest of the content
              _buildContentSection(),
            ],
          ),

          // Profile picture overlapping both sections
          Positioned(
            top: 130, // Adjust this to position the avatar properly
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('profile_image.jpg').localAsset(),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Vanessa Hudgens',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
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

  Widget _buildContentSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(
          16, 60, 16, 16), // Top padding to account for the name
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildProfileItem(
            icon: Icons.person_outline,
            title: 'Profile details',
            onTap: () {
              routeTo(ProfileDetailsPage.path);
            },
          ),
          _buildProfileItem(
            icon: Icons.location_on_outlined,
            title: 'Addresses',
            onTap: () {
              routeTo(AddressesPage.path);
            },
          ),
          _buildProfileItem(
            icon: Icons.payment_outlined,
            title: 'Payment details',
            onTap: () {
              routeTo(PaymentDetailsPage.path);
            },
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              'Support',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildProfileItem(
            icon: Icons.message_outlined,
            title: 'Contact Us',
            onTap: () {
              routeTo(ContactusPage.path);
            },
          ),
          _buildProfileItem(
            icon: Icons.help_outline,
            title: 'FAQs',
            onTap: () {
              routeTo(FaqPage.path);
            },
          ),
          _buildProfileItem(
            icon: Icons.description_outlined,
            title: 'Terms and Condition',
            onTap: () {
              routeTo(TermsPage.path);
            },
          ),
          _buildProfileItem(
            icon: Icons.shield_outlined,
            title: 'Privacy Policy',
            onTap: () {
              routeTo(PrivacyPage.path);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey.shade700, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
