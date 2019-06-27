import 'package:flutter/material.dart';
import 'package:flutter_igdb/models/pulses.dart';
import 'package:flutter_igdb/models/gameSearch.dart';
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
  List<Pulses> articles = List<Pulses>();
  List<GameSearch> futureReleases;
  Timer timer;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    timer = getTimer();
    pageController = PageController(
        viewportFraction: 1.0,
        initialPage: 999
    );
  }

  Timer getTimer() {
    return Timer.periodic(Duration(seconds: 5), (_) {
      pageController.nextPage(duration: Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
    });
  }

  void pauseOnTouch() {
    timer.cancel();
    timer = Timer(Duration(seconds: 4), () {
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
            return _buildBody();
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return _buildLoader();
        },
      )
    );
  }

  Widget _buildLoader() {
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
  }

  Widget _buildBody() {
    return ListView(
      children: <Widget>[
        Container(
          height: 260.0,
          child: _buildArticles(),
        ),
        FutureBuilder<List<GameSearch>>(
            future: getFutureReleases(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                futureReleases = snapshot.data;
                return Container(
                  height: 250.0,
                  padding: EdgeInsets.all(8.0),
                  child: _buildFutureReleases(),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return _buildLoader();
            }
        ),
      ],
    );
  }

  Widget _buildArticles() {
    return GestureDetector(
      onTapDown: (_) => pauseOnTouch(),
      child: new PageView.builder(
        controller: pageController,
        itemBuilder: (context, int){
          return InkWell(
            onTap: () => Utility.launchURL(articles[int % articles.length].website.url, true),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.network(
                    articles[int % articles.length].image,
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
                          Text(articles[int % articles.length].title,
                            style: TextStyle(color: Colors.white),),
                          Text(_authorDate(articles[int % articles.length]),
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

  Widget _buildFutureReleases() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: articles.length,
      itemBuilder: (context, int){
        return InkWell(
          onTap: () => Utility.launchURL(articles[int].website.url, true),
          child: _buildReleaseCard(futureReleases[int]),
        );
      },
    );
  }

  Widget _buildReleaseCard(GameSearch cardGame) {
    return SizedBox(
      height: 260.0,
      width: 140,
      child: Card(
        //margin: EdgeInsets.all(5.0),
        elevation: 2.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 140,
              height: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0),),
                child: Image.network('https:' + cardGame.cover.url.replaceAll('thumb', 'cover_big'), fit: BoxFit.cover),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: Text(cardGame.name, style: TextStyle(fontSize: 13.0),),
            ),
            Container(
              padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
              child: Text(cardGame.firstReleaseDate == null ? 'unknown' : formatDate(new DateTime.fromMillisecondsSinceEpoch(cardGame.firstReleaseDate * 1000), [dd, '/', mm, '/', yyyy]),
                  style: TextStyle(fontSize: 11.0, color: Colors.grey[600])
            ),
            )
          ],
        ),
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