import 'package:flutter/material.dart';
import 'package:flutter_igdb/models/gameDetails.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_igdb/models/enums.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GameDetailsPage extends StatefulWidget {
  final GameDetails gameDetails;

  GameDetailsPage({Key key, @required this.gameDetails}) : super(key: key);

  @override
  _GameDetailsPageState createState() => new _GameDetailsPageState(gameDetails);
}

class _GameDetailsPageState extends State<GameDetailsPage> {
  ScrollController _scrollCtrlr;
  GameDetails gameDetails;
  _GameDetailsPageState(this.gameDetails);

  final itemSize = 40.0;

  @override
  void initState() {
    super.initState();
    _scrollCtrlr = new ScrollController();
  }
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Second Page'),
        ),
        body: ListView(
          children: <Widget>[
            _buildHeader(context),
            _buildWebsites(),
            _buildHeaderTextRow('Summary', gameDetails.summary),
            _buildHeaderTextRow('Storyline', gameDetails.storyline),
            _buildScreenShots(),
          ],
        )
    );
  }

  Container _buildHeader(BuildContext context) {
    var release = new DateTime.fromMillisecondsSinceEpoch(gameDetails.firstReleaseDate * 1000);
    var formattedRelease = formatDate(release, [yyyy, ' ', MM, ' ', dd]);
    if (formattedRelease.endsWith('1')) {
      formattedRelease = formatDate(release, [d, 'st ', M, ', ', yyyy]);
    } else if (formattedRelease.endsWith('2')) {
      formattedRelease = formatDate(release, [d, 'nd ', M, ', ', yyyy]);
    } else if (formattedRelease.endsWith('3')) {
      formattedRelease = formatDate(release, [d, 'rd ', M, ', ', yyyy]);
    } else {
      formattedRelease = formatDate(release, [d, 'th ', M, ', ', yyyy]);
    }
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network('https:' + gameDetails.cover.url.replaceAll('t_thumb', 't_cover_small')),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8, left: 5),
                  child: Text(
                    gameDetails.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8, left: 5),
                  child: Text(
                    gameDetails.involvedCompanies.firstWhere((involvedComp) => involvedComp.developer == true).company.name,
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8, left: 5),
                  child: RichText(
                      text: TextSpan(
                        // set the default style for the children TextSpans
                          style: Theme.of(context).textTheme.body1.copyWith(color: Colors.grey),
                          children: [
                            TextSpan(
                                text: 'Genres : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600]
                                )
                            ),
                            TextSpan(
                              text: gameDetails.genres.map((genre) => genre.name).join(', '),

                            ),
                          ]
                      )
                  ),
                ),
              ],
            ),
          ),
          //FavoriteWidget(),
        ],
      ),
    );
  }

  Container _buildHeaderTextRow(String title, String content) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(content),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildScreenShots() {
    List<Widget> screens = gameDetails.screenshots.map((screen) =>  Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Image.network('https:' + screen.url.replaceAll('thumb', 'screenshot_big'), fit: BoxFit.cover),
      )
    )
    ).toList();
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
      color: Colors.black87,
      height: 230,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            'https:' + gameDetails.screenshots[index].url.replaceAll('thumb', 'screenshot_big'),
            fit: BoxFit.fitWidth,
          );
        },
        autoplay: false,
        itemCount: gameDetails.screenshots.length,
        pagination: new SwiperPagination(),
        control: new SwiperControl(
          color: Colors.purple[100],
          size: 40.0,
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          iconNext: Icon(FontAwesomeIcons.chevronCircleRight).icon,
          iconPrevious: Icon(FontAwesomeIcons.chevronCircleLeft).icon,
        ),
        viewportFraction: 0.8,
        scale: 0.9,
        itemWidth: MediaQuery.of(context).size.width * 0.9,
        layout: SwiperLayout.DEFAULT,
      ),
    );
  }

  Container _buildWebsites() {
    List<Widget> sites = gameDetails.websites.map((site) =>  Container(
        child: new IconButton(
          icon: Image.asset(intToWebsiteCategory(site.category)),
          onPressed: () => _launchURL(site.url),
        )
    )
    ).toList();
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            height: itemSize,
            width: 30,
            child: IconButton(
              icon: Image.asset('assets/left.png'),
              onPressed: _moveLeft,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Websites',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: itemSize,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollCtrlr,
                    itemExtent: itemSize,
                    children: sites,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: itemSize,
            width: 30,
            child: IconButton(
              icon: Image.asset('assets/right.png'),
              onPressed: _moveRight,
            ),
          ),
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open $url';
    }
  }

  _moveLeft() {
    _scrollCtrlr.animateTo(_scrollCtrlr.offset - itemSize, duration: Duration(milliseconds: 200), curve: Curves.linear);
  }

  _moveRight() {
    _scrollCtrlr.animateTo(_scrollCtrlr.offset + itemSize, duration: Duration(milliseconds: 200), curve: Curves.linear);
  }
}
