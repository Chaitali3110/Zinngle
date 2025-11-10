// lib/features/home/screens/calls_screen.dart
import 'package:flutter/material.dart';

class CallsScreen extends StatefulWidget {
  const CallsScreen({Key? key}) : super(key: key);

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calls'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Theme.of(context).primaryColor,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Missed'),
            Tab(text: 'Scheduled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCallList(),
          _buildCallList(onlyMissed: true),
          _buildScheduledCallList(),
        ],
      ),
    );
  }

  Widget _buildCallList({bool onlyMissed = false}) {
    final calls = [
      CallRecord(
        creatorName: 'Sarah Johnson',
        creatorAvatar: 'https://i.pravatar.cc/150?img=1',
        callType: 'video',
        duration: '15:30',
        timestamp: '2 hours ago',
        isMissed: false,
        isIncoming: true,
      ),
      CallRecord(
        creatorName: 'Mike Wilson',
        creatorAvatar: 'https://i.pravatar.cc/150?img=2',
        callType: 'audio',
        duration: '08:45',
        timestamp: '5 hours ago',
        isMissed: true,
        isIncoming: true,
      ),
      CallRecord(
        creatorName: 'Emma Davis',
        creatorAvatar: 'https://i.pravatar.cc/150?img=3',
        callType: 'video',
        duration: '22:15',
        timestamp: 'Yesterday',
        isMissed: false,
        isIncoming: false,
      ),
    ];

    final filteredCalls = onlyMissed ? calls.where((c) => c.isMissed).toList() : calls;

    return filteredCalls.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.call_outlined,
                  size: 80,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No calls yet',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: filteredCalls.length,
            itemBuilder: (context, index) {
              return _buildCallTile(filteredCalls[index]);
            },
          );
  }

  Widget _buildCallTile(CallRecord call) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(call.creatorAvatar),
      ),
      title: Text(
        call.creatorName,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: Row(
        children: [
          Icon(
            call.isIncoming ? Icons.call_received : Icons.call_made,
            size: 16,
            color: call.isMissed ? Colors.red : Colors.green,
          ),
          const SizedBox(width: 4),
          Text(
            call.isMissed ? 'Missed' : call.duration,
            style: TextStyle(
              color: call.isMissed ? Colors.red : Colors.grey[600],
            ),
          ),
          const SizedBox(width: 8),
          Text('• ${call.timestamp}'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              call.callType == 'video' ? Icons.videocam : Icons.call,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/outgoing-call');
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Show call details
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScheduledCallList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_available,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No scheduled calls',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Schedule a call
            },
            child: const Text('Schedule a Call'),
          ),
        ],
      ),
    );
  }
}

class CallRecord {
  final String creatorName;
  final String creatorAvatar;
  final String callType;
  final String duration;
  final String timestamp;
  final bool isMissed;
  final bool isIncoming;

  CallRecord({
    required this.creatorName,
    required this.creatorAvatar,
    required this.callType,
    required this.duration,
    required this.timestamp,
    required this.isMissed,
    required this.isIncoming,
  });
}
