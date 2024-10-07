import 'package:flutter/material.dart';
import 'dart:io';
import 'paymentDetails_Unpaid.dart';
import 'paymentDetails_Pending.dart';
import 'paymentDetails_Completed.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              '/home/ptk/kmitl/year3/software_architecture/myfluffyFE/myfluffy/assets/logo.png',  // Add your image path here
              fit: BoxFit.contain,
              height: 100, // Set your desired height
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Text(
              'Payment',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF4675D1)),
            ),
          ),
          SizedBox(height: 8),

          PaymentCard(
            petName: 'xxx',
            finderName: 'xxx',
            finderBankAccNo: 'xxx',
            amount: 'xxx',
            status: PaymentStatus.unpaid,
            onViewPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentDetailsUnpaid(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          PaymentCard(
            petName: 'xxx',
            finderName: 'xxx',
            finderBankAccNo: 'xxx',
            amount: 'xxx',
            status: PaymentStatus.pending,
            onViewPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentDetailsPending(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          PaymentCard(
            petName: 'xxx',
            finderName: 'xxx',
            finderBankAccNo: 'xxx',
            amount: 'xxx',
            status: PaymentStatus.completed,
            onViewPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentDetailsCompleted(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

enum PaymentStatus { unpaid, pending, completed }

class PaymentCard extends StatelessWidget {
  final String petName;
  final String finderName;
  final String finderBankAccNo;
  final String amount;
  final PaymentStatus status;
  final VoidCallback onViewPressed;

  const PaymentCard({
    Key? key,
    required this.petName,
    required this.finderName,
    required this.finderBankAccNo,
    required this.amount,
    required this.status,
    required this.onViewPressed,
  }) : super(key: key);

  Color _getStatusColor() {
    switch (status) {
      case PaymentStatus.unpaid:
        return Colors.red;
      case PaymentStatus.pending:
        return Colors.yellow;
      case PaymentStatus.completed:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pet Name: $petName'),
            Text('Finder Name: $finderName'),
            Text('Finder Bank Acc No.: $finderBankAccNo'),
            Text('Amount: $amount'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Status: ', style: TextStyle(color: Colors.black)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStatusColor(),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        status.name,
                        style: TextStyle(
                          color: status == PaymentStatus.pending ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4675D1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: onViewPressed,
                  child: const Text('View'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}