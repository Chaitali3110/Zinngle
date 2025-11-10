// lib/features/support/screens/faq_screen.dart
import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<FAQ> _faqs = [
    FAQ(
      question: 'How do I add coins to my wallet?',
      answer: 'Go to your Wallet, tap "Add Coins", select a package, and complete the payment through Razorpay.',
    ),
    FAQ(
      question: 'What happens if my call gets disconnected?',
      answer: 'If a call disconnects within the first minute, you won\'t be charged. For longer calls, you\'ll be charged only for the time used.',
    ),
    FAQ(
      question: 'How do I become a creator?',
      answer: 'Go to Profile > Become a Creator, complete the verification process, set your pricing, and start accepting calls.',
    ),
    FAQ(
      question: 'How do I withdraw my earnings?',
      answer: 'Navigate to Creator Dashboard > Withdraw Earnings, enter the amount, provide your bank details, and submit. Withdrawals are processed within 3-5 business days.',
    ),
    FAQ(
      question: 'Can I get a refund for unused coins?',
      answer: 'Unused coins don\'t expire and can be used anytime. However, refunds for purchased coins are only available within 24 hours if no calls have been made.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _faqs.length,
        itemBuilder: (context, index) {
          return _buildFAQCard(_faqs[index]);
        },
      ),
    );
  }

  Widget _buildFAQCard(FAQ faq) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(
          faq.question,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              faq.answer,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FAQ {
  final String question;
  final String answer;

  FAQ({
    required this.question,
    required this.answer,
  });
}
