import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserGetUsersEvent>(_onGetUser);
  }
  _onGetUser(UserGetUsersEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    await Future.delayed(Duration(seconds:1));
    final users = List.generate(event.count, (index) => User(name: 'user name', id: index.toString()));
    emit(UserLoadedState(users));
  }
}
