import "package:equatable/equatable.dart";

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserEventReset extends UserEvent {
  @override
  List<Object> get props => [];
}

class GetLoggedInUserEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

class LoggedOutUserEvent extends UserEvent {
  @override
  List<Object> get props => [];
}
