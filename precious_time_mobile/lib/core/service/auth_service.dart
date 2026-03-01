import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'token_manager.dart';
import '../models/auth_response.dart';

class AuthService {
  final String baseUrl = "http://10.0.2.2:8080/auth"; 
  
  final _tokenManager = TokenManager();

  Future<String?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        final authData = AuthResponse.fromJson(jsonResponse);

        await _tokenManager.saveToken(authData.token);
        await _tokenManager.saveUsername(username);
        await _tokenManager.saveRoles(authData.roles);
        
        return null; 
      } else {
        return "Usuario o contraseña incorrectos";
      }
    } catch (e) {
      return "Error de conexión: $e";
    }
  }

  Future<dynamic> register({
    required String username,
    required String password,
    required String email,
    required String nombre,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/register'));

      var userJson = jsonEncode({
        'username': username,
        'password': password,
        'verifyPassword': password,
        'email': email,
        'nombre': nombre,
      });

      request.files.add(http.MultipartFile.fromString(
        'nuevoUsuario', 
        userJson,
        contentType: MediaType('application', 'json'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isNotEmpty) {
          try {
            final jsonResponse = jsonDecode(response.body);
            if (jsonResponse.containsKey('token')) {
                final authData = AuthResponse.fromJson(jsonResponse);
                await _tokenManager.saveToken(authData.token);
                await _tokenManager.saveUsername(username);
                await _tokenManager.saveRoles(authData.roles);
                return null; 
            } else {
                return "Registro exitoso, pero no se recibió token.";
            }
          } catch (e) {
            throw Exception("Error al procesar la respuesta del servidor: $e");
          }
        }
      } else if (response.statusCode >= 400) {
          try {
            final body = jsonDecode(response.body);
            return body['message'] ?? "Datos inválidos.";
          } catch (e) {
            return "Datos inválidos.";
          }
      } else {
        return "Error del servidor (${response.statusCode})";
      }
    } catch (e) {
      return "Error de conexión: $e";
    }
    return null;
  }
}