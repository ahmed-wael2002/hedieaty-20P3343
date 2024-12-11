import 'package:lecture_code/common/usecases/usecase.dart';
import '../entity/event.dart';
import '../repository/event_repository.dart';

class GetAllEventsUsecase implements UseCase<List<EventEntity>?, String>{
  final EventRepository _eventRepository;
  GetAllEventsUsecase(this._eventRepository);

  @override
  Future<List<EventEntity>?> call({String? params}) async{
    try{
      return await _eventRepository.getAllEvents(params!);
    }
    catch(e){
      return [];
    }
  }

}