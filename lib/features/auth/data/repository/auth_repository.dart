import 'package:firebase_auth/firebase_auth.dart';
import 'package:lecture_code/features/auth/data/data_sources/fireauth_singleton.dart';
import 'package:lecture_code/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{

  @override
  Future<bool> login(String email, String password) async{
    try{
      User? user = await FirebaseAuthSingleton.instance.signInWithEmailAndPassword(email, password);
      return true;
    }
    catch(e){
      return false;
    }
  }

  @override
  Future<bool> register(String name, String email, String password) async{
    return await FirebaseAuthSingleton.instance.registerNewUser(name: name, email: email, password: password) ?? false;
  }
}