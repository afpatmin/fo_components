class FoDropdownOption implements FoDropdownOptionRenderable {
  Object id;
  String icon;
  String label;
  String secondaryLabel;
  String info;
  String image;
  List<String> tags;

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

  @override
  String get renderImage => image;

  @override
  List<String> get renderTags => tags;
}

/// Objects implementing this class can be rendered by a DropdownList
abstract class FoDropdownOptionRenderable {
  Object get renderId;
  String get renderIcon;
  String get renderImage;
  String get renderLabel;
  String get renderSecondaryLabel;
  String get renderInfo;

  /// Use tags to include hidden filter keywords
  List<String> get renderTags;
}
