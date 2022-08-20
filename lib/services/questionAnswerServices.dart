import 'package:ecommerce/api.dart';
import 'package:ecommerce/models/questionAnswer.dart';
import 'package:http/http.dart' as http;

class QuestionAnswerServices{

  static Future<List<QuestionAnswer>?> fetchQuestionAnswer() async{
    var response = await http.get(Uri.parse('$my_api/questionAnswer'));
    if(response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);
      return questionAnswerFromJson(jsonString);
    } else {
      return null;
    }
  }
}