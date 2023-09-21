class KeyFacts {
  String? edibility;
  String? seasonality;
  String? habitat;
  String? uses;

  KeyFacts({this.edibility, this.seasonality, this.habitat, this.uses});

  KeyFacts.fromJson(Map<String, dynamic> json) {
    edibility = json['edibility'];
    seasonality = json['seasonality'];
    habitat = json['habitat'];
    uses = json['uses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['edibility'] = edibility;
    data['seasonality'] = seasonality;
    data['habitat'] = habitat;
    data['uses'] = uses;
    return data;
  }
}
