import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final message;
  final otherMessage;
  Failure(this.message, {this.otherMessage});

  @override
  List<Object> get props => [message, otherMessage];
}

// General failures
class ServerFailure extends Failure {
  ServerFailure(message, {otherMessage}) : super(message, otherMessage:otherMessage );
  // final String message;

  // ServerFailure({this.message});
}

class CacheFailure extends Failure {
  CacheFailure(message) : super(message);
}
