import 'package:flutter/material.dart';
import 'package:flutter_app/resources/pages/faqdetails_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../app/models/faq.dart';

class FaqPage extends NyStatefulWidget {
  static RouteView path = ("/faq", (_) => FaqPage());

  FaqPage({super.key}) : super(child: () => _FaqPageState());
}

class _FaqPageState extends NyPage<FaqPage> {
  // List of FAQs
  final List<Faq> faqs = [
    Faq(
      question: "How do I find and join a church near me?",
      answer:
          "When you tap on the \"Search\" tab, Churchly will ask to use your location to show churches near you. You can also search by name or city. Once you find a church you like, tap \"Join Church\" on their profile to stay updated on their events, groups, and giving options.",
    ),
    Faq(
      question: "Can we do surgeries through the application",
      answer:
          "No, our application does not provide medical services. It is designed to help you connect with churches and religious communities only. For medical services, please consult with healthcare professionals.",
    ),
    Faq(
      question: "How do I make donations to my church?",
      answer:
          "After joining a church, you can navigate to their profile and select the \"Give\" option. You can set up one-time or recurring donations using various payment methods including credit/debit cards and bank transfers.",
    ),
    Faq(
      question: "How can I find events at my church?",
      answer:
          "Once you've joined a church, all their upcoming events will appear in your \"Events\" feed. You can also visit the church's profile page to see a complete calendar of events and RSVP to those you plan to attend.",
    ),
    Faq(
      question: "Is my personal information secure?",
      answer:
          "Yes, we take data security very seriously. All personal information and payment details are encrypted using industry-standard protocols. We do not share your information with third parties without your explicit consent. For more details, please review our Privacy Policy.",
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
          "FAQs",
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
          itemCount: faqs.length,
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            thickness: 1,
          ),
          itemBuilder: (context, index) {
            final faq = faqs[index];
            return ListTile(
              title: Text(
                faq.question,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              onTap: () {
                // Navigate to FAQ details page
                routeTo(FaqdetailsPage.path, data: {"faq": faq});
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => FaqdetailsPage(faq: faq),
                //   ),
                // );
              },
            );
          },
        ),
      ),
    );
  }
}

// FAQ model
