/// This is a simple boilerplate for a BLoC (Business Logic Component) in a single file.
/// It includes the essential components for managing state and events in a Flutter application.

import 'package:bloc/bloc.dart';

// Define the Bloc
class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {
    on<MainEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
// Define the events

class MainEvent {}

// Define the states

class MainState {}
