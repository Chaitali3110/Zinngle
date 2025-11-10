// lib/features/settings/screens/privacy_settings_screen.dart
import 'package:flutter/material.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({Key? key}) : super(key: key);

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _showOnlineStatus = true;
  bool _showLastSeen = true;
  bool _allowSearchByPhone = true;
  bool _showProfilePhoto = true;
  String _whoCanCall = 'Everyone';
  String _whoCanMessage = 'Everyone';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Visibility',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildToggleTile(
            icon: Icons.circle,
            title: 'Show Online Status',
            subtitle: 'Let others see when you\'re online',
            value: _showOnlineStatus,
            onChanged: (value) {
              setState(() {
                _showOnlineStatus = value;
              });
            },
          ),
          _buildToggleTile(
            icon: Icons.access_time,
            title: 'Show Last Seen',
            subtitle: 'Let others see your last active time',
            value: _showLastSeen,
            onChanged: (value) {
              setState(() {
                _showLastSeen = value;
              });
            },
          ),
          _buildToggleTile(
            icon: Icons.person_outline,
            title: 'Show Profile Photo',
            subtitle: 'Display your profile photo to everyone',
            value: _showProfilePhoto,
            onChanged: (value) {
              setState(() {
                _showProfilePhoto = value;
              });
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'Discovery',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildToggleTile(
            icon: Icons.search,
            title: 'Allow Search by Phone',
            subtitle: 'Let users find you by phone number',
            value: _allowSearchByPhone,
            onChanged: (value) {
              setState(() {
                _allowSearchByPhone = value;
              });
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'Communication',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSelectionTile(
            icon: Icons.call,
            title: 'Who Can Call Me',
            value: _whoCanCall,
            onTap: () {
              _showSelectionDialog(
                title: 'Who Can Call Me',
                options: ['Everyone', 'Favorites', 'No One'],
                currentValue: _whoCanCall,
                onSelected: (value) {
                  setState(() {
                    _whoCanCall = value;
                  });
                },
              );
            },
          ),
          _buildSelectionTile(
            icon: Icons.message,
            title: 'Who Can Message Me',
            value: _whoCanMessage,
            onTap: () {
              _showSelectionDialog(
                title: 'Who Can Message Me',
                options: ['Everyone', 'Favorites', 'No One'],
                currentValue: _whoCanMessage,
                onSelected: (value) {
                  setState(() {
                    _whoCanMessage = value;
                  });
                },
              );
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'Blocked Users',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey[300]!),
            ),
            leading: Icon(Icons.block, color: Colors.red),
            title: const Text('Blocked Users'),
            subtitle: const Text('Manage blocked users'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildToggleTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: SwitchListTile(
        secondary: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSelectionTile({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(value),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showSelectionDialog({
    required String title,
    required List<String> options,
    required String currentValue,
    required ValueChanged<String> onSelected,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) {
            return RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: currentValue,
              onChanged: (value) {
                if (value != null) {
                  onSelected(value);
                  Navigator.pop(context);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
