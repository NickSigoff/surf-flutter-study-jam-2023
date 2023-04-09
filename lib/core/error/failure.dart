abstract class Failure {}

class HiveFailure extends Failure {
  final String errorMessage;

  HiveFailure(this.errorMessage);
}
