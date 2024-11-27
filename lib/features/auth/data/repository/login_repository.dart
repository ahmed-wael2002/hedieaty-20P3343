import 'package:firebase_auth/firebase_auth.dart';
import 'package:lecture_code/features/auth/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository{
  Future<bool> login(String email, String password) async{
      try{
        UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        return true;
      }catch(e){
      return false;
    }
  }
}