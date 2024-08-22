import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedAddress = "Home";
  Map<String, Map<String, String>> addresses = {
    "Home": {"phone": "(342) 4522019", "address": "220 New York"},
    "Office": {"phone": "(342) 4522019", "address": "220 Montmartre, Paris"}
  };

  void _selectAddress(String address) {
    setState(() {
      selectedAddress = address;
    });
  }

  void _editAddress(String title) {
    TextEditingController phoneController =
        TextEditingController(text: addresses[title]!["phone"]);
    TextEditingController addressController =
        TextEditingController(text: addresses[title]!["address"]);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Edit Address",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: "Phone"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: "Address"),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          addresses[title]!["phone"] = phoneController.text;
                          addresses[title]!["address"] = addressController.text;
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text("Save"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Delivery address",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            AddressCard(
              title: "Home",
              phone: addresses["Home"]!["phone"]!,
              address: addresses["Home"]!["address"]!,
              isSelected: selectedAddress == "Home",
              onTap: () => _selectAddress("Home"),
              onEdit: () => _editAddress("Home"),
            ),
            const SizedBox(height: 8),
            AddressCard(
              title: "Office",
              phone: addresses["Office"]!["phone"]!,
              address: addresses["Office"]!["address"]!,
              isSelected: selectedAddress == "Office",
              onTap: () => _selectAddress("Office"),
              onEdit: () => _editAddress("Office"),
            ),
            const SizedBox(height: 32),
            const Text(
              "Billing information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const BillingInfoRow(label: "Delivery Fee", amount: "\$50"),
            const BillingInfoRow(label: "Subtotal", amount: "\$740"),
            const BillingInfoRow(label: "Total", amount: "\$790"),
            const SizedBox(height: 32),
            const Text(
              "Payment Method",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  "assets/icons/apple_pay.svg",
                  width: 25,
                  height: 25,
                ),
                SvgPicture.asset(
                  "assets/icons/visa.svg",
                  width: 25,
                  height: 25,
                ),
                SvgPicture.asset(
                  "assets/icons/mastercard.svg",
                  width: 25,
                  height: 25,
                ),
                SvgPicture.asset(
                  "assets/icons/paypal.svg",
                  width: 25,
                  height: 25,
                ),
              ],
            ),
            const Spacer(),
            const SwipeButton(),
          ],
        ),
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  final String title;
  final String phone;
  final String address;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  const AddressCard({
    super.key,
    required this.title,
    required this.phone,
    required this.address,
    required this.isSelected,
    required this.onTap,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(
            isSelected
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            color: isSelected ? Colors.orange : Colors.grey,
          ),
          title: Text(title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(phone),
              Text(address),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onEdit,
          ),
        ),
      ),
    );
  }
}

class BillingInfoRow extends StatelessWidget {
  final String label;
  final String amount;

  const BillingInfoRow({
    super.key,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(amount),
        ],
      ),
    );
  }
}

class PaymentMethodIcon extends StatelessWidget {
  final String asset;

  const PaymentMethodIcon({
    super.key,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: 40,
      height: 40,
    );
  }
}

class SwipeButton extends StatelessWidget {
  const SwipeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Center(
        child: Text(
          "Swipe for Payment",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
