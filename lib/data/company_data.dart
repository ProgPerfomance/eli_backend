import 'package:mysql_client/mysql_client.dart';
import 'package:uuid/uuid.dart';

class CompanyData {
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

  Future<List> getCompanies() async {
    List companies = [];
    try {
      var sql = await MySQLConnection.createConnection(
          host: 'localhost',
          port: 3306,
          userName: 'root',
          password: '1234567890',
          databaseName: 'eli');
      await sql.connect();
      // String uuid = Uuid().v1();
      final response = await sql.execute("select * from companies");
      for (var item in response.rows) {
        companies.add(item.assoc());
      }
      return companies;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
