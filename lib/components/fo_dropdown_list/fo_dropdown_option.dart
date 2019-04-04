class FoDropdownOption implements FoDropdownOptionRenderable {
  Object id;
  String icon;
  String label;
  String secondaryLabel;
  String info;

  @override
  String get renderIcon => icon;

  @override  
  Object get renderId => id;

  @override  
  String get renderInfo => info;

  @override  
  String get renderLabel => label;

  @override  
  String get renderSecondaryLabel => secondaryLabel;
}

/// Objects implementing this class can be rendered by a DropdownList
abstract class FoDropdownOptionRenderable {
  Object get renderId;
  String get renderIcon;
  String get renderLabel;
  String get renderSecondaryLabel;
  String get renderInfo;
}
