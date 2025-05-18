import 'package:flutter/material.dart';
import 'package:flutter_app/app/models/faq.dart';
import 'package:nylo_framework/nylo_framework.dart';

class FaqdetailsPage extends NyStatefulWidget {
  static RouteView path = ("/faqdetails", (_) => FaqdetailsPage());

  FaqdetailsPage({super.key}) : super(child: () => _FaqdetailsPageState());
}

class _FaqdetailsPageState extends NyPage<FaqdetailsPage> {
  late Faq faq;

  @override
  get init => () {
        // Get the FAQ from the widget data using Nylo 6 approach
        Map<String, dynamic> data = widget.data();
        faq = data["faq"];
      };

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          faq.question,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
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
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                faq.answer,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
