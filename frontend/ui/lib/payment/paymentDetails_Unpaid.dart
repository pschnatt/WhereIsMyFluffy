import 'package:flutter/material.dart';
import 'dart:io';

class PaymentDetailsUnpaid extends StatelessWidget {
  const PaymentDetailsUnpaid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Payment ID: xxxxxxxxxxxxx',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            const PaymentDetailItem(label: 'Pet Name', value: 'xxx'),
            const PaymentDetailItem(label: 'Finder Name', value: 'xxx'),
            const PaymentDetailItem(label: 'Finder Bank Acc No', value: 'xxx'),
            const PaymentDetailItem(label: 'Finder Bank Acc Type', value: 'Krungsri'),
            const PaymentDetailItem(label: 'Finder Bank Acc Name', value: 'xxx'),
            const PaymentDetailItem(label: 'Amount', value: 'xxx'),
            const PaymentDetailItem(label: 'Status', value: 'Unpaid'),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4675D1), // Background color
                      foregroundColor: Colors.white, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0), // Rounded corners
                      ),
                    ),
                onPressed: () {
                  // Implement upload transaction functionality
                },
                child: const Text('Upload Transaction'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentDetailItem extends StatelessWidget {
  final String label;
  final String value;

  const PaymentDetailItem({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text('$label:',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}