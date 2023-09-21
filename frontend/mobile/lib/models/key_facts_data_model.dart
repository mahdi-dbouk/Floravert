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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['edibility'] = this.edibility;
    data['seasonality'] = this.seasonality;
    data['habitat'] = this.habitat;
    data['uses'] = this.uses;
    return data;
  }
}
