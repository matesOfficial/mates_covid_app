import 'package:covid_app/global.dart';

class StringFormatter {
  static String convertListItemsToString(List<dynamic> items) {
    String result = items[0];
    if (items.length == 1) {
      return result;
    }
    for (String item in items) {
      result = result + ", $item";
    }
    logger.d(result);
    return result;
  }

  static String shortenName(String name){
    String result = name;
    if(name.length >= 20){
      result = name.substring(0 ,21) + "...";
    }
    return result;
  }

}
