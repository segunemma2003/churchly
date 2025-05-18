import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class PaymentDetailsPage extends NyStatefulWidget {
  static RouteView path = ("/payment-details", (_) => PaymentDetailsPage());

  PaymentDetailsPage({super.key})
      : super(child: () => _PaymentDetailsPageState());
}

class _PaymentDetailsPageState extends NyPage<PaymentDetailsPage> {
  // List to store payment cards
  List<PaymentCard> paymentCards = [
    PaymentCard(
      cardType: CardType.visa,
      cardNumber: "XXX-2824",
      expiryDate: "05/26",
    ),
  ];

  @override
  get init => () {
        // Initialize anything needed
      };

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Payment",
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
        child: Column(
          children: [
            // Cards list
            Expanded(
              child: ListView.builder(
                itemCount:
                    paymentCards.length + 1, // +1 for the "Add new card" option
                itemBuilder: (context, index) {
                  if (index < paymentCards.length) {
                    // Display existing card
                    return _buildCardItem(paymentCards[index]);
                  } else {
                    // Display "Add new card" option
                    return _buildAddCardOption(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardItem(PaymentCard card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${card.cardType.name.toUpperCase()} ${card.cardNumber}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "Exp: ${card.expiryDate}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // Card logo text
          _buildCardLogo(card.cardType),

          // Delete button
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() {
                paymentCards.remove(card);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddCardOption(BuildContext context) {
    return InkWell(
      onTap: () {
        _showAddCardDialog(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey[200]!),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.credit_card,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Add new card",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Add new credit/debit card",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardLogo(CardType cardType) {
    // Text-based card logo
    Color textColor;
    String text;

    switch (cardType) {
      case CardType.visa:
        textColor = Colors.indigo;
        text = "VISA";
        break;
      case CardType.mastercard:
        textColor = Colors.deepOrange;
        text = "MC";
        break;
      case CardType.amex:
        textColor = Colors.blue;
        text = "AMEX";
        break;
      default:
        textColor = Colors.grey;
        text = "CARD";
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: textColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  void _showAddCardDialog(BuildContext context) {
    // Using a separate method to create bottom sheet content
    // to avoid controller disposal issues
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return AddCardBottomSheet(
          onCardAdded: (PaymentCard newCard) {
            setState(() {
              paymentCards.add(newCard);
            });
          },
        );
      },
    );
  }
}

// Separate widget for bottom sheet to avoid the controller disposal issues
class AddCardBottomSheet extends StatefulWidget {
  final Function(PaymentCard) onCardAdded;

  const AddCardBottomSheet({
    Key? key,
    required this.onCardAdded,
  }) : super(key: key);

  @override
  State<AddCardBottomSheet> createState() => _AddCardBottomSheetState();
}

class _AddCardBottomSheetState extends State<AddCardBottomSheet> {
  // Controllers for the text fields
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardholderNameController =
      TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  // Detected card type
  CardType detectedCardType = CardType.unknown;

  @override
  void initState() {
    super.initState();

    // Listen to changes in the card number and detect the card type
    cardNumberController.addListener(_detectCardType);
  }

  @override
  void dispose() {
    // Remove listener before disposing
    cardNumberController.removeListener(_detectCardType);

    // Clean up controllers when the widget is disposed
    cardNumberController.dispose();
    cardholderNameController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  // Method to detect card type based on card number
  void _detectCardType() {
    String cardNumber =
        cardNumberController.text.replaceAll(RegExp(r'\s+'), '');

    if (cardNumber.isEmpty) {
      setState(() {
        detectedCardType = CardType.unknown;
      });
      return;
    }

    // Visa cards start with 4
    if (cardNumber.startsWith('4')) {
      setState(() {
        detectedCardType = CardType.visa;
      });
      return;
    }

    // Mastercard starts with 51-55 or 2221-2720
    if ((cardNumber.startsWith('5') &&
            int.tryParse(cardNumber.substring(1, 2)) != null &&
            int.parse(cardNumber.substring(1, 2)) >= 1 &&
            int.parse(cardNumber.substring(1, 2)) <= 5) ||
        (cardNumber.length >= 4 &&
            int.tryParse(cardNumber.substring(0, 4)) != null &&
            int.parse(cardNumber.substring(0, 4)) >= 2221 &&
            int.parse(cardNumber.substring(0, 4)) <= 2720)) {
      setState(() {
        detectedCardType = CardType.mastercard;
      });
      return;
    }

    // American Express starts with 34 or 37
    if (cardNumber.startsWith('34') || cardNumber.startsWith('37')) {
      setState(() {
        detectedCardType = CardType.amex;
      });
      return;
    }

    // Default to unknown if no match
    setState(() {
      detectedCardType = CardType.unknown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 20,
        left: 20,
        right: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add New Card",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // Card Number with detected card type indicator
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Card Number",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: cardNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "XXXX XXXX XXXX XXXX",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.indigo),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  // Show card type suffix if detected
                  suffixIcon: detectedCardType != CardType.unknown
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: _buildCardLogo(detectedCardType),
                        )
                      : null,
                ),
                // Format card number as the user types
                onChanged: (value) {
                  // Add space after every 4 digits
                  String digitsOnly = value.replaceAll(RegExp(r'\D'), '');
                  String formatted = '';

                  for (int i = 0; i < digitsOnly.length; i++) {
                    if (i > 0 && i % 4 == 0) {
                      formatted += ' ';
                    }
                    formatted += digitsOnly[i];
                  }

                  if (formatted != value) {
                    cardNumberController.value = TextEditingValue(
                      text: formatted,
                      selection:
                          TextSelection.collapsed(offset: formatted.length),
                    );
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Cardholder Name
          _buildTextFormField(
            controller: cardholderNameController,
            label: "Cardholder Name",
            hintText: "John Doe",
          ),
          const SizedBox(height: 16),

          // Expiry Date and CVV in same row
          Row(
            children: [
              Expanded(
                child: _buildTextFormField(
                  controller: expiryDateController,
                  label: "Expiry Date",
                  hintText: "MM/YY",
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    // Format as MM/YY
                    String digitsOnly = value.replaceAll(RegExp(r'\D'), '');
                    String formatted = '';

                    if (digitsOnly.isNotEmpty) {
                      // Handle month
                      if (digitsOnly.length >= 1) {
                        int firstDigit = int.parse(digitsOnly[0]);
                        // First digit of month can only be 0 or 1
                        if (firstDigit > 1) {
                          digitsOnly = '0' + digitsOnly;
                        }
                      }

                      // Limit month to 12
                      if (digitsOnly.length >= 2) {
                        int month = int.parse(digitsOnly.substring(0, 2));
                        if (month > 12) {
                          digitsOnly = '12' + digitsOnly.substring(2);
                        }
                      }

                      // Format with slash
                      if (digitsOnly.length <= 2) {
                        formatted = digitsOnly;
                      } else {
                        formatted = digitsOnly.substring(0, 2) +
                            '/' +
                            digitsOnly.substring(2, min(4, digitsOnly.length));
                      }
                    }

                    if (formatted != value) {
                      expiryDateController.value = TextEditingValue(
                        text: formatted,
                        selection:
                            TextSelection.collapsed(offset: formatted.length),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextFormField(
                  controller: cvvController,
                  label: "CVV",
                  hintText: "XXX",
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  maxLength: 3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Add Card Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Validate and save card
                if (cardNumberController.text.isNotEmpty &&
                    expiryDateController.text.isNotEmpty &&
                    detectedCardType != CardType.unknown) {
                  final String last4 =
                      cardNumberController.text.replaceAll(' ', '');
                  final String last4Digits = last4.length >= 4
                      ? last4.substring(last4.length - 4)
                      : last4;

                  widget.onCardAdded(
                    PaymentCard(
                      cardType: detectedCardType,
                      cardNumber: "XXX-$last4Digits",
                      expiryDate: expiryDateController.text,
                    ),
                  );
                  Navigator.pop(context);
                } else {
                  // Show validation error
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter valid card details'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Add Card",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int? maxLength,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLength: maxLength,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            counterText: '', // Hide the counter for maxLength
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.indigo),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildCardLogo(CardType cardType) {
    // Text-based card logo
    Color textColor;
    String text;

    switch (cardType) {
      case CardType.visa:
        textColor = Colors.indigo;
        text = "VISA";
        break;
      case CardType.mastercard:
        textColor = Colors.deepOrange;
        text = "MC";
        break;
      case CardType.amex:
        textColor = Colors.blue;
        text = "AMEX";
        break;
      default:
        textColor = Colors.grey;
        text = "CARD";
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: textColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  int min(int a, int b) {
    return a < b ? a : b;
  }
}

// Enum for card types
enum CardType { visa, mastercard, amex, unknown }

// Class to represent a payment card
class PaymentCard {
  final CardType cardType;
  final String cardNumber;
  final String expiryDate;

  PaymentCard({
    required this.cardType,
    required this.cardNumber,
    required this.expiryDate,
  });
}
