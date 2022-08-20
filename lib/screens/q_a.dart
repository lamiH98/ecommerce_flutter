import 'package:ecommerce/controllers/QuestionAnswerController.dart';
import 'package:ecommerce/screens/widgets/custom_container.dart';
import 'package:ecommerce/screens/widgets/custom_text.dart';
import 'package:ecommerce/screens/widgets/custom_text_lang.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QA extends StatelessWidget {

  final QuestionAnswerController questionAnswerController = Get.put(QuestionAnswerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if(questionAnswerController.isLoading.value)
          return Center(child: CircularProgressIndicator());
        else
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 6.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.arrow_back)
                    ),
                    SizedBox(width: 12.0),
                    CustomText(text: 'question_answer'.tr, fontWeight: FontWeight.bold, fontSize: 18.0,),
                  ],
                ),
              ),
              Container(
                height: 1.0,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3)
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: questionAnswerController.questionAnswers.length,
                itemBuilder: (BuildContext context, int index) {
                  var questionAnswer = questionAnswerController.questionAnswers[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 8.0, left: 8.0),
                    child: ExpandablePanel(
                      collapsed: CustomText(text: ''),
                      header: Wrap(
                        children: [
                          CustomTextLang(text: questionAnswer.question, textAR: questionAnswer.questionAr, fontSize: 16.0, fontWeight: FontWeight.bold),
                          // Icon(Icons.keyboard_arrow_down, size: 30.0),
                        ],
                      ),
                      // hasIcon: true,
                      // collapsed: Text('body', softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                      theme: const ExpandableThemeData(
                        hasIcon: false,
                      ),
                      expanded: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ContainerLang(
                          child: CustomTextLang(text: questionAnswer.answer, textAR: questionAnswer.answerAr)
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
      }),
    );
  }
}