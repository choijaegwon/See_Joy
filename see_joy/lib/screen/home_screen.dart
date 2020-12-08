import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:see_joy/model/model_movie.dart';
import 'package:see_joy/widget/box_slider.dart';
import 'package:see_joy/widget/carousel_slider.dart';
import 'package:see_joy/widget/circle_slider.dart';

class HomeScreen extends StatefulWidget { //영화의 데이터를 백엔드에서 가져와야하기 때문에 statefulwiget을 사용함
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: deprecated_member_use
  Firestore firestore = Firestore.instance;
  Stream<QuerySnapshot> streamData;
  @override
  void initState() { //위젯이 최초 생성되는 상황이면 호출되며 한번만호출된다
    super.initState();
    streamData = firestore.collection('movie').snapshots(); //파이어베이스에있는 무비란데이터불러오기
  }

  Widget _fetchData(BuildContext context) { //streamdata로부터 데이터를 추출하여 위젯으로 만드는 것
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('movie').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator(); //데이터를 가져오지 못했다면 로딩화면을 만들어준다
        return _buildBody(context, snapshot.data.documents); //가져왔으면 builbady를 호출하여 실제 위젯을 만드는것이다.
      },
    );
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Movie> movies = snapshot.map((d) => Movie.fromSnapshot(d)).toList();
    return ListView(
      children: <Widget>[
        Stack( //스택의 경우 children안에 선언한 순서대로 밑에 깔리게된다.
          children: <Widget>[
            CarouselImage(movies: movies),
            TopBar(),
          ],
        ),
        CircleSlider(movies: movies), //미리보기 이미지 불러오기
        BoxSlider(movies: movies), //전체목록 이미지 불러오기
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }
}

class TopBar extends StatelessWidget { // 상단바
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, //간격 맞추기
        children: <Widget>[
          Image.asset(
            'images/bbongflix_logo.png', //폴더에 있는 이미지 로고 가져오기
            fit: BoxFit.contain,
            height: 25,
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              'TV 프로그램',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '영화',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '내가 찜한 콘텐츠',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
