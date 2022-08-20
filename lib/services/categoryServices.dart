import 'package:ecommerce/api.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/models/category.dart';

class CategoryServices{

  static Future<List<Category>?> fetchCategory() async{
    var response = await http.get(Uri.parse('$my_api/categories'));
    if(response.statusCode == 200) {
      var jsonString = response.body;
      return categoryFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<List<Category>?> fetchSubCategory(id) async{
    var response = await http.get(Uri.parse('$my_api/getChildCategory/$id'));
    if(response.statusCode == 200) {
      var jsonString = response.body;
      return categoryFromJson(jsonString);
    } else {
      return null;
    }
  }

}