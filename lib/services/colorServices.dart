import 'package:ecommerce/api.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/models/color.dart';

class ColorServices{

  static Future<List<Color>?> fetchColor() async{
    var response = await http.get(Uri.parse('$my_api/colors'));
    if(response.statusCode == 200) {
      var jsonString = response.body;
      return colorFromJson(jsonString);
    } else {
      return null;
    }
  }
}