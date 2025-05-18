import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class TermsPage extends NyStatefulWidget {
  static RouteView path = ("/terms", (_) => TermsPage());

  TermsPage({super.key}) : super(child: () => _TermsPageState());
}

class _TermsPageState extends NyPage<TermsPage> {
  // Content for terms and conditions
  final List<TermsSection> sections = [
    TermsSection(
      title: "1. Introduction",
      content:
          "Welcome to our application. These Terms and Conditions govern your use of our application and services. By accessing or using our application, you agree to be bound by these Terms and Conditions.",
    ),
    TermsSection(
      title: "2. Definitions",
      content:
          "\"Application\" means the mobile application operated by us.\n\"Services\" means all services provided by us through the Application.\n\"User\", \"You\" and \"Your\" refers to the individual accessing or using the Application.",
    ),
    TermsSection(
      title: "3. Account Registration",
      content:
          "To use certain features of the Application, you may be required to register for an account. You agree to provide accurate, current, and complete information during the registration process and to update such information to keep it accurate, current, and complete.",
    ),
    TermsSection(
      title: "4. User Responsibilities",
      content:
          "You are responsible for maintaining the confidentiality of your account information, including your password. You agree to accept responsibility for all activities that occur under your account.",
    ),
    TermsSection(
      title: "5. Acceptable Use",
      content:
          "You agree not to use the Application for any illegal or unauthorized purpose. You agree to comply with all laws, rules, and regulations applicable to your use of the Application.",
    ),
    TermsSection(
      title: "6. Intellectual Property",
      content:
          "The Application and its original content, features, and functionality are owned by us and are protected by international copyright, trademark, patent, trade secret, and other intellectual property laws.",
    ),
    TermsSection(
      title: "7. Termination",
      content:
          "We may terminate or suspend your account and bar access to the Application immediately, without prior notice or liability, under our sole discretion, for any reason whatsoever.",
    ),
    TermsSection(
      title: "8. Limitation of Liability",
      content:
          "In no event shall we be liable for any indirect, incidental, special, consequential or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses, resulting from your access to or use of or inability to access or use the Application.",
    ),
    TermsSection(
      title: "9. Changes to Terms",
      content:
          "We reserve the right, at our sole discretion, to modify or replace these Terms at any time. It is your responsibility to check these Terms periodically for changes.",
    ),
    TermsSection(
      title: "10. Contact Us",
      content:
          "If you have any questions about these Terms, please contact us through the provided contact information in the Application.",
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
          "Terms and Condition",
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

// Model class for terms sections
class TermsSection {
  final String title;
  final String content;

  TermsSection({
    required this.title,
    required this.content,
  });
}
