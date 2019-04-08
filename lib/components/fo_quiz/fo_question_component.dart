import 'dart:async';

import 'package:angular/angular.dart';

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
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoQuestionComponent implements AfterChanges, OnDestroy {
  bool leftHidden = true;
  bool rightHidden = true;
  bool transition = false;
  FoQuizModel currentChildQuiz;
  final StreamController<FoQuestionModel> doneController = StreamController();
  final ChangeDetectorRef _changeDetectorRef;

  @Input()
  FoQuestionModel model;

  @Input()
  bool disabled = false;
  @Input()
  String buttonColor;
  FoQuestionComponent(this._changeDetectorRef);
  @Output('done')
  Stream<FoQuestionModel> get onDone => doneController.stream;

  Iterable<FoOptionModel> get selectedOptions =>
      model.options.where((o) => o.selected);

  @override
  void ngAfterChanges() {
    leftHidden = true;
    rightHidden = true;
    transition = false;

    _changeDetectorRef.markForCheck();

    Future.delayed(const Duration(milliseconds: 100)).then((_) {
      transition = true;
      _changeDetectorRef.markForCheck();
    });
    Future.delayed(const Duration(milliseconds: 300)).then((_) {
      leftHidden = false;
      _changeDetectorRef.markForCheck();
    });
    Future.delayed(const Duration(milliseconds: 600)).then((_) {
      rightHidden = false;
      _changeDetectorRef.markForCheck();
    });
  }

  @override
  void ngOnDestroy() {
    doneController.close();
  }

  void onChildQuizDone(FoQuizDoneEvent event) {
    /// See if there is another selected option with a child quiz after this one
    /// If there is one, show that, otherwise emit done
    final index = model.options.indexOf(
        model.options.firstWhere((option) => option.child == currentChildQuiz));
    final nextOptionWithChildQuiz = model.options.skip(index + 1).firstWhere(
        (option) => option.child != null && option.selected,
        orElse: () => null);

    currentChildQuiz = nextOptionWithChildQuiz?.child;
    if (currentChildQuiz == null) doneController.add(model);
  }

  /// Executed when the 'next' button is triggered
  /// (Only applies to multiSelect)
  void onNextTrigger() {
    final selected = selectedOptions;

    currentChildQuiz = selected
        .firstWhere((option) => option.child != null, orElse: () => null)
        ?.child;
    if (currentChildQuiz == null) {
      doneController.add(model);
    }
  }

  void onOptionTrigger(FoOptionModel option) {
    currentChildQuiz = null;

    if (model.multiSelect == false) {
      final others = model.options.where((o) => o != option);
      for (final o in others) {
        o.selected = false;
      }
    }

    if (model.multiSelect) {
    } else if (option.selected && option.child != null) {
      currentChildQuiz = option.child;
    } else {
      if (option.selected) {
        doneController.add(model);
      }
    }
  }
}
