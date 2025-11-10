import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get agoraAppId => dotenv.env['c158259482934277b21580bd89b8134a'] ?? '';
  static String get supabaseUrl => dotenv.env['https://rmdkxxfgqjyedhwnnned.supabase.co'] ?? '';
  static String get supabaseAnonKey => dotenv.env['eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJtZGt4eGZncWp5ZWRod25ubmVkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk2NDkzNDEsImV4cCI6MjA3NTIyNTM0MX0.SD9Bg1e8R_pZf8BARX0Ub8yDwXo2Tg0Ra4xk6Ytatc8'] ?? '';
  static String get razorpayKey => dotenv.env['JIjiwZXNuF7pUAtAYcK6142t'] ?? '';
}