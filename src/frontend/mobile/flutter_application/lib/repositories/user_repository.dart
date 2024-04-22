import 'package:flutter_application/models/user_model.dart';

abstract interface class UserRepository {
  Future<UserModel> getUser(String email);

}