import "dart:async";
import 'dart:math';

import "package:bloc/bloc.dart";

import "user_event.dart";
import "user_state.dart";

class UserBloc extends Bloc<UserEvent, UserState> {
  static UserState initialState = UserInitial();

  UserBloc() : super(initialState);

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    print("event" + event.toString());
    if (event is GetLoggedInUserEvent) {
      try {
        yield UserLoading();

        await Future<void>.delayed(const Duration(seconds: 2));
        bool userLoaded = Random().nextInt(100) % 2 == 0;

        if (userLoaded) {
          yield UserLoaded(isUserLoaded: true);
        } else {
          yield UserLoggedOut();
        }
      } on Error {
        yield UserError(message: "There is an error running the app.");
      }
    }
  }
}
