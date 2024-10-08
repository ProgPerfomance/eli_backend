import 'package:mysql_client/mysql_client.dart';
import 'package:uuid/uuid.dart';

class UserData {
  Future<String> createUser({
    firstName,
    lastName,
    middleName,
    role,
    company,
    email,
    password,
  }) async {
    try {
      var sql = await MySQLConnection.createConnection(
          host: 'localhost',
          port: 3306,
          userName: 'root',
          password: '1234567890',
          databaseName: 'eli');
      await sql.connect();
      String uuid = Uuid().v1();
      await sql.execute(
          "insert into users (user_id, first_name, last_name, middle_name, email, password_md5,role,company) values ('$uuid', '$firstName', '$lastName', '$middleName', '$email', MD5('$password'), '$role', '$company')");
      return uuid;
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future<String> authUserFromEmailAndPassword({
    email,
    password,
  }) async {
    var sql = await MySQLConnection.createConnection(
        host: 'localhost',
        port: 3306,
        userName: 'root',
        password: '1234567890',
        databaseName: 'eli');
    await sql.connect();
    try {
      final response = await sql.execute(
          "select user_id from users where email = '$email' and password_md5 = MD5('$password')");
      return response.rows.first.assoc()['user_id'].toString();
    } catch (e) {
      print(e);
      return 'error';
    }
  }

  Future<Map> getUserData({
    uid,
  }) async {
    var sql = await MySQLConnection.createConnection(
        host: 'localhost',
        port: 3306,
        userName: 'root',
        password: '1234567890',
        databaseName: 'eli');
    await sql.connect();
    try {
      final response =
          await sql.execute("select * from users where user_id = '$uid'");
      return response.rows.first.assoc();
    } catch (e) {
      print(e);
      return {'error': e};
    }
  }

  Future<Map> getUsers({
    uid,
  }) async {
    var sql = await MySQLConnection.createConnection(
        host: 'localhost',
        port: 3306,
        userName: 'root',
        password: '1234567890',
        databaseName: 'eli');
    await sql.connect();
    try {
      final response =
          await sql.execute("select * from users where user_id = '$uid'");
      return response.rows.first.assoc();
    } catch (e) {
      print(e);
      return {'error': e};
    }
  }

  Future createCompany({
    name,
    owner_uuid,
    sphere_type,
    capitalization_rub,
  }) async {
    try {
      var sql = await MySQLConnection.createConnection(
          host: 'localhost',
          port: 3306,
          userName: 'root',
          password: '1234567890',
          databaseName: 'eli');
      await sql.connect();
      // String uuid = Uuid().v1();
      await sql.execute(
          "insert into companies (name, owner_uuid, sphere_type, capitalization_rub) values ('$name', '$owner_uuid', $sphere_type, $capitalization_rub)");
    } catch (e) {
      print(e);
    }
  }
}
