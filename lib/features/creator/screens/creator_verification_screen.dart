// lib/features/creator/screens/creator_verification_screen.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreatorVerificationScreen extends StatefulWidget {
  const CreatorVerificationScreen({Key? key}) : super(key: key);

  @override
  State<CreatorVerificationScreen> createState() => _CreatorVerificationScreenState();
}

class _CreatorVerificationScreenState extends State<CreatorVerificationScreen> {
  File? _idFrontImage;
  File? _idBackImage;
  File? _selfieImage;
  final TextEditingController _idNumberController = TextEditingController();
  String _selectedIdType = 'Aadhar Card';

  final List<String> _idTypes = [
    'Aadhar Card',
    'PAN Card',
    'Driving License',
    'Passport',
  ];

  Future<void> _pickImage(String type) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        switch (type) {
          case 'front':
            _idFrontImage = File(pickedFile.path);
            break;
          case 'back':
            _idBackImage = File(pickedFile.path);
            break;
          case 'selfie':
            _selfieImage = File(pickedFile.path);
            break;
        }
      });
    }
  }

  void _continue() {
    if (_idFrontImage == null || _idBackImage == null || _selfieImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload all required documents')),
      );
      return;
    }

    if (_idNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter ID number')),
      );
      return;
    }

    Navigator.pushNamed(context, '/creator-pricing');
  }

  @override
  void dispose() {
    _idNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: 0.66,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Verify Your Identity',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We need to verify your identity to ensure platform safety',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.security, color: Colors.blue[700]),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Your information is secure and encrypted',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: _selectedIdType,
              decoration: InputDecoration(
                labelText: 'ID Type',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: _idTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedIdType = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _idNumberController,
              decoration: InputDecoration(
                labelText: 'ID Number',
                hintText: 'Enter your ID number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildDocumentUpload(
              title: 'ID Front Side',
              subtitle: 'Upload front side of your ID',
              image: _idFrontImage,
              onTap: () => _pickImage('front'),
            ),
            const SizedBox(height: 16),
            _buildDocumentUpload(
              title: 'ID Back Side',
              subtitle: 'Upload back side of your ID',
              image: _idBackImage,
              onTap: () => _pickImage('back'),
            ),
            const SizedBox(height: 16),
            _buildDocumentUpload(
              title: 'Selfie with ID',
              subtitle: 'Take a selfie holding your ID',
              image: _selfieImage,
              onTap: () => _pickImage('selfie'),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _continue,
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentUpload({
    required String title,
    required String subtitle,
    required File? image,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: image != null ? Colors.green : Colors.grey[300]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(image, fit: BoxFit.cover),
                    )
                  : Icon(Icons.camera_alt, size: 40, color: Colors.grey[400]),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              image != null ? Icons.check_circle : Icons.add_circle_outline,
              color: image != null ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
