// lib/features/wallet/screens/wallet_screen.dart
import 'package:flutter/material.dart';
import '../models/coin_package_model.dart';
import '../models/transaction_model.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CoinPackage> coinPackages = [
      CoinPackage(coins: 100, price: 100, bonus: 0),
      CoinPackage(coins: 500, price: 500, bonus: 50),
      CoinPackage(coins: 1000, price: 1000, bonus: 150),
      CoinPackage(coins: 2000, price: 2000, bonus: 400),
    ];

    final List<Transaction> transactions = [
      Transaction(
        id: '1',
        type: 'credit',
        title: 'Added Coins',
        coins: 500,
        amount: 500,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        status: TransactionStatus.completed,
        description: 'Razorpay Payment',
      ),
      Transaction(
        id: '2',
        type: 'debit',
        title: 'Video Call',
        coins: 150,
        amount: 150,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        status: TransactionStatus.completed,
        description: 'Call with Sarah Johnson',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallet'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBalanceCard(context),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Coins',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/add-coins'),
                    child: const Text('See All'),
                  )
                ],
              ),

              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: coinPackages.length > 2 ? 2 : coinPackages.length, // Show only first 2
                itemBuilder: (context, index) {
                  return _buildCoinPackageCard(context, coinPackages[index]);
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transactions',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/transaction-history'),
                    child: const Text('See All'),
                  )
                ],
              ),

              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactions.length > 3 ? 3 : transactions.length, // Show only first 3
                itemBuilder: (context, index) {
                  return _buildTransactionTile(transactions[index]);
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).primaryColor, Colors.blue.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Balance',
            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.monetization_on, color: Colors.amber, size: 36),
              SizedBox(width: 8),
              Text(
                '290',
                style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Text(
                'Coins',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCoinPackageCard(BuildContext context, CoinPackage package) {
    final bool isPopular = package.bonus > 50;
    return Card(
      elevation: isPopular ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isPopular ? Theme.of(context).primaryColor : Colors.grey[300]!,
          width: isPopular ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/add-coins');
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${package.coins + package.bonus} Coins',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '₹${package.price}',
                style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionTile(Transaction transaction) {
    final isCredit = transaction.type == 'credit';
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: isCredit ? Colors.green[100] : Colors.red[100],
        child: Icon(
          isCredit ? Icons.arrow_downward : Icons.arrow_upward,
          color: isCredit ? Colors.green[700] : Colors.red[700],
        ),
      ),
      title: Text(transaction.title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
          '${transaction.timestamp.day}/${transaction.timestamp.month}/${transaction.timestamp.year}'),
      trailing: Text(
        '${isCredit ? '+' : '-'}₹${transaction.amount.toInt()}',
        style: TextStyle(
          color: isCredit ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}