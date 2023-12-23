import 'package:basebloc/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basebloc/counter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counterBloc = CounterBloc()
      ..add(CounterIncEvent());
    final userBloc = UserBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (context) => counterBloc,
        ),
        BlocProvider<UserBloc>(
          create: (context) => userBloc,
        ),
      ],
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                counterBloc.add(CounterIncEvent());
              },
              icon: const Icon(Icons.plus_one),
            ),
            IconButton(
              onPressed: () {
                counterBloc.add(CounterDecEvent());
              },
              icon: const Icon(Icons.exposure_minus_1),
            ),
            IconButton(
              onPressed: () {
                userBloc.add(UserGetUsersEvent(counterBloc.state));
              },
              icon: const Icon(Icons.person),
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
              child: Column(
                children: [
                  BlocBuilder<CounterBloc, int>(bloc: counterBloc,builder: (context, state) {

                    return Text(
                        state.toString(), style: const TextStyle(fontSize: 33));
                  }),
                  BlocBuilder<UserBloc, UserState>(
                      bloc: userBloc, builder: (context, state) {
                    return Column(
                      children: [
                        if(state is UserLoadingState)
                        const CircularProgressIndicator(),
                        if(state is UserLoadedState)
                          ...state.users.map((e) => Text(e.name)),
                      ],
                    );
                  }),
                ],
              )),
        ),
      ),
    );
  }
}
