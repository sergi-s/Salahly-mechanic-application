
abstract class Authentication{
  Future<bool> login(String email, String password);
  Future<bool> signup(String email,String password);
  // Future<bool> registration(Client client);
}