import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthState extends Equatable {
  AuthState([List props = const []]) : super(props);
}

class Uninitialized extends AuthState {
  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AuthState {
  @override
  String toString() => 'Authenticated';
}

class UnAuthenticated extends AuthState {
  @override
  String toString() => 'UnAuthenticated';
}
