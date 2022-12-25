import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthEvent {
  @override
  String toString() {
    return 'AppStarted';
  }
}

class LoggedIn extends AuthEvent {
  @override
  String toString() {
    return 'LoggedIn';
  }
}

class LoggedOut extends AuthEvent {
  @override
  String toString() {
    return 'LoggedOut';
  }
}
