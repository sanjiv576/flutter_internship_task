import 'dart:convert';

import 'package:http/http.dart' as http;

class OnlineStore {

  
  Future getData() async {
    String url = 'https://fakestoreapi.com/products';

    http.Response res = await http.get(Uri.parse(url));

    // fetch data successfull then decode it and return
    if (res.statusCode == 200) {
      String data = res.body;
      // decode the body data
      return jsonDecode(data);
    } else {
      print('Error, status code: ${res.statusCode} ');
    }
  }
}
