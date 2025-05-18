import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ProfileDetailsPage extends NyStatefulWidget {
  static RouteView path = ("/profile-details", (_) => ProfileDetailsPage());

  ProfileDetailsPage({super.key})
      : super(child: () => _ProfileDetailsPageState());
}

class _ProfileDetailsPageState extends NyPage<ProfileDetailsPage> {
  // Controllers for the text fields
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  get init => () {
        // Initialize controllers with default values
        nameController = TextEditingController(text: "Vanessa Hudgens");
        emailController = TextEditingController(text: "hudgvan@hotmail.com");
        phoneController = TextEditingController(text: "hudgvan@hotmail.com");
      };

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile Details",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.indigo, // Adjust to match your app's theme
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.indigo, // Adjust to match your app's theme
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: false, // Left-aligned title as shown in the image
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile photo section
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.grey[50],
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'profile_image.jpg',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ).localAsset(),
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: () {
                        // Handle change profile photo
                      },
                      child: const Text(
                        "Change Profile Photo",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Form fields
              const SizedBox(height: 16),
              _buildFormField(
                label: "Full Name",
                controller: nameController,
                canEdit: true,
              ),

              _buildFormField(
                label: "Email",
                controller: emailController,
                canEdit: true,
                showVisibilityToggle: true,
              ),

              _buildFormField(
                label: "Phone number",
                controller: phoneController,
                canEdit: true,
                showVisibilityToggle: true,
              ),

              // Additional space at the bottom
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    bool canEdit = false,
    bool showVisibilityToggle = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    enabled: canEdit,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      hintText: "Enter your $label",
                    ),
                  ),
                ),
                if (canEdit)
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20, color: Colors.grey),
                    onPressed: () {
                      // Focus on this field
                    },
                  ),
                if (showVisibilityToggle)
                  IconButton(
                    icon: const Icon(Icons.visibility_off,
                        size: 20, color: Colors.grey),
                    onPressed: () {
                      // Toggle visibility
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
