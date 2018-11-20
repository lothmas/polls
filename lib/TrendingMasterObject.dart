import 'dart:core';
import 'package:stats/Trending.dart';

class TrendingMasterObject {

     List<Trending> trendingList;

     List<Trending> getTrendingList() {
        return trendingList;
    }

     void setTrendingList(List<Trending> trendingList) {
        this.trendingList = trendingList;
    }

     factory TrendingMasterObject.fromJson(Map<String, dynamic> json) {
       TrendingMasterObject df= new TrendingMasterObject.fromJson(json)  ;
       return df;
     }
}
