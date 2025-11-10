// lib/features/info/screens/terms_of_service_screen.dart
import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Terms of Service',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last updated: October 31, 2025',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: '1. Acceptance of Terms',
              content:
                  'By accessing and using Zinngle, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to abide by the above, please do not use this service.',
            ),
            _buildSection(
              title: '2. Use License',
              content:
                  'Permission is granted to temporarily download one copy of Zinngle for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title.',
            ),
            _buildSection(
              title: '3. User Accounts',
              content:
                  'When you create an account with us, you must provide accurate, complete, and current information. Failure to do so constitutes a breach of the Terms, which may result in immediate termination of your account.',
            ),
            _buildSection(
              title: '4. Payment Terms',
              content:
                  'All payments are processed securely through our payment gateway. Coins purchased are non-refundable except as required by law. Prices are subject to change without notice.',
            ),
            _buildSection(
              title: '5. Creator Terms',
              content:
                  'Creators must comply with all applicable laws and regulations. Creators are responsible for the content they provide during calls. Zinngle reserves the right to terminate creator accounts for violations.',
            ),
            _buildSection(
              title: '6. Prohibited Activities',
              content:
                  'You may not use Zinngle for any illegal purposes or to violate any laws. Harassment, abuse, or inappropriate content is strictly prohibited and will result in account termination.',
            ),
            _buildSection(
              title: '7. Intellectual Property',
              content:
                  'All content, trademarks, and data on this platform are the property of Zinngle or its content suppliers. Unauthorized use of any materials is prohibited.',
            ),
            _buildSection(
              title: '8. Disclaimer',
              content:
                  'The materials on Zinngle are provided on an "as is" basis. Zinngle makes no warranties, expressed or implied, and hereby disclaims and negates all other warranties.',
            ),
            _buildSection(
              title: '9. Limitations',
              content:
                  'In no event shall Zinngle or its suppliers be liable for any damages arising out of the use or inability to use the materials on Zinngle.',
            ),
            _buildSection(
              title: '10. Contact Information',
              content:
                  'If you have any questions about these Terms, please contact us at legal@zinngle.com',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
