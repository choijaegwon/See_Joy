import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String title; //제목
  final String keyword; //키워드
  final String poster; //포스터
  final bool like; //영화 찜기능 boolean 타입으로  구분함
  final DocumentReference reference; //해당데이터 컬럼을 참조할수 있는 링크이다

  Movie.fromMap(Map<String, dynamic> map, {this.reference}) //이걸이용해 해당데이터에 대한CRUD기능으 간단하게 처리할 수 있다.
      : title = map['title'],
        keyword = map['keyword'],
        poster = map['poster'],
        like = map['like'];

  Movie.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Movie<$title:$keyword>"; //인스턴스를 출력할때 용이하기 위해서
}