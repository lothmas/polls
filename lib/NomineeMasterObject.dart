class NomineeMasterObject {
  List<NomineesEntityList> nomineesEntityList;

  NomineeMasterObject({this.nomineesEntityList});

  NomineeMasterObject.fromJson(Map<String, dynamic> json) {
    if (json['nomineesEntityList'] != null) {
      nomineesEntityList = new List<NomineesEntityList>();
      json['nomineesEntityList'].forEach((v) {
        nomineesEntityList.add(new NomineesEntityList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nomineesEntityList != null) {
      data['nomineesEntityList'] =
          this.nomineesEntityList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NomineesEntityList {
  int id;
  int voteId;
  String nomineeName;
  String nomineeImage;
  String nomineesDescription;
  int enabled;

  NomineesEntityList(
      {this.id,
        this.voteId,
        this.nomineeName,
        this.nomineeImage,
        this.nomineesDescription,
        this.enabled});

  NomineesEntityList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voteId = json['voteId'];
    nomineeName = json['nomineeName'];
    nomineeImage = json['nomineeImage'];
    nomineesDescription = json['nomineesDescription'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['voteId'] = this.voteId;
    data['nomineeName'] = this.nomineeName;
    data['nomineeImage'] = this.nomineeImage;
    data['nomineesDescription'] = this.nomineesDescription;
    data['enabled'] = this.enabled;
    return data;
  }
}
