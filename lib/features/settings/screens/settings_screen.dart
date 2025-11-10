// lib/features/settings/screens/settings_screen.dart
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSettingsSection(
            title: 'Account',
            items: [
              SettingsItem(
                icon: Icons.person_outline,
                title: 'Account Settings',
                onTap: () {
                  Navigator.pushNamed(context, '/account-settings');
                },
              ),
              SettingsItem(
                icon: Icons.lock_outline,
                title: 'Privacy Settings',
                onTap: () {
                  Navigator.pushNamed(context, '/privacy-settings');
                },
              ),
              SettingsItem(
                icon: Icons.notifications_outlined,
                title: 'Notification Settings',
                onTap: () {
                  Navigator.pushNamed(context, '/notification-settings');
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSettingsSection(
            title: 'Support',
            items: [
              SettingsItem(
                icon: Icons.help_outline,
                title: 'Help Center',
                onTap: () {
                  Navigator.pushNamed(context, '/help-center');
                },
              ),
              SettingsItem(
                icon: Icons.report_problem_outlined,
                title: 'Report Issue',
                onTap: () {
                  Navigator.pushNamed(context, '/report-issue');
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSettingsSection(
            title: 'Legal',
            items: [
              SettingsItem(
                icon: Icons.description_outlined,
                title: 'Terms of Service',
                onTap: () {
                  Navigator.pushNamed(context, '/terms-of-service');
                },
              ),
              SettingsItem(
                icon: Icons.shield_outlined,
                title: 'Privacy Policy',
                onTap: () {
                  Navigator.pushNamed(context, '/privacy-policy');
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSettingsSection(
            title: 'App',
            items: [
              SettingsItem(
                icon: Icons.info_outline,
                title: 'About',
                onTap: () {
                  Navigator.pushNamed(context, '/about');
                },
              ),
              SettingsItem(
                icon: Icons.update,
                title: 'Check for Updates',
                subtitle: 'Version 1.0.0',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<SettingsItem> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
              letterSpacing: 0.5,
            ),
          ),
        ),
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: items
                .map((item) => _buildSettingsTile(item))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(SettingsItem item) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          item.icon,
          color: Theme.of(context).primaryColor,
          size: 22,
        ),
      ),
      title: Text(
        item.title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      subtitle: item.subtitle != null
          ? Text(
              item.subtitle!,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            )
          : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: item.onTap,
    );
  }
}

class SettingsItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });
}
