// lib/features/users/presentation/state_management/user_provider.dart

import 'package:flutter/material.dart';
import 'package:lecture_code/features/notification/domain/Entities/add_friend_subject.dart';
import 'package:lecture_code/features/notification/domain/Entities/notification_observer.dart';
import 'package:lecture_code/features/users/data/repository/remote/user_firestore_repository.dart';
import 'package:lecture_code/features/users/domain/usecase/get_user_usecase.dart';
import 'package:lecture_code/features/users/domain/usecase/update_user_usecase.dart';

import '../../../events/domain/entity/event.dart';
import '../../domain/entity/user.dart';
import '../../domain/usecase/add_event_usecase.dart';
import '../../domain/usecase/add_friend_usecase.dart';
import '../../domain/usecase/get_all_friends_usecase.dart';
import '../../domain/usecase/remove_event_usecase.dart';
import '../../domain/usecase/remove_friend_usecase.dart';

class UserProvider extends ChangeNotifier {
  String userName = '';
  UserEntity? user;
  AddFriendSubject? friendSubject;
  NotificationObserver? notificationObserver;

  final getUserUsecase = GetUserUsecase(FirestoreRepositoryImpl());
  final addFriendUsecase = AddFriendUsecase(FirestoreRepositoryImpl());
  final getAllFriendsUsecase = GetAllFriendsUsecase(FirestoreRepositoryImpl());
  final removeFriendUsecase = RemoveFriendUsecase(FirestoreRepositoryImpl());
  final addEventUsecase = AddEventUsecase(FirestoreRepositoryImpl());
  final removeEventUsecase = RemoveEventUsecase(FirestoreRepositoryImpl());
  final updateUserUsecase = UpdateUserUsecase(FirestoreRepositoryImpl());

  void setUser(String? userId) async {
    if (userId != null) {
      user = await getUserUsecase.call(params: userId);
      userName = user!.name ?? '';
      friendSubject = AddFriendSubject();
      notificationObserver = NotificationObserver(friendSubject!);
      notifyListeners();
    }
  }

  String getUserName(){
    return userName;
  }

  Future<UserEntity?> getUser(String userId) async{
    return await getUserUsecase.call(params: userId);
  }

  Future<bool> updateUser(UserEntity newUser) async {
    bool? success = await updateUserUsecase.call(params: newUser);
    if (success != null && success) {
      user = newUser; // Update the local user
      notifyListeners(); // Notify listeners after updating the user
      return true;
    }
    notifyListeners();
    return false;
  }

  void addFriend(String phoneNumber) async {
    await addFriendUsecase.call(params: AddFriendParams(user!, phoneNumber));
    notifyListeners();
  }

  Future<List<UserEntity>> getAllFriends() async {
    return await getAllFriendsUsecase.call(params: user!.uid) ?? [];
  }

  void removeFriend(UserEntity friend) async {
    await removeFriendUsecase.call(params: RemoveFriendParams(user!, friend));
    notifyListeners();
  }

  void removeEvent(EventEntity event) async {
    await removeEventUsecase.call(params: RemoveEventParams(user!, event));
    notifyListeners();
  }

  void addEvent(EventEntity event) async {
    await addEventUsecase.call(params: AddEventParams(user!, event));
    notifyListeners();
  }
}