import 'package:flutter/cupertino.dart';
import 'package:lecture_code/features/homepage/data/repository/remote/user_firestore_repository.dart';
import 'package:lecture_code/features/homepage/domain/usecase/get_user_usecase.dart';

import '../../domain/entity/user.dart';
import '../../domain/usecase/add_friend_usecase.dart';
import '../../domain/usecase/get_all_friends_usecase.dart';
import '../../domain/usecase/remove_friend_usecase.dart';

class UserProvider extends ChangeNotifier{
  UserEntity? user;
  final getUserUsecase = GetUserUsecase(FirestoreRepositoryImpl());
  final addFriendUsecase = AddFriendUsecase(FirestoreRepositoryImpl());
  final getAllFriendsUsecase = GetAllFriendsUsecase(FirestoreRepositoryImpl());
  final removeFriendUsecase = RemoveFriendUsecase(FirestoreRepositoryImpl());

  void setUser(String userId) async{
    user = await getUserUsecase.call(params: userId);
    notifyListeners();
  }

  void addFriend(String phoneNumber) async{
    await addFriendUsecase.call(params: AddFriendParams(user!, phoneNumber));
    notifyListeners();
  }

  Future<List<UserEntity>> getAllFriends() async{
    return await getAllFriendsUsecase.call(params: user!.uid) ?? [];
  }

  void removeFriend(UserEntity friend) async{
    await removeFriendUsecase.call(params: RemoveFriendParams(user!, friend));
    notifyListeners();
  }

}