import 'package:codehub/ui/explore.dart';
import 'package:codehub/ui/news.dart';
import 'package:codehub/ui/profile.dart';
import 'package:codehub/ui/search.dart';
import 'package:flutter/material.dart';

enum TabItem { news, explore, search, profile }

String titleForTabItem(TabItem item) {
  String result;
  switch (item) {
    case TabItem.news:
      result = 'News';
      break;
    case TabItem.explore:
      result = 'Explore';
      break;
    case TabItem.search:
      result = 'Search';
      break;
    case TabItem.profile:
      result = 'Me';
      break;
  }
  return result;
}

Widget pageForTabItem(TabItem item) {
  Widget result;
  switch (item) {
    case TabItem.news:
      result = News();
      break;
    case TabItem.explore:
      result = Explore();
      break;
    case TabItem.search:
      result = Search();
      break;
    case TabItem.profile:
      result = Profile();
      break;
  }
  return result;
}

Icon iconForTabItem(TabItem item) {
  Icon result;
  switch (item) {
    case TabItem.news:
      result = Icon(Icons.list);
      break;
    case TabItem.explore:
      result = Icon(Icons.event_note);
      break;
    case TabItem.search:
      result = Icon(Icons.search);
      break;
    case TabItem.profile:
      result = Icon(Icons.account_circle);
      break;
  }
  return result;
}
