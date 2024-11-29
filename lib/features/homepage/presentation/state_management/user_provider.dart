import 'package:flutter/cupertino.dart';
import 'package:lecture_code/features/homepage/data/repository/remote/user_firestore_repository.dart';
import 'package:lecture_code/features/homepage/domain/usecase/get_user_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entity/user.dart';

class UserProvider extends ChangeNotifier{
  UserEntity? user;
  final getUserUsecase = GetUserUsecase(FirestoreRepositoryImpl());

  void setUser(String userId) async{
    user = await getUserUsecase.call(params: userId);
    notifyListeners();
  }

}