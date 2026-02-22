import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  
  final _storage = const FlutterSecureStorage();

  
  static const _keyToken = 'jwt_token';
  static const _keyUser = 'username';

  Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  Future<void> saveUsername(String username) async {
    await _storage.write(key: _keyUser, value: username);
  }

  Future<String?> getUsername() async {
    return await _storage.read(key: _keyUser);
  }

  // Obtener token
  Future<String?> getToken() async {
    return await _storage.read(key: _keyToken);
  }

  // Borrar token
  Future<void> deleteToken() async {
    await _storage.delete(key: _keyToken);
  }

  Future<void> saveRoles(List<String> roles) async {
    await _storage.write(key: 'user_roles', value: roles.join(','));
  }

  Future<List<String>> getRoles() async {
    final rolesString = await _storage.read(key: 'user_roles');
    if (rolesString == null || rolesString.isEmpty) {
      return ['USER'];
    }
    return rolesString.split(
      ',',
    ); 
  }
}