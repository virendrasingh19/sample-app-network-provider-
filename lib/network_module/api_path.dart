enum APIPath {
  fetch_albums,
}

class APIPathHelper{
  static String getValue(APIPath path){
    switch(path){
      case APIPath.fetch_albums:
        return "/albums";
      default:
        return "";
    }
  }
}