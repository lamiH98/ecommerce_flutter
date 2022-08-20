import 'package:ecommerce/api.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/models/size.dart';

class SizeServices{

  static Future<List<Size>?> fetchSize() async{
    var response = await http.get(Uri.parse('$my_api/sizes'));
    if(response.statusCode == 200) {
      var jsonString = response.body;
      return sizeFromJson(jsonString);
    } else {
      return null;
    }
  }
}