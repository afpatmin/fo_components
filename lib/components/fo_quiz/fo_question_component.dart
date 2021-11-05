import 'dart:async';

import 'package:angular/angular.dart';
import 'package:fo_components/pipes/capitalize_pipe.dart';

import '../../models/fo_quiz_model.dart';
import '../fo_button/fo_button_component.dart';
import 'fo_option_component.dart';
import 'fo_quiz_component.dart';

@Component(
  selector: 'fo-question',
  templateUrl: 'fo_question_component.html',
  styleUrls: ['fo_question_component.css'],
  directives: [
    FoButtonComponent,
    FoOptionComponent,
    FoQuizComponent,
    NgFor,
    NgIf
  ],
  pipes: [CapitalizePipe],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FoQuestionComponent implements AfterChanges, OnDestroy {
  bool leftHidden = true;
  bool rightHidden = true;
  bool transition = false;
  FoQuizModel? currentChildQuiz;
  final StreamController<FoQuestionModel> prevController = StreamController();
  final StreamController<FoQuestionModel> doneController = StreamController();
  final ChangeDetectorRef _changeDetectorRef;

  @Input()
  late int index;

  @Input()
  late FoQuestionModel model;

  @Input()
  bool disabled = false;

  @Input()
  String? buttonColor;

  @Input()
  String? prevButtonLabel;

  @Input()
  String? nextButtonLabel;

  FoQuestionComponent(this._changeDetectorRef);

  @Output('prev')
  Stream<FoQuestionModel> get onPrev => prevController.stream;

  @Output('done')
  Stream<FoQuestionModel> get onDone => doneController.stream;

  Iterable<FoOptionModel> get selectedOptions =>
      model.options.where((o) => o.selected);

  @override
  void ngAfterChanges() {
    leftHidden = true;
    rightHidden = true;
    transition = false;

    Future<void>.delayed(Duration(milliseconds: 100)).then((_) {
      transition = true;
    });
    Future<void>.delayed(Duration(milliseconds: 300)).then((_) {
      leftHidden = false;
    });
    Future<void>.delayed(Duration(milliseconds: 600)).then((_) {
      rightHidden = false;
      _changeDetectorRef.markForCheck();
    });
  }

  @override
  void ngOnDestroy() {
    prevController.close();
    doneController.close();
  }

  void onChildQuizDone(FoQuizDoneEvent event) {
    /// See if there is another selected option with a child quiz after this one
    /// If there is one, show that, otherwise emit done
    final index = model.options.indexOf(
        model.options.firstWhere((option) => option.child == currentChildQuiz));

    try {
      final nextOptionWithChildQuiz =
          model.options.skip(index + 1).firstWhere((option) => option.selected);

      currentChildQuiz = nextOptionWithChildQuiz.child;
      if (currentChildQuiz == null) {
        doneController.add(model);
      }
      // ignore: avoid_catching_errors, empty_catches
    } on StateError {}
  }

  void onPrevTrigger() {
    prevController.add(model);
  }

  void onNextTrigger() {
    final selected = selectedOptions;
    try {
      currentChildQuiz =
          selected.firstWhere((option) => option.child != null).child;
      // ignore: avoid_catching_errors
    } on StateError {
      doneController.add(model);
    }
  }

  void onOptionTrigger(FoOptionModel option) {
    if (model.multiSelect) {
      final index = model.options.indexOf(option);
      model.options[index] =
          model.options[index].copyWith(selected: !option.selected);
    } else {
      for (var i = 0; i < model.options.length; i++) {
        model.options[i] =
            model.options[i].copyWith(selected: model.options[i] == option);
      }
    }
  }
}
