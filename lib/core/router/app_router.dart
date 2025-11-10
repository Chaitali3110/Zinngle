// lib/core/router/app_router.dart
import 'package:flutter/material.dart';
import '../../features/chat/models/chat_user.dart'; // Assuming this is the path
import '../../features/onboarding/screens/splash_screen.dart';
import '../../features/onboarding/screens/welcome_screen.dart';
import '../../features/onboarding/screens/language_selection_screen.dart';
import '../../features/auth/screens/auth_choice_screen.dart';
import '../../features/auth/screens/phone_login_screen.dart';
import '../../features/auth/screens/email_login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/screens/otp_verification_screen.dart';
import '../../features/auth/screens/user_type_selection_screen.dart';
import '../../features/auth/screens/permissions_screen.dart';
import '../../features/profile/screens/profile_setup_screen.dart';
import '../../features/profile/screens/interests_selection_screen.dart';
import '../../features/profile/screens/referral_code_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/home/screens/discover_screen.dart';
import '../../features/chat/screens/chat_list_screen.dart';
import '../../features/chat/screens/chat_screen.dart';
import '../../features/call/screens/outgoing_call_screen.dart';
import '../../features/call/screens/incoming_call_screen.dart';
import '../../features/call/screens/video_call_screen.dart';
import '../../features/call/screens/audio_call_screen.dart';
import '../../features/call/screens/call_ended_screen.dart';
import '../../features/call/screens/call_rating_screen.dart';
import '../../features/wallet/screens/wallet_screen.dart';
import '../../features/wallet/screens/add_coins_screen.dart';
import '../../features/wallet/screens/payment_method_screen.dart';
import '../../features/wallet/screens/transaction_history_screen.dart';
import '../../features/gifts/screens/gift_store_screen.dart';
import '../../features/games/screens/games_lobby_screen.dart';
import '../../features/games/screens/spin_wheel_screen.dart';
import '../../features/creator/screens/creator_profile_screen.dart';
import '../../features/creator/screens/creator_welcome_screen.dart';
import '../../features/creator/screens/creator_profile_details_screen.dart';
import '../../features/creator/screens/creator_verification_screen.dart';
import '../../features/creator/screens/creator_pricing_screen.dart';
import '../../features/creator/screens/creator_dashboard_screen.dart';
import '../../features/creator/screens/availability_screen.dart';
import '../../features/search/screens/search_screen.dart';
import '../../features/search/screens/filter_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/settings/screens/account_settings_screen.dart';
import '../../features/settings/screens/privacy_settings_screen.dart';
import '../../features/settings/screens/notification_settings_screen.dart';
import '../../features/support/screens/help_center_screen.dart';
import '../../features/support/screens/faq_screen.dart';
import '../../features/support/screens/contact_support_screen.dart';
import '../../features/support/screens/report_issue_screen.dart';
import '../../features/info/screens/about_screen.dart';
import '../../features/info/screens/terms_of_service_screen.dart';
import '../../features/info/screens/privacy_policy_screen.dart';
import '../../features/error/screens/no_internet_screen.dart';
import '../../features/error/screens/maintenance_screen.dart';
import '../../features/error/screens/update_required_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Onboarding & Auth
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/welcome':
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case '/language-selection':
        return MaterialPageRoute(builder: (_) => const LanguageSelectionScreen());
      case '/auth-choice':
        return MaterialPageRoute(builder: (_) => const AuthChoiceScreen());
      case '/phone-login':
        return MaterialPageRoute(builder: (_) => const PhoneLoginScreen());
      case '/email-login':
        return MaterialPageRoute(builder: (_) => const EmailLoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case '/otp-verification':
        return MaterialPageRoute(builder: (_) => const OTPVerificationScreen());
      case '/user-type-selection':
        return MaterialPageRoute(builder: (_) => const UserTypeSelectionScreen());
      case '/permissions':
        return MaterialPageRoute(builder: (_) => const PermissionsScreen());
      case '/profile-setup':
        return MaterialPageRoute(builder: (_) => const ProfileSetupScreen());
      case '/interests-selection':
        return MaterialPageRoute(builder: (_) => const InterestsSelectionScreen());
      case '/referral-code':
        return MaterialPageRoute(builder: (_) => const ReferralCodeScreen());
      
      // Home & Discovery
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/discover':
        return MaterialPageRoute(builder: (_) => const DiscoverScreen());
      
      // Chat
      case '/chat-list':
        return MaterialPageRoute(builder: (_) => const ChatListScreen());
      case '/chat':
        final user = settings.arguments;
        if (user == null) {
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('Error: ChatUser required for chat screen'),
              ),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => ChatScreen(
            user: user as ChatUser,
          ),
        );
      
      // Calls
      case '/outgoing-call':
        return MaterialPageRoute(builder: (_) => const OutgoingCallScreen());
      case '/incoming-call':
        return MaterialPageRoute(builder: (_) => const IncomingCallScreen());
      case '/video-call':
        return MaterialPageRoute(builder: (_) => const VideoCallScreen());
      case '/audio-call':
        return MaterialPageRoute(builder: (_) => const AudioCallScreen());
      case '/call-ended':
        return MaterialPageRoute(builder: (_) => const CallEndedScreen());
      case '/call-rating':
        return MaterialPageRoute(builder: (_) => const CallRatingScreen());
      
      // Search
      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case '/filter':
        return MaterialPageRoute(builder: (_) => const FilterScreen());
      
      // Wallet & Payments
      case '/wallet':
        return MaterialPageRoute(builder: (_) => const WalletScreen());
      case '/add-coins':
        return MaterialPageRoute(builder: (_) => const AddCoinsScreen());
      case '/payment-method':
        return MaterialPageRoute(builder: (_) => const PaymentMethodScreen());
      case '/transaction-history':
        return MaterialPageRoute(builder: (_) => const TransactionHistoryScreen());
      
      // Gifts & Games
      case '/gift-store':
        return MaterialPageRoute(builder: (_) => const GiftStoreScreen());
      case '/games-lobby':
        return MaterialPageRoute(builder: (_) => const GamesLobbyScreen());
      case '/spin-wheel':
        return MaterialPageRoute(builder: (_) => const SpinWheelScreen());
      
      // Creator
      case '/creator-welcome':
        return MaterialPageRoute(builder: (_) => const CreatorWelcomeScreen());
      case '/creator-profile':
        return MaterialPageRoute(builder: (_) => const CreatorProfileScreen());
      case '/creator-profile-details':
        return MaterialPageRoute(builder: (_) => const CreatorProfileDetailsScreen());
      case '/creator-verification':
        return MaterialPageRoute(builder: (_) => const CreatorVerificationScreen());
      case '/creator-pricing':
        return MaterialPageRoute(builder: (_) => const CreatorPricingScreen());
      case '/creator-dashboard':
        return MaterialPageRoute(builder: (_) => const CreatorDashboardScreen());
      case '/availability-screen':
        return MaterialPageRoute(builder: (_) => const AvailabilityScreen());
      
      // Settings
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case '/account-settings':
        return MaterialPageRoute(builder: (_) => const AccountSettingsScreen());
      case '/privacy-settings':
        return MaterialPageRoute(builder: (_) => const PrivacySettingsScreen());
      case '/notification-settings':
        return MaterialPageRoute(builder: (_) => const NotificationSettingsScreen());
      
      // Support
      case '/help-center':
        return MaterialPageRoute(builder: (_) => const HelpCenterScreen());
      case '/faq':
        return MaterialPageRoute(builder: (_) => const FAQScreen());
      case '/contact-support':
        return MaterialPageRoute(builder: (_) => const ContactSupportScreen());
      case '/report-issue':
        return MaterialPageRoute(builder: (_) => const ReportIssueScreen());
      
      // Info
      case '/about':
        return MaterialPageRoute(builder: (_) => const AboutScreen());
      case '/terms-of-service':
        return MaterialPageRoute(builder: (_) => const TermsOfServiceScreen());
      case '/privacy-policy':
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());
      
      // Error Screens
      case '/no-internet':
        return MaterialPageRoute(builder: (_) => const NoInternetScreen());
      case '/maintenance':
        return MaterialPageRoute(builder: (_) => const MaintenanceScreen());
      case '/update-required':
        return MaterialPageRoute(builder: (_) => const UpdateRequiredScreen());
      
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
