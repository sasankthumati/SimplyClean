class CheckboxOption {
  String name;
  bool isSelected;
  double cost; // Cost associated with this option

  CheckboxOption({
    required this.name,
    this.isSelected = false,
    required this.cost,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isSelected': isSelected,
      'cost': cost,
    };
  }

  factory CheckboxOption.fromMap(Map<String, dynamic> map) {
    return CheckboxOption(
      name: map['name'],
      isSelected: map['isSelected'] ?? false,
      cost: map['cost'] ?? 0.0,
    );
  }
}