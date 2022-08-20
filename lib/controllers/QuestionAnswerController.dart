import 'package:ecommerce/services/questionAnswerServices.dart';
import 'package:get/get.dart';

class QuestionAnswerController extends GetxController{

  var isLoading = true.obs;

  var questionAnswers = [].obs;

  @override
  void onInit() {
    fetchQuestionAnswer();
    super.onInit();
  }

  void fetchQuestionAnswer() async{
    try{
      isLoading(true);
      var questionAnswer = await QuestionAnswerServices.fetchQuestionAnswer();
      if(questionAnswer != null) {
        questionAnswers.value = questionAnswer;
      }
    } finally{
      isLoading(false);
    }
  }

}