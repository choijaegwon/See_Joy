import 'package:flutter/material.dart';
import 'package:see_joy/screen/detail_screen.dart';
import 'package:see_joy/screen/home_screen.dart';
import 'package:see_joy/screen/like_screen.dart';
import 'package:see_joy/screen/more_screen.dart';
import 'package:see_joy/screen/search_screen.dart';
import 'package:see_joy/widget/bottom_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> { //MyApp에 대한 상태 관리
  TabController controller; //탭컨트롤러을 전역선언

  @override
  Widget build(BuildContext context) {
    return MaterialApp( //메테리얼 앱설정
      title: 'SeeJoy', //위에 제목
      theme: ThemeData( //전체적인 테마
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.white,
      ),
      home: DefaultTabController(
        length: 4, //length는 탭바의 길이,종류(홈, 검색, 저장한 콘텐츠 목록, 더보기)
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(), //화면에서 옆으로 스크롤로 넘기는 기능을 막는 기능
            children: <Widget>[
              HomeScreen(), //홈화면 스크린
              SearchScreen(), //검색화면 스크린
              LikeScreen(), // 찜목록 스크린
              MoreScreen(), // 더보기 스크린
            ],
          ),
          bottomNavigationBar: Bottom(), //위젯폴더에 기능추가함
        ),
      ),
    );
  }
}
