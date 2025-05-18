import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class PrivacyPage extends NyStatefulWidget {
  static RouteView path = ("/privacy", (_) => PrivacyPage());

  PrivacyPage({super.key}) : super(child: () => _PrivacyPageState());
}

class _PrivacyPageState extends NyPage<PrivacyPage> {
  // Content for privacy policy
  final List<PrivacySection> sections = [
    PrivacySection(
      title: "1. Information We Collect",
      content:
          "We collect several different types of information for various purposes to provide and improve our service to you:\n\n• Personal Data: While using our Application, we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you.\n\n• Usage Data: We may also collect information on how the Application is accessed and used.",
    ),
    PrivacySection(
      title: "2. Use of Data",
      content:
          "We use the collected data for various purposes:\n\n• To provide and maintain our service\n• To notify you about changes to our service\n• To provide customer support\n• To gather analysis or valuable information so that we can improve our service\n• To monitor the usage of our service\n• To detect, prevent and address technical issues",
    ),
    PrivacySection(
      title: "3. Transfer of Data",
      content:
          "Your information, including Personal Data, may be transferred to — and maintained on — computers located outside of your state, province, country or other governmental jurisdiction where the data protection laws may differ from those of your jurisdiction.",
    ),
    PrivacySection(
      title: "4. Disclosure of Data",
      content:
          "We may disclose your Personal Data in the good faith belief that such action is necessary to:\n\n• Comply with a legal obligation\n• Protect and defend the rights or property of our company\n• Prevent or investigate possible wrongdoing in connection with the service\n• Protect the personal safety of users of the service or the public\n• Protect against legal liability",
    ),
    PrivacySection(
      title: "5. Security of Data",
      content:
          "The security of your data is important to us, but remember that no method of transmission over the Internet or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your Personal Data, we cannot guarantee its absolute security.",
    ),
    PrivacySection(
      title: "6. Your Data Protection Rights",
      content:
          "You have the right to access, update or delete the information we have on you. Whenever made possible, you can access, update or request deletion of your Personal Data directly within your account settings section. If you are unable to perform these actions yourself, please contact us to assist you.",
    ),
    PrivacySection(
      title: "7. Children's Privacy",
      content:
          "Our service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If you are a parent or guardian and you are aware that your child has provided us with Personal Data, please contact us.",
    ),
    PrivacySection(
      title: "8. Changes to This Privacy Policy",
      content:
          "We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the \"Last Updated\" date at the top of this Privacy Policy.",
    ),
    PrivacySection(
      title: "9. Contact Us",
      content:
          "If you have any questions about this Privacy Policy, please contact us through the contact information provided in the Application.",
    ),
  ];

  @override
  get init => () {
        // Initialize anything if needed
      };

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Privacy Policy",
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                "Last Updated: May 17, 2025",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    final section = sections[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          section.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          section.content,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Model class for privacy sections
class PrivacySection {
  final String title;
  final String content;

  PrivacySection({
    required this.title,
    required this.content,
  });
}
