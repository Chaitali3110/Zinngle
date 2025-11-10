// lib/features/gifts/screens/gift_store_screen.dart
import 'package:flutter/material.dart';

class GiftStoreScreen extends StatefulWidget {
  const GiftStoreScreen({Key? key}) : super(key: key);

  @override
  State<GiftStoreScreen> createState() => _GiftStoreScreenState();
}

class _GiftStoreScreenState extends State<GiftStoreScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Gift> _gifts = [
    Gift(id: '1', name: 'Rose', icon: '🌹', price: 10, category: 'flowers'),
    Gift(id: '2', name: 'Heart', icon: '❤️', price: 20, category: 'love'),
    Gift(id: '3', name: 'Diamond', icon: '💎', price: 100, category: 'premium'),
    Gift(id: '4', name: 'Crown', icon: '👑', price: 150, category: 'premium'),
    Gift(id: '5', name: 'Car', icon: '🚗', price: 200, category: 'luxury'),
    Gift(id: '6', name: 'Cake', icon: '🎂', price: 30, category: 'food'),
    Gift(id: '7', name: 'Trophy', icon: '🏆', price: 80, category: 'achievement'),
    Gift(id: '8', name: 'Star', icon: '⭐', price: 50, category: 'premium'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
        title: const Text('Gift Store'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/gift-history');
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Theme.of(context).primaryColor,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Popular'),
            Tab(text: 'Premium'),
            Tab(text: 'Luxury'),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              children: [
                const Icon(Icons.account_balance_wallet, color: Colors.orange),
                const SizedBox(width: 8),
                const Text(
                  'Balance: ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '500 Coins',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-coins');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Coins'),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildGiftGrid(_gifts),
                _buildGiftGrid(_gifts.where((g) => g.price <= 50).toList()),
                _buildGiftGrid(_gifts.where((g) => g.price > 50 && g.price <= 150).toList()),
                _buildGiftGrid(_gifts.where((g) => g.price > 150).toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGiftGrid(List<Gift> gifts) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: gifts.length,
      itemBuilder: (context, index) {
        return _buildGiftCard(gifts[index]);
      },
    );
  }

  Widget _buildGiftCard(Gift gift) {
    return GestureDetector(
      onTap: () {
        _showGiftPreview(gift);
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              gift.icon,
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 8),
            Text(
              gift.name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.monetization_on, size: 14, color: Colors.orange),
                  const SizedBox(width: 4),
                  Text(
                    '${gift.price}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showGiftPreview(Gift gift) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 400,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              gift.icon,
              style: const TextStyle(fontSize: 100),
            ),
            const SizedBox(height: 20),
            Text(
              gift.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.monetization_on, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  '${gift.price} Coins',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _sendGift(gift);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Send Gift'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendGift(Gift gift) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              gift.icon,
              style: const TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 16),
            const Text(
              'Gift Sent!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }
}

class Gift {
  final String id;
  final String name;
  final String icon;
  final int price;
  final String category;

  Gift({
    required this.id,
    required this.name,
    required this.icon,
    required this.price,
    required this.category,
  });
}
