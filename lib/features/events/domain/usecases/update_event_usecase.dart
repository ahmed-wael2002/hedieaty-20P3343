import '../../../../common/usecases/usecase.dart';
import '../entity/event.dart';
import '../repository/event_repository.dart';
import 'package:flutter/material.dart';

class UpdateEventUsecase implements UseCase<bool, EventEntity> {
  final EventRepository _eventRepository;
  UpdateEventUsecase(this._eventRepository);

  @override
  Future<bool> call({EventEntity? params}) async{
    try{
      if(params != null){
        await _eventRepository.updateEvent(params);
        return true;
      }
      return false;
    }
    catch(e){
      debugPrint('Error updating event: $e');
      return false;
    }
  }
}