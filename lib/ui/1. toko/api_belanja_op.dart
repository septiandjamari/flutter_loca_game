import 'package:flutter_loca_game/autentikasi/auth_service.dart';
import 'package:http/http.dart' as http;

class ApiBelanjaOP {
  static Future<http.Response> viewBarang() async {
    Uri url = Uri.parse("${AuthService.url}/dagangop/v?hal=1");
    http.Response? httpResponse = await http.get(url); 
    return httpResponse;
  }
}
