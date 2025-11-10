// lib/features/info/screens/privacy_policy_screen.dart
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Policy',
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
              title: '1. Information We Collect',
              content:
                  'We collect information you provide directly to us, such as when you create an account, make a purchase, or contact us for support. This includes your name, email address, phone number, payment information, and profile details.',
            ),
            _buildSection(
              title: '2. How We Use Your Information',
              content:
                  'We use the information we collect to provide, maintain, and improve our services, process transactions, send you technical notices and support messages, and respond to your comments and questions.',
            ),
            _buildSection(
              title: '3. Information Sharing',
              content:
                  'We do not share your personal information with third parties except as described in this policy. We may share information with service providers who perform services on our behalf.',
            ),
            _buildSection(
              title: '4. Data Security',
              content:
                  'We take reasonable measures to help protect your personal information from loss, theft, misuse, unauthorized access, disclosure, alteration, and destruction.',
            ),
            _buildSection(
              title: '5. Your Rights',
              content:
                  'You have the right to access, update, or delete your personal information. You may also have the right to restrict or object to certain processing of your data.',
            ),
            _buildSection(
              title: '6. Cookies and Tracking',
              content:
                  'We use cookies and similar tracking technologies to collect information about your browsing activities and to provide personalized content and advertising.',
            ),
            _buildSection(
              title: '7. Children\'s Privacy',
              content:
                  'Our service is not intended for children under 18 years of age. We do not knowingly collect personal information from children under 18.',
            ),
            _buildSection(
              title: '8. International Data Transfers',
              content:
                  'Your information may be transferred to and maintained on servers located outside of your country where data protection laws may differ.',
            ),
            _buildSection(
              title: '9. Changes to Privacy Policy',
              content:
                  'We may update this privacy policy from time to time. We will notify you of any changes by posting the new policy on this page.',
            ),
            _buildSection(
              title: '10. Contact Us',
              content:
                  'If you have any questions about this Privacy Policy, please contact us at privacy@zinngle.com',
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
