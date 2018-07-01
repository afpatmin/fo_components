import 'dart:async';
import 'package:angular/angular.dart';
import '../../models/fo_quiz_model.dart';
import 'fo_question_component.dart';

class FoQuizDoneEvent {
  FoQuizDoneEvent(this.score, this.maxPoints);

  final int score;
  final int maxPoints;
}

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
      _doneController
          .add(new FoQuizDoneEvent(_calcScore(model), _calcMaxPoints(model)));
    } else {
      activeQuestion = model.questions[index + 1];
    }
  }

  int _calcScore(FoQuizModel quiz) {
    if (quiz == null) return 0;
    var score = 0;
    for (final question in quiz.questions) {
      final selectedOptions =
          question.options.where((option) => option.selected);
      for (final option in selectedOptions) {
        score += option.score;
        score += _calcScore(option.child);
      }
    }
    return score;
  }

  int _calcMaxPoints(FoQuizModel quiz) {
    if (quiz == null) return 0;
    var maxPoints = 0;

    /// Add all options in multi-selects
    for (final question in quiz.questions.where((q) => q.multiSelect == true)) {
      for (final option in question.options) {
        maxPoints += option.score;
        maxPoints += _calcMaxPoints(option.child);
      }
    }

    /// Add only highest score option in single-selects
    for (final question
        in quiz.questions.where((q) => q.multiSelect == false)) {
      final sortedOptions = new List<FoOptionModel>.from(question.options)
        ..sort((o1, o2) => o2.score - o1.score)..first.score;
      maxPoints += sortedOptions.first.score;

      for (final option in question.options) {
        maxPoints += _calcMaxPoints(option.child);
      }
    }
    return maxPoints;
  }

  FoQuestionModel activeQuestion;

  final _doneController = new StreamController<FoQuizDoneEvent>();

  @Input()
  FoQuizModel model;

  @Input()
  bool disabled = false;

  @Output('done')
  Stream<FoQuizDoneEvent> get onDone => _doneController.stream;
}
