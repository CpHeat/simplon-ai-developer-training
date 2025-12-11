import 'package:bloc/bloc.dart';

// This class provides different information about blocs :
// - state transition
// - etc...
class GrizBeeBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('${bloc.runtimeType} $transition');
    super.onTransition(bloc, transition);
  }
}
