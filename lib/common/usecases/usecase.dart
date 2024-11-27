// For clean code -- all usecases have a call method
abstract class UseCase<Type,Params> {
  Future<Type> call({Params params});
}