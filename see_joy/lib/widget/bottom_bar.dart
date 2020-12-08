import 'package:flutter/material.dart';

class Bottom extends StatelessWidget { //상태관리가 필요없기떄문에 statelesswidget을 사용함
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Container(
        height: 70, //높이
        child: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: Colors.transparent,
          tabs: <Widget>[
            Tab(
              icon: Icon( //아이콘
                Icons.home,  //아이콘이미지
                size: 18, //아이콘사이즈
              ),
              child: Text(
                '홈',
                style: TextStyle(fontSize: 9),//글자 사이즈
              ),
            ),
            Tab(
              icon: Icon(
                Icons.search,
                size: 18,
              ),
              child: Text(
                '검색',
                style: TextStyle(fontSize: 9),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.save_alt,
                size: 18,
              ),
              child: Text(
                '찜 목록',
                style: TextStyle(fontSize: 8),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.list,
                size: 18,
              ),
              child: Text(
                '더보기',
                style: TextStyle(fontSize: 9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
