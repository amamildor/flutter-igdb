enum Category {
  main_game,
  dlc_addon,
  expansion,
  bundle,
  standalone_expansion
}

enum WebsiteCategory {
  official,
  wikia,
  wikipedia,
  facebook,
  twitter,
  twitch,
  instagram,
  youtube,
  iphone,
  ipad,
  android,
  steam,
  reddit,
  discord,
  google_plus,
  tumblr,
  linkedin,
  pinterest,
  soundcloud
}

String intToWebsiteCategory(int i) {
  switch (i) {
    case 1:
      return WebsiteCategoryImage[WebsiteCategory.official];
      break;
    case 2:
      return WebsiteCategoryImage[WebsiteCategory.wikia];
      break;
    case 3:
      return WebsiteCategoryImage[WebsiteCategory.wikipedia];
      break;
    case 4:
      return WebsiteCategoryImage[WebsiteCategory.facebook];
      break;
    case 5:
      return WebsiteCategoryImage[WebsiteCategory.twitter];
      break;
    case 6:
      return WebsiteCategoryImage[WebsiteCategory.twitch];
      break;
    case 8:
      return WebsiteCategoryImage[WebsiteCategory.instagram];
      break;
    case 9:
      return WebsiteCategoryImage[WebsiteCategory.youtube];
      break;
    case 10:
      return WebsiteCategoryImage[WebsiteCategory.iphone];
      break;
    case 11:
      return WebsiteCategoryImage[WebsiteCategory.ipad];
      break;
    case 12:
      return WebsiteCategoryImage[WebsiteCategory.android];
      break;
    case 13:
      return WebsiteCategoryImage[WebsiteCategory.steam];
      break;
    case 14:
      return WebsiteCategoryImage[WebsiteCategory.reddit];
      break;
    case 15:
      return WebsiteCategoryImage[WebsiteCategory.discord];
      break;
    case 16:
      return WebsiteCategoryImage[WebsiteCategory.google_plus];
      break;
    case 17:
      return WebsiteCategoryImage[WebsiteCategory.tumblr];
      break;
    case 18:
      return WebsiteCategoryImage[WebsiteCategory.linkedin];
      break;
    case 19:
      return WebsiteCategoryImage[WebsiteCategory.pinterest];
      break;
    case 20:
      return WebsiteCategoryImage[WebsiteCategory.soundcloud];
      break;
      default:
        return WebsiteCategoryImage[WebsiteCategory.official];
        break;
  }
}

const Map<WebsiteCategory, String> WebsiteCategoryImage = {
  WebsiteCategory.official: "assets/official.png",
  WebsiteCategory.wikia: "assets/wikia.png",
  WebsiteCategory.wikipedia: "assets/wikipedia.png",
  WebsiteCategory.facebook: "assets/facebook.png",
  WebsiteCategory.twitter: "assets/twitter.png",
  WebsiteCategory.twitch: "assets/twitch.png",
  WebsiteCategory.instagram: "assets/instagram.png",
  WebsiteCategory.youtube: "assets/youtube.png",
  WebsiteCategory.iphone: "assets/iphone.png",
  WebsiteCategory.ipad: "assets/ipad.png",
  WebsiteCategory.android: "assets/android.png",
  WebsiteCategory.steam: "assets/steam.png",
  WebsiteCategory.reddit: "assets/reddit.png",
  WebsiteCategory.discord: "assets/discord.png",
  WebsiteCategory.google_plus: "assets/google_plus.png",
  WebsiteCategory.tumblr: "assets/tumblr.png",
  WebsiteCategory.linkedin: "assets/linkedin.png",
  WebsiteCategory.pinterest: "assets/pinterest.png",
  WebsiteCategory.soundcloud: "assets/soundcloud.png"
};