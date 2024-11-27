import 'package:firebase_auth/firebase_auth.dart';
import 'package:lecture_code/features/auth/data/data_sources/fireauth_singleton.dart';
import 'package:lecture_code/features/auth/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository{

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
}