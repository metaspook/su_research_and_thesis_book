import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/home/home.dart';

typedef HomeBlocSelector<T> = BlocSelector<HomeCubit, HomeState, T>;
// typedef SignInBlocListener = BlocListener<SignInBloc, SignInState>;
// typedef SignInBlocConsumer = BlocConsumer<SignInBloc, SignInState>;
// typedef SignUpBlocSelector<T> = BlocSelector<SignUpBloc, SignUpState, T>;
// typedef SignUpBlocListener = BlocListener<SignUpBloc, SignUpState>;
// typedef SignUpBlocConsumer = BlocConsumer<SignUpBloc, SignUpState>;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}
