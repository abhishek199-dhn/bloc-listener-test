import "dart:async";

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
      // Emit either Loaded or Error
      try {
        yield UserLoading();

        yield UserLoaded(isUserLoaded: true);
      } on Error {
        yield UserError(message: "There is an error running the app.");
      }
    }
  }
}
