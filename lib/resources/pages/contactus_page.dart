import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactusPage extends NyStatefulWidget {
  static RouteView path = ("/contactus", (_) => ContactusPage());

  ContactusPage({super.key}) : super(child: () => _ContactusPageState());
}

class _ContactusPageState extends NyPage<ContactusPage> {
  // Contact options
  late List<ContactOption> contactOptions;

  @override
  get init => () {
        // Initialize contact options with the correct images and icons
        contactOptions = [
          ContactOption(
            imageAsset: 'whatsapp.png',
            title: "Chat on Whatsapp",
            onTap: () async {
              final Uri whatsappUrl = Uri.parse(
                  'https://wa.me/1234567890'); // Replace with your WhatsApp number
              if (await canLaunchUrl(whatsappUrl)) {
                await launchUrl(whatsappUrl);
              }
            },
          ),
          ContactOption(
            icon: Icons.email_outlined,
            title: "Email",
            onTap: () async {
              final Uri emailUrl = Uri.parse(
                  'mailto:support@example.com'); // Replace with your email
              if (await canLaunchUrl(emailUrl)) {
                await launchUrl(emailUrl);
              }
            },
          ),
        ];
      };

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Contact Us",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: contactOptions.length,
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          itemBuilder: (context, index) {
            final option = contactOptions[index];
            return ListTile(
              leading: option.imageAsset != null
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        option.imageAsset!,
                      ).localAsset(),
                    )
                  : Icon(
                      option.icon!,
                      size: 24,
                      color: Colors.black87,
                    ),
              title: Text(
                option.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              onTap: option.onTap,
            );
          },
        ),
      ),
    );
  }
}

// Updated model for contact options to support both icons and images
class ContactOption {
  final IconData? icon;
  final String? imageAsset;
  final String title;
  final Function() onTap;

  ContactOption({
    this.icon,
    this.imageAsset,
    required this.title,
    required this.onTap,
  }) : assert(icon != null || imageAsset != null,
            'Either icon or imageAsset must be provided');
}
