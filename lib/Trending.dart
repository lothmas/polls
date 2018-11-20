class Trending {
    final String profilePic,title, owner,
      description,
      descriptionType,
      time,
      mainDisplay,
      voteType,
      voteBy,
      voteId,
      votesCasted,
      allowedVoteNumber;

    Trending({this.profilePic, this.title, this.owner, this.description,
        this.descriptionType, this.time, this.mainDisplay, this.voteType,
        this.voteBy, this.voteId, this.votesCasted, this.allowedVoteNumber});

//    factory Trending.fromJson(Map<String, dynamic> json) {
//      return Trending(
//        profilePic: json['profilePic'],
//
//      );
//    }
}



