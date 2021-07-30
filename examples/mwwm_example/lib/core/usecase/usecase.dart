abstract class UseCase<ReturnType, Params> {
  Future<ReturnType> call(Params params);
}

class NoParams {}
