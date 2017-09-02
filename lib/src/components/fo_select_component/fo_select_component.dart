// Copyright (c) 2017, Patrick Minogue. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import '../../pipes/phrase_pipe.dart';
import '../../models/fo_model.dart';

@Component(
    selector: 'fo-select',
    styleUrls: const ['fo_select_component.css'],
    templateUrl: 'fo_select_component.html',
    directives: const [CORE_DIRECTIVES, materialDirectives],
    pipes: const [PhrasePipe],
    changeDetection: ChangeDetectionStrategy.OnPush
)
class FoSelectComponent implements OnInit, OnDestroy
{
  FoSelectComponent()
  {
    _selectionChangeListener = selectionModel.selectionChanges.listen(_onSelectionChanges);
  }

  void ngOnInit()
  {
    /*
    if (allowNullSelection)
    {
      options.optionsList.add(null);
      options = new StringSelectionOptions(options.optionsList);
    }
    */
  }

  /*
  void ngOnChanges(Map<String, SimpleChange> changes)
  {
    if (changes.containsKey("options") && options != null)
    {


    }
  }
*/
  void ngOnDestroy()
  {
    _onVisibleChangeController.close();
    _onSelectedModelChangeController.close();
    _selectionChangeListener.cancel();
  }

  void setVisible(bool flag)
  {
    if (!disabled) visible = flag;
  }

  void _onSelectionChanges(List<SelectionChangeRecord<FoModel>> e)
  {
    if (e.isEmpty) return;
    if (e.first.added.isNotEmpty) selectedModel = e.first.added.first;
    _onSelectedModelChangeController.add(selectedModel);
  }

  void clearSelection()
  {
    selectionModel.clear();
    selectedModel = null;
    _onSelectedModelChangeController.add(null);
  }

  SelectionModel<FoModel> selectionModel = new SelectionModel.withList(allowMulti: false);
  StreamSubscription<List<SelectionChangeRecord<FoModel>>> _selectionChangeListener;
  final StreamController<bool> _onVisibleChangeController = new StreamController();
  final StreamController<FoModel> _onSelectedModelChangeController = new StreamController();

  @Input('allowNullSelection')
  bool allowNullSelection = false;

  @Input('label')
  String label = "";


  /*
  @Input('nullSelectionButtonText')
  String nullSelectionButtonText = "-";
*/
  @Input('disabled')
  bool disabled = false;

  @Input('fullWidth')
  bool fullWidth = false;

  @Input('options')
  StringSelectionOptions<FoModel> options = new StringSelectionOptions<FoModel>([]);

  @Input('selectedModel')
  FoModel selectedModel;

  @Input('showSearch')
  bool showSearch = false;

  @Input('tooltip')
  String tooltip;

  @Input('visible')
  bool visible = false;

  @Output('selectedModelChange')
  Stream<FoModel> get onSelectedModelChangeOutput => _onSelectedModelChangeController.stream;

  @Output('visibleChange')
  Stream<bool> get onVisibleChangeOutput => _onVisibleChangeController.stream;
}

class NullSelection extends FoModel
{
  NullSelection([this._label = "-"]) : super(null);

  @override
  String toString() => _label;

  final String _label;
}

/*
class FoSelectionOptions<FoModel> extends StringSelectionOptions<FoModel> //implements Selectable
{
  FoSelectionOptions(List<FoModel> options) : super(options, toFilterableString: (FoModel option) => option.toString());

  FoSelectionOptions.withOptionGroups(List<OptionGroup> optionGroups) :
        super.withOptionGroups(optionGroups, toFilterableString: (FoModel option) => option.toString());

  /*
  @override
  SelectableOption getSelectable(item)
  {
    return item is DataTableModel ? SelectableOption.Selectable : SelectableOption.Disabled;
  }
  */

}*/