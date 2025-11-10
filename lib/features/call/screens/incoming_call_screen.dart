// lib/features/call/screens/incoming_call_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class IncomingCallScreen extends StatefulWidget {
  final String creatorName;
  final String creatorImage;
  final String callType;

  const IncomingCallScreen({
    Key? key,
    this.creatorName = 'Creator',
    this.creatorImage = '',
    this.callType = 'video',
  }) : super(key: key);

  @override
  State<IncomingCallScreen> createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final FlutterRingtonePlayer _ringtonePlayer = FlutterRingtonePlayer();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    
    _ringtonePlayer.play(fromAsset: "assets/audio/ringtone.mp3", asAlarm: true);
  }

  Future<void> _acceptCall() async {
    await _ringtonePlayer.stop();
    Navigator.pushReplacementNamed(
      context,
      widget.callType == 'video' ? '/video-call' : '/audio-call',
      arguments: {
        'creatorName': widget.creatorName,
        'creatorImage': widget.creatorImage,
      },
    );
  }

  Future<void> _rejectCall() async {
    await _ringtonePlayer.stop();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _ringtonePlayer.stop(); // This can be fire-and-forget in dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withAlpha(178),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(
                      widget.callType == 'video' 
                          ? Icons.videocam 
                          : Icons.phone,
                      color: Colors.white,
                      size: 40,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Incoming ${widget.callType} call',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Container(
                        padding: EdgeInsets.all(15 + (_animationController.value * 15)),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withAlpha(51),
                        ),
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(widget.creatorImage),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  Text(
                    widget.creatorName,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      icon: Icons.call_end,
                      label: 'Decline',
                      color: Colors.red,
                      onPressed: _rejectCall,
                    ),
                    _buildActionButton(
                      icon: Icons.call,
                      label: 'Accept',
                      color: Colors.green,
                      onPressed: _acceptCall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(icon, size: 36),
            color: Colors.white,
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
