import 'dart:async';
import 'package:angular/angular.dart';
import '../../models/fo_quiz_model.dart';
import 'fo_question_component.dart';

@Component(
    selector: 'fo-quiz',
    templateUrl: 'fo_quiz_component.html',
    styleUrls: const ['fo_quiz_component.css'],
    directives: const [FoQuestionComponent, NgFor])
class FoQuizComponent implements OnInit, OnDestroy {
  @override
  void ngOnInit() {
    activeQuestion = model.questions.first;
  }

  @override
  void ngOnDestroy() {
    _doneController.close();
  }

  void onQuestionDone(FoQuestionModel question) {
    
    final index = model.questions.indexOf(question);

    if (index == model.questions.length - 1) {
      _doneController.add(model);
    } else {
      activeQuestion = model.questions[index + 1];
    }
  }

  FoQuestionModel activeQuestion;

  final StreamController<FoQuizModel> _doneController = new StreamController();

  @Input()
  FoQuizModel model;

  @Input()
  bool disabled = false;

  @Output('done')
  Stream<FoQuizModel> get onDone => _doneController.stream;
}
