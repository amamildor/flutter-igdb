import 'package:flutter/material.dart';
import 'package:flutter_igdb/models/gameDetails.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_igdb/models/enums.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_igdb/utils.dart';

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
            _buildHeaderTextRow('About', gameDetails.summary),
            _buildHeaderTextRow('Storyline', gameDetails.storyline),
            _buildVideos(),
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
    if (content != null) {
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
    } else {
      return Container();
    }
  }

  Container _buildScreenShots() {
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
        control: null,
        viewportFraction: 0.8,
        scale: 0.9,
        itemWidth: MediaQuery.of(context).size.width * 0.9,
        layout: SwiperLayout.DEFAULT,
      ),
    );
  }

  Container _buildVideos() {
    List<Widget> videos = gameDetails.videos.map((video) =>  Container(
        child: new IconButton(
          icon: Image.network('https://img.youtube.com/vi/' + video.videoId + '/0.jpg'),
          onPressed: () => Utility.launchURL('http://www.youtube.com/watch?v=' + video.videoId, false),
        )
    )
    ).toList();
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _mediaList(videos, 200, "Videos"),
        ],
      ),
    );
  }

  Container _buildWebsites() {
    List<Widget> sites = gameDetails.websites.map((site) =>  Container(
        child: new IconButton(
          icon: Image.asset(intToWebsiteCategory(site.category)),
          onPressed: () => Utility.launchURL(site.url, true),
        )
    )
    ).toList();

    var listWidth = (sites.length * itemSize);
    var screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < listWidth) {
      return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _scrollButton(Image.asset('assets/left.png'), _moveLeft),
            _mediaList(sites, itemSize, "Websites"),
            _scrollButton(Image.asset('assets/right.png'), _moveRight),
          ],
        ),
      );
    } else {
      return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _mediaList(sites, itemSize, "Websites"),
          ],
        ),
      );
    }
  }

  SizedBox _scrollButton(Image icon, VoidCallback action) {
    return SizedBox(
      height: itemSize,
      width: 30,
      child: IconButton(
        icon: icon,
        onPressed: action,
      ),
    );
  }

  Expanded _mediaList(List<Widget> sites, double size, String title) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: size,
            child: ListView(
              scrollDirection: Axis.horizontal,
              controller: _scrollCtrlr,
              itemExtent: size,
              children: sites,
            ),
          ),
        ],
      ),
    );
  }

  _moveLeft() {
    _scrollCtrlr.animateTo(_scrollCtrlr.offset - itemSize, duration: Duration(milliseconds: 200), curve: Curves.linear);
  }

  _moveRight() {
    _scrollCtrlr.animateTo(_scrollCtrlr.offset + itemSize, duration: Duration(milliseconds: 200), curve: Curves.linear);
  }
}
