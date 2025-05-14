import 'package:golden_house/Helpers/res/user_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

// Log In
  Future<AuthResponse> login(String email, String password) async {
    return await supabase.auth
        .signInWithPassword(email: email, password: password);
  }

// Register
  Future<AuthResponse> register(String email, String password) async {
    return await supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

// Log Out
  Future<void> logout() async {
    await supabase.auth.signOut();
  }

// Get User's Current Email
  String? getCurrentUserEmail() {
    final session = supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

// Get User's Current Uid
  String? getCurrentUserUid() {
    final session = supabase.auth.currentSession;
    final user = session?.user;
    return user?.id;
  }

// Save user data
  Future<void> saveUserData(userEmail, userName, userPassword, userUid) async {
    await supabase.from("golden_house").insert({
      "userUid": userUid,
      "userData": {
        "userName": userName,
        "userEmail": userEmail,
        "userPassword": userPassword,
      }
    });
  }

// retrieve Data
  Future<Map<String, dynamic>> getData() async {
   user_uid = getCurrentUserUid();
  final response = await supabase
      .from('golden_house')
      .select()
      .eq('userUid', user_uid!)
      .single();
  return response;
}

}
