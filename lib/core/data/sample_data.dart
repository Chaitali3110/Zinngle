import '../features/models/creator_model.dart';
import '../features/wallet/models/coin_package_model.dart';
import '../features/wallet/models/transaction_model.dart';

class SampleData {
  static List<Creator> get sampleCreators => [
    Creator(
      id: '1',
      name: 'John Doe',
      category: 'Music',
      description: 'Professional musician',
      rating: 4.5,
      followers: 1500,
      isOnline: true,
      isVerified: true,
    ),
    Creator(
      id: '2',
      name: 'Jane Smith',
      category: 'Art',
      description: 'Digital artist',
      rating: 4.8,
      followers: 2300,
      isOnline: false,
      isVerified: true,
    ),
  ];

  static List<CoinPackage> get sampleCoinPackages => [
    CoinPackage(coins: 100, price: 100, bonus: 0),
    CoinPackage(coins: 500, price: 500, bonus: 50),
    CoinPackage(coins: 1000, price: 1000, bonus: 150),
    CoinPackage(coins: 2000, price: 2000, bonus: 400),
  ];

  static List<Transaction> get sampleTransactions => [
    Transaction(
      id: '1',
      type: TransactionType.purchase,
      amount: 100,
      coins: 100,
      date: DateTime.now(),
      description: 'Coin purchase',
      title: 'Added Coins',
      timestamp: DateTime.now(),
    ),
    Transaction(
      id: '2',
      type: TransactionType.reward,
      amount: 50,
      coins: 50,
      date: DateTime.now(),
      description: 'Referral bonus',
      title: 'Referral Bonus',
      timestamp: DateTime.now(),
    ),
  ];
}