class FoDropdownOption {
  final Object? id;
  final String label;
  final String? icon;
  final String? secondaryLabel;
  final String? info;
  final String? image;

  /// Use tags to include hidden filter keywords
  final List<String> tags;

  FoDropdownOption(
    this.id,
    this.label, {
    this.icon,
    this.secondaryLabel,
    this.info,
    this.image,
    this.tags = const [],
  });
}
