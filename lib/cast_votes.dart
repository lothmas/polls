import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stats/NomineeMasterObject.dart';

class CastVotes {
  void singleSelectionVote(NomineesEntityList nomineeList, String memberID) {
    Firestore.instance.collection('casted_votes').document().setData({
      'member_id': memberID,
      'vote_id': nomineeList.voteId,
      'nominee_id': 'test',
      'vote_number': 1
    });
  }
}
