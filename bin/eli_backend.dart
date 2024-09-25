

import 'dart:convert';

import 'package:eli_backend/data/user_data.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

void main() async {
  Router router= Router();

  router.post('/createUser', (Request request) async {
    try {
      var json = await request.readAsString();
      var data = jsonDecode(json);
      print(data);
        final response = await UserData().createUser(
            firstName: data['first_name'],
            lastName: data['last_name'],
            middleName: data['middle_name'],
            role: data['role'],
            company: data['company'],
            email: data['email'],
            password: data['password']);
        print(response);
        return Response.ok(response);

    } catch (e) {
      return Response.badRequest(body: 'Incorrect user data. $e');
    }
  });
  router.post('/auth', (Request request) async {
    var json = await request.readAsString();
    var data = jsonDecode(json);
    final response = await UserData().authUserFromEmailAndPassword(email: data['email'], password: data['password']);
    return Response.ok(response.toString());
  });
  router.post('/getUserData', (Request request) async {
    var json = await request.readAsString();
    var data = jsonDecode(json);
    final response = await UserData().getUserData(uid: data['uid']);
    return Response.ok(jsonEncode(response));
  });

  final server = await serve(router, 'localhost', 2308);
}


