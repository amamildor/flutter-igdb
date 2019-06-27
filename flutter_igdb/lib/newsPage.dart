import 'package:flutter/material.dart';
import 'package:flutter_igdb/models/pulses.dart';
import 'package:flutter_igdb/services/services.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_igdb/utils.dart';
import 'dart:async';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => new _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Pulses> articles;
  int initialPage = 0;
  int realPage = 10000;
  Timer timer;
  PageController pageController = PageController(
    viewportFraction: 1.0,
    initialPage: 0
  );

  @override
  void initState() {
    super.initState();

    timer = getTimer();
  }

  Timer getTimer() {
    return Timer.periodic(Duration(seconds: 4), (_) {
      pageController.nextPage(duration: Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
    });
  }

  void pauseOnTouch() {
    timer.cancel();
    timer = Timer(Duration(seconds: 3), () {
      timer = getTimer();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Pulses>>(
        future: getPulses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            articles = snapshot.data;
            return Container(
              height: 250.0,
              child: _buildArticles(),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(
            child: Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                  color: Colors.purple[300],
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: Center(
                  child: SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: CircularProgressIndicator(),
                  )
              ),
            ),
          );
        },
      )
    );
  }

  Widget _buildArticles() {
    return GestureDetector(
      onTapDown: (_) => pauseOnTouch(),
      child: new PageView.builder(
        controller: pageController,
        itemCount: articles.length,
        itemBuilder: (context, int){
          return InkWell(
            onTap: () => Utility.launchURL(articles[int].website.url, true),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.network(
                    articles[int].image,
                    scale: 2.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  height: 70,
                  bottom: 0.0,
                  child: Container(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    color: Color.fromRGBO(0, 0, 0, 0.70),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(articles[int].title,
                            style: TextStyle(color: Colors.white),),
                          Text(_authorDate(articles[int]),
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.left,),
                        ]
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _authorDate(Pulses pulse) {
    var publishedDate = formatDate(new DateTime.fromMillisecondsSinceEpoch(pulse.publishedAt * 1000), [dd, '/', mm, '/', yyyy]);
    if (pulse.author != null) {
      return 'by ' + pulse.author + ' - ' + publishedDate;
    } else {
      return 'published on ' + publishedDate;
    }
  }
}