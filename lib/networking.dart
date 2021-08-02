import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future getData() async {
    http.Response getResponse = await http.get(url);

    if (getResponse.statusCode == 200) {
      String data = getResponse.body;

      var allData = jsonDecode(data);
      return allData;
//      print(data);
//      var long = jsonDecode(data)['coord']['lon'];
//
//      print(long);
//
//      var describe = jsonDecode(data)['weather'][0]['description'];
//      print(describe);
    } else {
      print(getResponse.statusCode);
    }
  }
}
