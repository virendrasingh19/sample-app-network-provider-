import 'package:flutter/foundation.dart';

/// add base url based on flavor

class APIBase{
  static String get baseURL {
    if (kReleaseMode) {
      return "prod url here";
    } else {
      return "https://jsonplaceholder.typicode.com";
    }
  }
}