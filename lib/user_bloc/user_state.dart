part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}
class UserLoadedState extends UserState {
  final List<User> users;

  UserLoadedState(this.users);
}

class UserLoadingState extends UserState {



}

class User{
  final String name;
  final String id;

  User({required this.name, required this.id});

}