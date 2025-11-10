// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // Keep for Firebase
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart'; // Import ringtone player
import 'package:flutter/foundation.dart' show kIsWeb; // Import for kIsWeb

// Core imports
import 'core/router/app_router.dart';
import 'core/router/creator_model.dart';
import 'core/theme/app_theme.dart';
import 'core/config/app_config.dart';
import 'core/config/supabase_config.dart';
import 'core/data/sample_data.dart';
import 'core/services/supabase_auth_service.dart';
import 'core/services/supabase_database_service.dart';

// Providers
import 'providers/auth_provider.dart';

// Features - Auth
import 'features/auth/screens/auth_choice_screen.dart';
import 'features/auth/screens/email_login_screen.dart';
import 'features/auth/screens/otp_verification_screen.dart';
import 'features/auth/screens/permissions_screen.dart';
import 'features/auth/screens/phone_login_screen.dart';
import 'features/auth/screens/signup_screen.dart';
import 'features/auth/screens/user_type_selection_screen.dart';

// Features - Call
import 'features/call/screens/audio_call_screen.dart';
import 'features/call/screens/call_ended_screen.dart';
import 'features/call/screens/call_rating_screen.dart';
import 'features/call/screens/incoming_call_screen.dart';
import 'features/call/screens/outgoing_call_screen.dart';
import 'features/call/screens/video_call_screen.dart';

// Features - Chat
import 'features/chat/models/chat_user.dart';
import 'features/chat/models/message_model.dart';
import 'features/chat/screens/chat_list_screen.dart';
import 'features/chat/screens/chat_screen.dart';

// Features - Creator
import 'features/creator/screens/availability_screen.dart';
import 'features/creator/screens/creator_dashboard_screen.dart';
import 'features/creator/screens/creator_pricing_screen.dart';
import 'features/creator/screens/creator_profile_details_screen.dart';
import 'features/creator/screens/creator_profile_screen.dart';
import 'features/creator/screens/creator_verification_screen.dart';
import 'features/creator/screens/creator_welcome_screen.dart';

// Features - Error
import 'features/error/screens/maintenance_screen.dart';
import 'features/error/screens/no_internet_screen.dart';
import 'features/error/screens/update_required_screen.dart';

// Features - Games
import 'features/games/screens/games_lobby_screen.dart';
import 'features/games/screens/spin_wheel_screen.dart';

// Features - Gifts
import 'features/gifts/screens/gift_store_screen.dart';

// Features - Home
import 'features/home/screens/calls_screen.dart';
import 'features/home/screens/discover_screen.dart';
import 'features/home/screens/favorites_screen.dart';
import 'features/home/screens/home_screen.dart';

// Features - Info
import 'features/info/screens/about_screen.dart';
import 'features/info/screens/privacy_policy_screen.dart';
import 'features/info/screens/terms_of_service_screen.dart';

// Features - Models
import 'features/models/creator_model.dart';

// Features - Onboarding
import 'features/onboarding/screens/language_selection_screen.dart';
import 'features/onboarding/screens/splash_screen.dart';
import 'features/onboarding/screens/welcome_screen.dart';

// Features - Profile
import 'features/profile/screens/interests_selection_screen.dart';
import 'features/profile/screens/profile_screen.dart';
import 'features/profile/screens/profile_setup_screen.dart';
import 'features/profile/screens/referral_code_screen.dart';

// Features - Search
import 'features/search/screens/filter_screen.dart';
import 'features/search/screens/search_screen.dart';

// Features - Settings
import 'features/settings/screens/account_settings_screen.dart';
import 'features/settings/screens/notification_settings_screen.dart';
import 'features/settings/screens/privacy_settings_screen.dart';
import 'features/settings/screens/settings_screen.dart';

// Features - Support
import 'features/support/screens/contact_support_screen.dart';
import 'features/support/screens/faq_screen.dart';
import 'features/support/screens/help_center_screen.dart';
import 'features/support/screens/report_issue_screen.dart';

// Features - Wallet
import 'features/wallet/models/coin_package_model.dart';
import 'features/wallet/models/transaction_model.dart';
import 'features/wallet/screens/add_coins_screen.dart';
import 'features/wallet/screens/payment_method_screen.dart';
import 'features/wallet/screens/transaction_details_screen.dart';
import 'features/wallet/screens/transaction_history_screen.dart';
import 'features/wallet/screens/wallet_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Define the environment and load the corresponding .env file
  const String environment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');
  try {
    await dotenv.load(fileName: ".env.$environment");
  } catch (e) {
    debugPrint('.env file not found, using default configuration: $e');
  }

  // Initialize Firebase (optional - will fail gracefully if not configured)
  try {
    await Firebase.initializeApp();
    debugPrint('Firebase initialized successfully');
  } catch (e) {
    // Firebase not configured - app can continue without it
    debugPrint('Firebase not configured. Error: $e');
  }
  
  // Initialize Supabase
  try {
    await SupabaseConfig.initialize();
    debugPrint('Supabase initialized successfully');
  } catch (e) {
    debugPrint('Supabase initialization error: $e');
    // Handle error, maybe show an error screen
  }

  // Check if running on web
  if (kIsWeb) {
    runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.mobile_off, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Web interface not available.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Text(
                  'Please use the mobile app.',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  } else {
    runApp(const ZinngleApp());
  }
}

class ZinngleApp extends StatefulWidget {
  const ZinngleApp({Key? key}) : super(key: key);

  @override
  State<ZinngleApp> createState() => _ZinngleAppState();
}

class _ZinngleAppState extends State<ZinngleApp> {
  final SupabaseAuthService _authService = SupabaseAuthService();
  final SupabaseDatabaseService _databaseService = SupabaseDatabaseService();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() {
    // Set preferred orientations
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  void dispose() {
    // Clean up resources if needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Add other providers as needed:
        // ChangeNotifierProvider(create: (_) => WalletProvider()),
        // ChangeNotifierProvider(create: (_) => ChatProvider()),
        // ChangeNotifierProvider(create: (_) => CreatorProvider()),
      ],
      child: MaterialApp(
        title: AppConfig.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        initialRoute: '/',
        onGenerateRoute: AppRouter.generateRoute,
        // Global navigation key for navigation from anywhere
        navigatorKey: GlobalKey<NavigatorState>(),
        // Handle unknown routes
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Route not found: ${settings.name}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
