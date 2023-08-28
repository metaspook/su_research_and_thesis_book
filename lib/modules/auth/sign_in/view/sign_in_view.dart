import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/auth/auth.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

typedef SignInBlocSelector<T> = BlocSelector<SignInBloc, SignInState, T>;
typedef SignInBlocListener = BlocListener<SignInBloc, SignInState>;

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _signInFormKey = GlobalKey<FormState>();
  // TextEditingControllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // FocusNodes
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TextEditingControllers
    _emailController.dispose();
    _passwordController.dispose();
    // FocusNodes
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignInBloc>();
    const nameValidator = Validator2([LeadingOrTrailingSpace()]);
    final isLoading = context
        .select((SignInBloc bloc) => bloc.state.status == SignInStatus.loading);
    return TranslucentLoader(
      enabled: isLoading,
      child: Form(
        key: _signInFormKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 20),
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                label: Text('Email'),
                border: AppThemes.outlineInputBorder,
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                label: Text('Password'),
                border: AppThemes.outlineInputBorder,
              ),
            ),
            const SizedBox(height: 30),

            // Proceed button
            ElevatedButton.icon(
              icon: const Icon(Icons.forward_rounded),
              label: const Text('Proceed'),
              onPressed: () {
                context.go(AppRouter.home.path);
              },
            ),
          ],
        ),
      ),
    );
  }
}
