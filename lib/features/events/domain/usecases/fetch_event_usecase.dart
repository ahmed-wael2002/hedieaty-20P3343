

import 'package:lecture_code/common/usecases/usecase.dart';

import '../entity/event.dart';
import '../repository/event_repository.dart';
import 'package:flutter/material.dart';

class FetchEventUsecase implements UseCase<EventEntity?, String>{
  final EventRepository _eventRepository;

  FetchEventUsecase(this._eventRepository);

  @override
  Future<EventEntity?> call({String? params}) async{
    try{
      if(params != null){
        return await _eventRepository.fetchEvent(params);
      }
    }
    catch(e){
      debugPrint('Error fetching event: $e');
      return null;
    }
    return null;
  }
}