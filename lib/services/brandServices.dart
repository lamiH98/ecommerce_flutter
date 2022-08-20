import 'package:ecommerce/api.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/models/brand.dart';

class BrandServices{

  static Future<List<Brand>?> fetchBrand() async{
    var response = await http.get(Uri.parse('$my_api/brands'));
    if(response.statusCode == 200) {
      var jsonString = response.body;
      return brandFromJson(jsonString);
    } else {
      return null;
    }
  }
}