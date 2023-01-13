import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:letsbuy/Model/product_list_model.dart';
import 'package:letsbuy/constant.dart';

dynamic wsproductstatus;
dynamic wsproductlist;

dynamic rproductstatus;
dynamic rproductlist;

class Productlistapi {

  // Get Wholesale Product List API
  static Future getwsProducts(context, String query) async {
    // if (tokenapistatus == 200) {
      var headers = {
        'Authorization': 'Bearer ${bearer_token}', //
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'GET',
          Uri.parse(
              '$base_url/hp/user/getAllProduct'));
      request.body = json.encode("");
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      wsproductstatus = response.statusCode;
      // print();
      switch(wsproductstatus){
        case 201:
          final List wsproductlist =
          json.decode(await response.stream.bytesToString());

          // print(wsproductlist);
          return wsproductlist
              .map((json) => Product.fromJson(json))
              .where((pro) {
            final name = pro.name!.toLowerCase();
            // final price = pro.proprice.toLowerCase();
            final searchLower = query.toLowerCase();

            return name.toLowerCase().contains(searchLower); //||
            // price.contains(searchLower);
          }).toList();
          break;

        case 400:
          break;
      }
    }
  // }



  static Future getrProducts(context, String query) async {
    // if (tokenapistatus == 200) {
      var headers = {'Authorization': 'Bearer ${bearer_token}'}; //
      var request = http.Request(
          'GET',
          Uri.parse(
              '$base_url/user/getproducts'));

      request.body = '''''';

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      rproductstatus = response.statusCode;
      switch(rproductstatus){
        case 201:
          final List rproductlist =
          json.decode(await response.stream.bytesToString());
          // print("Calling: ${rproductlist}");

          return rproductlist
              .map((json) => Product.fromJson(json))
              .where((pro) {
            final name = pro.name!.toLowerCase();
            final searchLower = query.toLowerCase();
            return name.toLowerCase().contains(searchLower);
          }).toList();
          break;

        case 400:
          break;
      }
    }
  // }
}
