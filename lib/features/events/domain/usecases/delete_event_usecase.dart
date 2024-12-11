import 'package:lecture_code/common/usecases/usecase.dart';
import 'package:flutter/material.dart';
import 'package:lecture_code/features/events/domain/repository/event_repository.dart';
import '../entity/event.dart';

class DeleteEventUsecase implements UseCase<bool, EventEntity> {
  final EventRepository _eventRepository;
  DeleteEventUsecase(this._eventRepository);

  @override
  Future<bool> call({EventEntity? params}) async{
    try{
      if(params != null){
        await _eventRepository.deleteEvent(params);
        return true;
      }
      return false;
    }
    catch(e){
      debugPrint('Error deleting event: $e');
      return false;
    }

  }
}