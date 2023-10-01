class KeyFacts {
  String? edibility;
  String? seasonality;
  String? toxicity;
  String? habitat;
  String? use;
  String? conservationStatus;

  KeyFacts({this.edibility, this.seasonality, this.habitat, this.use});

  KeyFacts.fromJson(Map<String, dynamic> json) {
    edibility = json['edibility'];
    seasonality = json['seasonality'];
    toxicity = json['toxicity'];
    habitat = json['habitat'];
    use = json['use'];
    conservationStatus = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['edibility'] = edibility;
    data['seasonality'] = seasonality;
    data['toxicity'] = toxicity;
    data['habitat'] = habitat;
    data['use'] = use;
    data['status'] = conservationStatus;
    return data;
  }
}
