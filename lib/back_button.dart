library can_i_go_out.back_button_globals;
import 'dart:convert';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:http/http.dart';

bool deviceConnected = false;

setConnectedStatus(bool isConnected) {

  deviceConnected = isConnected;
}

bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
  print("back button pressed."); // Do some stuff.

  if (deviceConnected) {
    //todo: Fix this lines
  } else {}
  return false; // If true returns, button's previous events become disable.
}

disconnectFromDevice(ipAddress, port) async {
  // set up DELETE request arguments

  String url = 'http://' + ipAddress + ':' + port.toString() + '/api/access';
  Map<String, String> headers = {
    "Content-type": "application/json; charset=UTF-8"
  };
  Response response = await delete(url,
      headers: headers); // check the status code for the result
  int statusCode = response
      .statusCode; // this API passes back the id of the new item added to the body
  var result = json.decode(response.body);
  if (result["status"] == "OK") {
    print("disconnected from device");
  }
}