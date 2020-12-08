import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:see_joy/model/model_movie.dart';
import 'package:see_joy/screen/detail_screen.dart';

class CarouselImage extends StatefulWidget { //찜하기 버튼과 디테일 페이지띄우는 기능이 있어서 사용한다.
  final List<Movie> movies;

  CarouselImage({this.movies});

  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  List<Movie> movies;
  List<Widget> images;
  List<String> keywords;
  List<bool> likes;
  int _currentPage = 0;
  String _currentKeyword;

  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    images = movies.map((m) => Image.network(m.poster)).toList(); 
    keywords = movies.map((m) => m.keyword).toList();
    likes = movies.map((m) => m.like).toList();
    _currentKeyword = keywords[0]; //초기값지정
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
          ),
          CarouselSlider(
            items: images,
            options: CarouselOptions(onPageChanged: (index, reason) { //페이지 전환을 처리하는 온페이지
              setState(() {
                _currentPage = index;
                _currentKeyword = keywords[_currentPage];
              });
            }),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
            child: Text(
              _currentKeyword, //포스터밑 글자
              style: TextStyle(fontSize: 11), //포스터밑 글자사이즈
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, //내가찜한콘텐츠,재생,정보 등등 가운데 배치하기
              children: <Widget>[
                Container( //내가찜한콘텐츠
                  child: Column(
                    children: <Widget>[
                      likes[_currentPage]
                          ? IconButton( //체크버튼이 트루면 체크형태
                              icon: Icon(Icons.check),
                              onPressed: () {
                                setState(() {
                                  likes[_currentPage] = !likes[_currentPage];
                                  movies[_currentPage].reference.updateData(
                                      {'like': likes[_currentPage]});
                                });
                              },
                            )
                          : IconButton( //체크버튼이 트루가아니면 플러스버튼이 나오게됨
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  likes[_currentPage] = !likes[_currentPage];
                                  movies[_currentPage].reference.updateData(
                                      {'like': likes[_currentPage]});
                                });
                              },
                            ),
                      Text(
                        '내가 찜한 콘텐츠',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Container( //재생버튼
                  padding: EdgeInsets.only(right: 10),
                  child: FlatButton(
                    color: Colors.white,
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.play_arrow, // 플레이이모티콘
                          color: Colors.black, // 아이콘 색상
                        ),
                        Padding(
                          padding: EdgeInsets.all(3), //상자 크기
                        ),
                        Text(
                          '재생',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Container( //정보버튼 눌렀을때 영화정보가 인자로넘어가 detailscreen화면이 보여짐
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute<Null>( //팝업창 띄우기
                              fullscreenDialog: true,
                              builder: (BuildContext context) {
                                return DetailScreen(
                                  movie: movies[_currentPage],
                                );
                              }));
                        },
                      ),
                      Text(
                        '정보',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: makeIndicator(likes, _currentPage), //재생아래있느 동그라미버튼
          )),
        ],
      ),
    );
  }
}

List<Widget> makeIndicator(List list, int _currentPage) {//인디케이터 재생아래있는 동그라미버튼
  List<Widget> results = [];
  for (var i = 0; i < list.length; i++) {
    results.add(Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == i
            ? Color.fromRGBO(255, 255, 255, 0.9)
            : Color.fromRGBO(255, 255, 255, 0.4),
      ),
    ));
  }

  return results;
}
