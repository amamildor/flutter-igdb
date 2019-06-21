import 'package:flutter/material.dart';
import 'package:flutter_igdb/models/gameDetails.dart';
import 'package:date_format/date_format.dart';

class GameDetailsPage extends StatelessWidget {
  final GameDetails gameDetails;

  GameDetailsPage({Key key, @required this.gameDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: ListView(
        children: <Widget>[
          _buildHeader(context),
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
      child: Image.network('https:' + screen.url.replaceAll('thumb', 'screenshot_big')),
    )
    ).toList();
    return Container(
      color: Colors.black87,
      height: 230,
      child: PageView(
        scrollDirection: Axis.horizontal,
        children: screens,
        pageSnapping: true,
      ),
    );
  }
}
