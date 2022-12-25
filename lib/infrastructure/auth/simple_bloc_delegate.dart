import 'package:bloc/bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print('error: ' + error);
  }

  @override
  void onTransition(Transition transition) {
    super.onTransition(transition);
    print('transition: ' + transition.toString());
  }
}
