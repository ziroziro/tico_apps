import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tico_apps/application/auth/auth_bloc.dart';
import 'package:tico_apps/application/auth/auth_event.dart';
import 'package:tico_apps/application/register/register_bloc.dart';
import 'package:tico_apps/application/register/register_event.dart';
import 'package:tico_apps/application/register/register_state.dart';
import 'package:tico_apps/presentation/register/register_button.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _kelasController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String radioItem = '';
  final _formKey = GlobalKey<FormState>();

  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _usernameController.text.isNotEmpty &&
      _schoolController.text.isNotEmpty &&
      _kelasController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      radioItem.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _usernameController.addListener(_onUsernameChanged);
    _schoolController.addListener(_onSchoolChanged);
    _kelasController.addListener(_onKelasChanged);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _registerBloc,
      listener: (BuildContext context, RegisterState state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Mendaftar...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).dispatch(LoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Pendaftaran Gagal'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder(
        bloc: _registerBloc,
        builder: (BuildContext context, RegisterState state) {
          return Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 30.0)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 40.0),
                  child: Image.asset(
                    'assets/images/logo_apps.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  child: TextFormField(
                    controller: _usernameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: 'Nama lengkap',
                      border: OutlineInputBorder(
                        gapPadding: 10.0,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kolom tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: _schoolController,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          gapPadding: 10.0,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        hintText: 'Sekolah'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kolom tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  child: TextFormField(
                    controller: _kelasController,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          gapPadding: 10.0,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        hintText: 'Kelas'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kolom tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          gapPadding: 10.0,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        hintText: 'Email'),
                    autovalidateMode: AutovalidateMode.always,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid
                          ? 'Kolom tidak boleh kosong'
                          : null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            gapPadding: 10.0,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          hintText: 'Kata sandi'),
                      autovalidateMode: AutovalidateMode.always,
                      obscureText: true,
                      autocorrect: false,
                      validator: (_) {
                        return !state.isPasswordValid
                            ? 'Kolom tidak boleh kosong'
                            : null;
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: FormField(
                    builder: (FormFieldState<bool> state) {
                      return Row(
                        children: [
                          Radio(
                            value: 'murid',
                            groupValue: radioItem,
                            onChanged: (val) {
                              setState(() {
                                state.setValue(true);
                                radioItem = val;
                                print('item: ' + radioItem);
                              });
                            },
                          ),
                          Text(
                            'murid',
                            style: new TextStyle(fontSize: 17.0),
                          ),
                          Radio(
                            value: 'orang tua',
                            groupValue: radioItem,
                            onChanged: (val) {
                              setState(() {
                                state.setValue(true);
                                radioItem = val;
                                print('item: ' + radioItem);
                              });
                            },
                          ),
                          Text(
                            'orang tua',
                            style: new TextStyle(fontSize: 17.0),
                          ),
                          Radio(
                            value: 'guru',
                            groupValue: radioItem,
                            onChanged: (val) {
                              setState(() {
                                state.setValue(true);
                                radioItem = val;
                                print('item: ' + radioItem);
                              });
                            },
                          ),
                          Text(
                            'guru',
                            style: new TextStyle(fontSize: 17.0),
                          ),
                        ],
                      );
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Kolom ini tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: RegisterButton(
                    onPressed: isRegisterButtonEnabled(state) &&
                            _formKey.currentState.validate()
                        ? _onFormSubmitted
                        : null,
                  ),
                ),
                FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Text(
                    'Sudah punya akun? Login',
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _schoolController.dispose();
    _kelasController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onUsernameChanged() {
    _registerBloc.dispatch(
      UsernameChanged(username: _usernameController.text),
    );
  }

  void _onSchoolChanged() {
    _registerBloc.dispatch(
      SchoolChanged(school: _schoolController.text),
    );
  }

  void _onKelasChanged() {
    _registerBloc.dispatch(
      KelasChanged(kelas: _kelasController.text),
    );
  }

  void _onEmailChanged() {
    _registerBloc.dispatch(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.dispatch(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() async {
    _registerBloc.dispatch(
      Submitted(
        username: _usernameController.text,
        school: _schoolController.text,
        kelas: _kelasController.text,
        email: _emailController.text,
        password: _passwordController.text,
        role: radioItem,
      ),
    );
  }
}
