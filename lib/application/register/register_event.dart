import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super(props);
}

class UsernameChanged extends RegisterEvent {
  final String username;

  UsernameChanged({@required this.username}) : super([username]);

  @override
  String toString() => 'UsernameChanged { Username :$username }';
}

class SchoolChanged extends RegisterEvent {
  final String school;

  SchoolChanged({@required this.school}) : super([school]);

  @override
  String toString() => 'SchoolChanged { School :$school }';
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class KelasChanged extends RegisterEvent {
  final String kelas;

  KelasChanged({@required this.kelas}) : super([kelas]);

  @override
  String toString() => 'PasswordChanged { password: $kelas }';
}

class Submitted extends RegisterEvent {
  final String username;
  final String school;
  final String email;
  final String password;
  final String role;
  final String kelas;

  Submitted({
    @required this.username,
    @required this.school,
    @required this.email,
    @required this.password,
    @required this.role,
    @required this.kelas,
  }) : super([username, school, email, password]);

  @override
  String toString() {
    return 'Submitted { username: $username, school: $school, email: $email, password: $password , role: $role, kelas: $kelas}';
  }
}
