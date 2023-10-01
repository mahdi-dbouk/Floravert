class KeyFacts {
  String? edibility;
  String? seasonality;
  String? toxicity;
  String? habitat;
  String? uses;
  String? conservationStatus;

  KeyFacts({this.edibility, this.seasonality, this.habitat, this.uses});

  KeyFacts.fromJson(Map<String, dynamic> json) {
    edibility = json['edibility'];
    seasonality = json['seasonality'];
    toxicity = json['toxicity'];
    habitat = json['habitat'];
    uses = json['uses'];
    conservationStatus = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['edibility'] = edibility;
    data['seasonality'] = seasonality;
    data['toxicity'] = toxicity;
    data['habitat'] = habitat;
    data['uses'] = uses;
    data['status'] = conservationStatus;
    return data;
  }
}
