import 'package:nylo_framework/nylo_framework.dart';

class Faq extends Model {
  String question;
  String answer;
  static StorageKey key = "faq";

  Faq({required this.question, required this.answer});

  Faq.fromJson(dynamic data)
      : question = data['question'] as String,
        answer = data['answer'] as String;

  @override
  toJson() {
    return {"question": question, "answer": answer};
  }
}
