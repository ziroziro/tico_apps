import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tico_apps/application/register/register_event.dart';
import 'package:tico_apps/application/register/register_state.dart';
import 'package:tico_apps/infrastructure/auth/user_repository.dart';
import 'package:tico_apps/infrastructure/login/validators.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;
  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> transform(
    Stream<RegisterEvent> events,
    Stream<RegisterState> Function(RegisterEvent event) next,
  ) {
    final observableStream = events as Observable<RegisterEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! UsernameChanged &&
          event is! SchoolChanged &&
          event is! KelasChanged &&
          event is! EmailChanged &&
          event is! PasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is UsernameChanged ||
          event is SchoolChanged ||
          event is KelasChanged ||
          event is EmailChanged ||
          event is PasswordChanged);
    }).debounce(Duration(milliseconds: 300));
    return super.transform(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is UsernameChanged) {
      yield* _mapUsernameChangedToState(event.username);
    } else if (event is SchoolChanged) {
      yield* _mapSchoolChangedToState(event.school);
    } else if (event is KelasChanged) {
      yield* _mapKelasChangedToState(event.kelas);
    } else if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.username, event.school, event.email,
          event.password, event.role, event.kelas);
    }
  }

  Stream<RegisterState> _mapUsernameChangedToState(String username) async* {
    yield currentState.update(
      isUsernameValid: Validators.isValidUsername(username),
    );
  }

  Stream<RegisterState> _mapSchoolChangedToState(String school) async* {
    yield currentState.update(
      isUsernameValid: Validators.isValidSchool(school),
    );
  }

  Stream<RegisterState> _mapKelasChangedToState(String kelas) async* {
    yield currentState.update(
      isUsernameValid: Validators.isValidKelas(kelas),
    );
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield currentState.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
    String username,
    String school,
    String email,
    String password,
    String role,
    String kelas,
  ) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(
          username: username,
          school: school,
          email: email,
          password: password,
          role: role,
          kelas: kelas);
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
