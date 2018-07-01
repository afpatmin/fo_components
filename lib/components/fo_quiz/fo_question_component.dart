import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import '../../models/fo_quiz_model.dart';
import 'fo_option_component.dart';
import 'fo_quiz_component.dart';

@Component(
    selector: 'fo-question',
    templateUrl: 'fo_question_component.html',
    styleUrls: const ['fo_question_component.css'],
    directives: const [FoOptionComponent, FoQuizComponent, MaterialButtonComponent, MaterialIconComponent, NgFor, NgIf],
    changeDetection: ChangeDetectionStrategy.OnPush)
class FoQuestionComponent implements OnChanges, OnDestroy {
  FoQuestionComponent(this._changeDetectorRef);

  @override
  void ngOnChanges(Map<String, SimpleChange> changes) {
    leftHidden = true;
    rightHidden = true;
    transition = false;

    _changeDetectorRef.markForCheck();

    new Future.delayed(const Duration(milliseconds: 100)).then((_) {
      transition = true;
      _changeDetectorRef.markForCheck();
    });
    new Future.delayed(const Duration(milliseconds: 300)).then((_) {
      leftHidden = false;
      _changeDetectorRef.markForCheck();
    });
    new Future.delayed(const Duration(milliseconds: 600)).then((_) {
      rightHidden = false;
      _changeDetectorRef.markForCheck();
    });
  }

  @override
  void ngOnDestroy() {
    doneController.close();
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

  /// Executed when the 'next' button is triggered
  /// (Only applies to multiSelect)
  void onNextTrigger() {
    final selected = selectedOptions;

    currentChildQuiz = selected.firstWhere((option) => option.child != null, orElse: () => null)?.child;
    if (currentChildQuiz == null) {
      doneController.add(model);
    }
  }

void onChildQuizDone(FoQuizDoneEvent event) {
    /// See if there is another selected option with a child quiz after this one
    /// If there is one, show that, otherwise emit done
    final index = model.options
        .indexOf(model.options.firstWhere((option) => option.child == currentChildQuiz));
    final nextOptionWithChildQuiz = model.options.skip(index + 1).firstWhere(
        (option) => option.child != null && option.selected,
        orElse: () => null);

    currentChildQuiz = nextOptionWithChildQuiz?.child;
    if (currentChildQuiz == null) doneController.add(model);
  }


  Iterable<FoOptionModel> get selectedOptions => model.options.where((o) => o.selected);

  bool leftHidden = true;
  bool rightHidden = true;
  bool transition = false;
  FoQuizModel currentChildQuiz;

  final StreamController<FoQuestionModel> doneController =
      new StreamController();
  final ChangeDetectorRef _changeDetectorRef;

  @Input()
  FoQuestionModel model;

  @Input()
  bool disabled = false;

  @Output('done')
  Stream<FoQuestionModel> get onDone => doneController.stream;
}
