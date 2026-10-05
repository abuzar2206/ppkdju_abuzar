import 'api_service.dart';
import 'preference_service.dart';
import '../models/user_model.dart';

class AuthResult {
  final bool success;
  final String message;
  final UserModel? user;

  AuthResult({
    required this.success,
    required this.message,
    this.user,
  });
}

class AuthService {
  static Future<AuthResult> login(
    String email,
    String password,
  ) async {
    final result = await ApiService.post(
      '/api/login',
      {
        'email': email.trim(),
        'password': password,
      },
    );

    if (result['success'] == true && result['data'] != null) {
      final data = result['data'];
      final token = data['token'];
      if (token != null) {
        await PreferenceService.saveToken(token.toString());
      }

      UserModel? user;
      if (data['user'] != null) {
        user = UserModel.fromJson(data['user']);
        await PreferenceService.saveUser(user);
      }

      return AuthResult(
        success: true,
        message: result['message'] ?? 'Login berhasil',
        user: user,
      );
    }

    return AuthResult(
      success: false,
      message: result['message'] ?? 'Login gagal. Periksa kembali email dan password.',
    );
  }

  static Future<AuthResult> register(
    String name,
    String email,
    String password,
  ) async {
    final result = await ApiService.post(
      '/api/register',
      {
        'name': name.trim(),
        'email': email.trim(),
        'password': password,
      },
    );

    if (result['success'] == true && result['data'] != null) {
      final data = result['data'];
      final token = data['token'];
      if (token != null) {
        await PreferenceService.saveToken(token.toString());
      }

      UserModel? user;
      if (data['user'] != null) {
        user = UserModel.fromJson(data['user']);
        await PreferenceService.saveUser(user);
      }

      return AuthResult(
        success: true,
        message: result['message'] ?? 'Registrasi berhasil',
        user: user,
      );
    }

    return AuthResult(
      success: false,
      message: result['message'] ?? 'Registrasi gagal.',
    );
  }

  static Future<UserModel?> getProfile() async {
    final result = await ApiService.get('/api/profile');

    if (result['success'] == true && result['data'] != null) {
      final user = UserModel.fromJson(result['data']);
      await PreferenceService.saveUser(user);
      return user;
    }

    return PreferenceService.getUser();
  }

  static Future<AuthResult> updateProfile(String name) async {
    final result = await ApiService.put(
      '/api/profile',
      {
        'name': name.trim(),
      },
    );

    if (result['success'] == true && result['data'] != null) {
      final user = UserModel.fromJson(result['data']);
      await PreferenceService.saveUser(user);
      return AuthResult(
        success: true,
        message: result['message'] ?? 'Profil berhasil diperbarui',
        user: user,
      );
    }

    return AuthResult(
      success: false,
      message: result['message'] ?? 'Gagal memperbarui profil',
    );
  }

  static Future<void> logout() async {
    await PreferenceService.logout();
  }
}
