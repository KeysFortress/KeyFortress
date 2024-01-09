abstract class IPostgresService {
  Future<bool> connect(String host, String port, String database,
      String username, String password);
  Future<Map> query(String query);
  Future<bool> close();
}
