// models/asset.dart
class Asset {
  String id;
  String location;
  int squareFeet;
  int bedroomCount;
  int floorCount;
  double bathroomCount;
  bool hasDishwasher;
  bool hasOven;
  bool hasFridge;

  Asset({
    this.id = '',
    required this.location,
    required this.squareFeet,
    required this.bedroomCount,
    required this.floorCount,
    required this.bathroomCount,
    this.hasDishwasher = false,
    this.hasOven = false,
    this.hasFridge = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'squareFeet': squareFeet,
      'bedroomCount': bedroomCount,
      'floorCount': floorCount,
      'bathroomCount': bathroomCount,
      'hasDishwasher': hasDishwasher,
      'hasOven': hasOven,
      'hasFridge': hasFridge,
    };
  }

  factory Asset.fromMap(Map<String, dynamic> map) {
    return Asset(
      id: map['id'] ?? '',
      location: map['location'],
      squareFeet: map['squareFeet'],
      bedroomCount: map['bedroomCount'],
      floorCount: map['floorCount'],
      bathroomCount: map['bathroomCount'],
      hasDishwasher: map['hasDishwasher'] ?? false,
      hasOven: map['hasOven'] ?? false,
      hasFridge: map['hasFridge'] ?? false,
    );
  }
}
