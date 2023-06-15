import 'package:http/http.dart' as http;

import '../Utils/Api.dart';

class ProductService {
  static Future<http.Response> fetchDetailProduct(idProduct) async {
    String url = Api.urlgetproductbyid + "/$idProduct";
    return await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
