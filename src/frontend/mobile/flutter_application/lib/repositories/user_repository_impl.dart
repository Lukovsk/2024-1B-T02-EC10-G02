import 'package:dio/dio.dart';
import 'package:flutter_application/models/user_model.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserModel> getUser(String user) async {
   try{
    final result = await Dio().get('https://jsonplaceholder.typicode.com/users?email=');
    return UserModel.fromJson(result.data);
   } on DioException catch(e){
     throw Exception(e.message);
   }
  } 
}