import 'package:lecture_code/common/usecases/usecase.dart';
import '../entity/event.dart';
import '../repository/event_repository.dart';
import 'package:flutter/material.dart';

class CreateEventUsecase implements UseCase<void, EventEntity> {
  final EventRepository _eventRepository;

  CreateEventUsecase(this._eventRepository);

  @override
  Future<bool> call({EventEntity? params}) async{
    try{
      if(params != null){
        await _eventRepository.createEvent(params);
        return true;
      }
      return false;
    }
    catch(e){
      debugPrint('Error creating event: $e');
      return false;
    }
  }
}