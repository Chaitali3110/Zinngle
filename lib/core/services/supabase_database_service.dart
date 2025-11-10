// lib/core/services/supabase_database_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDatabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Users CRUD
  Future<List<Map<String, dynamic>>> getUsers() async {
    final response = await _supabase
        .from('users')
        .select()
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<Map<String, dynamic>> getUserById(String userId) async {
    final response = await _supabase
        .from('users')
        .select()
        .eq('id', userId)
        .single();
    return response;
  }

  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    await _supabase
        .from('users')
        .update(data)
        .eq('id', userId);
  }

  // Creators
  Future<List<Map<String, dynamic>>> getCreators() async {
    final response = await _supabase
        .from('creators')
        .select('''
          *,
          users:user_id (
            full_name,
            profile_image_url,
            bio
          )
        ''')
        .eq('verification_status', 'APPROVED')
        .eq('is_available', true)
        .order('average_rating', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  // Messages
  Future<List<Map<String, dynamic>>> getConversation(
    String userId1,
    String userId2,
  ) async {
    final response = await _supabase
        .from('messages')
        .select()
        .or('sender_id.eq.$userId1,sender_id.eq.$userId2')
        .or('receiver_id.eq.$userId1,receiver_id.eq.$userId2')
        .order('created_at', ascending: true);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> sendMessage(Map<String, dynamic> message) async {
    await _supabase.from('messages').insert(message);
  }

  // Real-time subscriptions
  RealtimeChannel subscribeToMessages(String userId, Function(dynamic) callback) {
    return _supabase
        .channel('messages:$userId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'messages',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'receiver_id',
            value: userId,
          ),
          callback: callback,
        )
        .subscribe();
  }

  // Storage
  Future<String> uploadFile(String bucket, String path, List<int> bytes) async {
    await _supabase.storage.from(bucket).uploadBinary(path, bytes);
    return _supabase.storage.from(bucket).getPublicUrl(path);
  }

  Future<void> deleteFile(String bucket, String path) async {
    await _supabase.storage.from(bucket).remove([path]);
  }
}
