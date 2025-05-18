import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class DonationPage extends NyStatefulWidget {
  static RouteView path = ("/donation", (_) => DonationPage());

  DonationPage({super.key}) : super(child: () => _DonationPageState());
}

class _DonationPageState extends NyPage<DonationPage> {
  // Tab controller for switching between donate now and history
  int _selectedTabIndex = 0;

  // Form values
  String? selectedFund;
  String frequency = 'One time';
  double? customAmount;
  double selectedAmount = 0;
  String paymentMethod = 'Debit/Credit Card';

  // Mock donation history data
  final List<Map<String, dynamic>> donationHistory = List.generate(
      12,
      (index) => {
            'fund': 'Building and renovation fund',
            'date': 'Sat 26th April, 2025 by 11:59PM',
            'amount': 150.0,
            'type': 'One Time'
          });

  // Fund options
  final List<String> fundOptions = [
    'General Fund',
    'Building and renovation fund',
    'Missionary Support',
    'Youth Ministry',
    'Community Outreach'
  ];

  @override
  get init => () {
        // Initialize with default values
        selectedFund = fundOptions[0];
      };

  // Handle donation submission
  void _handleDonation() {
    if (selectedFund == null || selectedAmount <= 0) {
      showToast(
        title: "Incomplete Form",
        description: "Please fill in all required fields.",
        icon: Icons.warning,
      );
      return;
    }

    // Process donation - would connect to payment API in a real app
    showToast(
      title: "Thank You!",
      description:
          "Your donation of \$${selectedAmount.toStringAsFixed(2)} has been processed.",
      icon: Icons.check_circle,
      style: ToastNotificationStyleType.success,
    );

    // For demo purposes, add to history and switch to history tab
    setState(() {
      donationHistory.insert(0, {
        'fund': selectedFund,
        'date': 'Sat 26th April, 2025 by 11:59PM',
        'amount': selectedAmount,
        'type': frequency
      });

      // Reset form
      customAmount = null;
      selectedAmount = 0;

      // Switch to history tab
      _selectedTabIndex = 1;
    });
  }

  void _setAmount(double amount) {
    setState(() {
      selectedAmount = amount;
      customAmount = null;
    });
  }

  void _setCustomAmount(String value) {
    if (value.isEmpty) {
      setState(() {
        customAmount = null;
        selectedAmount = 0;
      });
      return;
    }

    try {
      final amount = double.parse(value);
      setState(() {
        customAmount = amount;
        selectedAmount = amount;
      });
    } catch (e) {
      // Invalid number
    }
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Donate",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Tab selector
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: _buildTabButton(
                      "Donate Now",
                      isSelected: _selectedTabIndex == 0,
                      onTap: () => setState(() => _selectedTabIndex = 0),
                    ),
                  ),
                  Expanded(
                    child: _buildTabButton(
                      "Donation History",
                      isSelected: _selectedTabIndex == 1,
                      onTap: () => setState(() => _selectedTabIndex = 1),
                    ),
                  ),
                ],
              ),
            ),

            Divider(height: 1),

            // Tab content
            Expanded(
              child: _selectedTabIndex == 0
                  ? _buildDonationForm()
                  : _buildDonationHistory(),
            ),
          ],
        ),
      ),
    );
  }

  // Tab Button
  Widget _buildTabButton(String text,
      {required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF0A2042) : Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // Donation Form
  Widget _buildDonationForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fund Selection
          Text(
            "Which Fund",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedFund,
                isExpanded: true,
                hint: Text("Select Fund to donate to"),
                icon: Icon(Icons.keyboard_arrow_down),
                padding: EdgeInsets.symmetric(horizontal: 16),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedFund = newValue;
                  });
                },
                items:
                    fundOptions.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),

          SizedBox(height: 24),

          // Frequency
          Row(
            children: [
              Text(
                "Frequency",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 8),
              Text(
                "(How often would you donate?)",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildFrequencyButton(
                    "One time",
                    frequency == "One time",
                    () => setState(() => frequency = "One time")),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildFrequencyButton("Weekly", frequency == "Weekly",
                    () => setState(() => frequency = "Weekly")),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildFrequencyButton("Monthly", frequency == "Monthly",
                    () => setState(() => frequency = "Monthly")),
              ),
            ],
          ),

          SizedBox(height: 24),

          // Amount to Donate
          Text(
            "Amount to Donate",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),

          // Custom Amount
          TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: "Custom Amount",
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: _setCustomAmount,
          ),

          SizedBox(height: 8),

          // Amount Options
          Row(
            children: [
              Expanded(
                child: _buildAmountButton(
                    10, selectedAmount == 10 && customAmount == null),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildAmountButton(
                    25, selectedAmount == 25 && customAmount == null),
              ),
            ],
          ),

          SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: _buildAmountButton(
                    50, selectedAmount == 50 && customAmount == null),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildAmountButton(
                    100, selectedAmount == 100 && customAmount == null),
              ),
            ],
          ),

          SizedBox(height: 24),

          // Payment Method
          Text(
            "Payment Method",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: _buildPaymentMethodButton(
                  "Debit/Credit Card",
                  Icons.credit_card,
                  paymentMethod == "Debit/Credit Card",
                  () => setState(() => paymentMethod = "Debit/Credit Card"),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildPaymentMethodButton(
                  "Bank Transfer",
                  Icons.account_balance,
                  paymentMethod == "Bank Transfer",
                  () => setState(() => paymentMethod = "Bank Transfer"),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildPaymentMethodButton(
                  "Cashapp",
                  Icons.attach_money,
                  paymentMethod == "Cashapp",
                  () => setState(() => paymentMethod = "Cashapp"),
                ),
              ),
            ],
          ),

          SizedBox(height: 32),

          // Proceed Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: selectedAmount > 0 ? _handleDonation : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0A2042),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                disabledBackgroundColor: Colors.grey.shade300,
              ),
              child: Text(
                "Proceed to Donate",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  // Donation History
  Widget _buildDonationHistory() {
    return ListView.separated(
      padding: EdgeInsets.all(16),
      itemCount: donationHistory.length,
      separatorBuilder: (context, index) => Divider(height: 1),
      itemBuilder: (context, index) {
        final donation = donationHistory[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      donation['fund'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      donation['date'],
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    donation['type'],
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "\$${donation['amount'].toStringAsFixed(0)}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper widgets
  Widget _buildFrequencyButton(
      String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Color(0xFF0A2042) : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(4),
          color:
              isSelected ? Color(0xFF0A2042).withOpacity(0.05) : Colors.white,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Color(0xFF0A2042) : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildAmountButton(double amount, bool isSelected) {
    return GestureDetector(
      onTap: () => _setAmount(amount),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Color(0xFF0A2042) : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(4),
          color:
              isSelected ? Color(0xFF0A2042).withOpacity(0.05) : Colors.white,
        ),
        alignment: Alignment.center,
        child: Text(
          "\$${amount.toInt()}",
          style: TextStyle(
            color: isSelected ? Color(0xFF0A2042) : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodButton(
      String text, IconData icon, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Color(0xFF0A2042) : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(4),
          color:
              isSelected ? Color(0xFF0A2042).withOpacity(0.05) : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Color(0xFF0A2042) : Colors.black54,
              size: 28,
            ),
            SizedBox(height: 8),
            Text(
              text.split('/').first,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Color(0xFF0A2042) : Colors.black87,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
