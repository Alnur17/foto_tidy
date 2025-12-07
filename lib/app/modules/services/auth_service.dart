import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/drive.file',
    ],
  );

  Future<GoogleSignInAccount?> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      return account;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() => _googleSignIn.signOut();

  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

  Future<Map<String, String>> getAuthHeaders() async {
    final user = _googleSignIn.currentUser ?? await _googleSignIn.signInSilently();
    if (user == null) throw Exception('User not signed in');
    final headers = await user.authHeaders;
    return headers;
  }
}
