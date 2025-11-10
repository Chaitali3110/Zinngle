// lib/features/auth/screens/permissions_screen.dart
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({Key? key}) : super(key: key);

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  final Map<String, bool> _permissions = {
    'camera': false,
    'microphone': false,
    'storage': false,
    'notifications': false,
  };

  Future<void> _requestPermission(String permission) async {
    PermissionStatus status;

    switch (permission) {
      case 'camera':
        status = await Permission.camera.request();
        break;
      case 'microphone':
        status = await Permission.microphone.request();
        break;
      case 'storage':
        status = await Permission.storage.request();
        break;
      case 'notifications':
        status = await Permission.notification.request();
        break;
      default:
        return;
    }

    setState(() {
      _permissions[permission] = status.isGranted;
    });
  }

  Future<void> _requestAllPermissions() async {
    for (String permission in _permissions.keys) {
      await _requestPermission(permission);
    }
  }

  void _continue() {
    Navigator.pushNamed(context, '/profile-setup');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permissions'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Allow Permissions',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'To provide you the best experience, we need access to:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              _buildPermissionTile(
                icon: Icons.camera_alt_outlined,
                title: 'Camera',
                description: 'For video calls and profile pictures',
                permission: 'camera',
              ),
              _buildPermissionTile(
                icon: Icons.mic_outlined,
                title: 'Microphone',
                description: 'For voice and video calls',
                permission: 'microphone',
              ),
              _buildPermissionTile(
                icon: Icons.folder_outlined,
                title: 'Storage',
                description: 'To save media and files',
                permission: 'storage',
              ),
              _buildPermissionTile(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                description: 'To receive call and message alerts',
                permission: 'notifications',
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _requestAllPermissions,
                  child: const Text(
                    'Allow All',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: TextButton(
                  onPressed: _continue,
                  child: const Text(
                    'Skip for Now',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionTile({
    required IconData icon,
    required String title,
    required String description,
    required String permission,
  }) {
    final isGranted = _permissions[permission] ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withAlpha(26),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              isGranted ? Icons.check_circle : Icons.arrow_forward_ios,
              color: isGranted ? Colors.green : Colors.grey,
            ),
            onPressed: () => _requestPermission(permission),
          ),
        ],
      ),
    );
  }
}
