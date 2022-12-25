import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tico_apps/application/login/login_event.dart';
import 'package:tico_apps/application/login/login_state.dart';
import 'package:tico_apps/infrastructure/auth/user_repository.dart';
import 'package:tico_apps/infrastructure/login/validators.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;
  LoginBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> transform(
    Stream<LoginEvent> events,
    Stream<LoginState> Function(LoginEvent event) next,
  ) {
    final observableStream = events as Observable<LoginEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounce(Duration(milliseconds: 300));
    return super.transform(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield currentState.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}

// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:tico_apps/application/auth/auth_bloc.dart';
// import 'package:tico_apps/application/auth/auth_event.dart';
// import 'package:tico_apps/application/login/login_event.dart';
// import 'package:tico_apps/application/login/login_state.dart';
// import 'package:tico_apps/infrastructure/auth/user_repository.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final UserRepository userRepository;
//   final AuthBloc authBloc;
//   LoginBloc({@required this.userRepository, @required this.authBloc})
//       : assert(userRepository != null),
//         assert(authBloc != null);

//   @override
//   LoginState get initialState => LoginInitial();

//   @override
//   Stream<LoginState> mapEventToState(
//     LoginState currentState,
//     LoginEvent event,
//   ) async* {
//     if (event is LoginButtonPressed) {
//       yield LoginLoading();

//       try {
//         final token = await userRepository.authenticate(
//           username: event.username,
//           password: event.password,
//         );
//         authBloc.dispatch(LoggedIn(token: token));
//         yield LoginInitial();
//       } catch (error) {
//         yield LoginFailure(error: error.toString());
//       }
//     }
//   }
// }
