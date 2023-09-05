import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/auth/auth.dart';
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
  void initState() {
    super.initState();
    // Restore form state.
    _emailController.text = context.read<SignInBloc>().state.email;
    _passwordController.text = context.read<SignInBloc>().state.password;
  }

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
    // const nameValidator = Validator2([LeadingOrTrailingSpace()]);
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
            // E-mail
            TextFormField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              validator: Validator.email,
              onFieldSubmitted: _emailFocusNode.onSubmitted,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: AppThemes.outlineInputBorder,
                label: Text('E-mail'),
              ),
              onChanged: (value) => bloc.add(SignInEdited(email: value)),
            ),
            const SizedBox(height: 20),
            // Password
            Builder(
              builder: (context) {
                final isEmptyPassword = context
                    .select((SignInBloc bloc) => bloc.state.password.isEmpty);
                final obscurePassword = context
                    .select((SignInBloc bloc) => bloc.state.obscurePassword);

                return TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  validator: Validator.password,
                  onFieldSubmitted: _passwordFocusNode.onSubmitted,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    border: AppThemes.outlineInputBorder,
                    label: const Text('Password'),
                    suffixIcon: IconButton(
                      onPressed: isEmptyPassword
                          ? null
                          : () =>
                              bloc.add(const SignInObscurePasswordToggled()),
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                      ),
                    ),
                  ),
                  onChanged: (value) => bloc.add(SignInEdited(password: value)),
                );
              },
            ),
            const SizedBox(height: 30),

            // Proceed button
            SignInBlocListener(
              listenWhen: (previous, current) =>
                  // previous.statusMsg != current.statusMsg,
                  current.status == SignInStatus.success ||
                  current.status == SignInStatus.failure,
              listener: (context, state) {
                final snackBar = SnackBar(
                  backgroundColor: context.theme.snackBarTheme.backgroundColor
                      ?.withOpacity(.25),
                  behavior: SnackBarBehavior.floating,
                  content: Text(state.statusMsg),
                );
                context.scaffoldMessenger.showSnackBar(snackBar);
              },
              child: ElevatedButton.icon(
                icon: const Icon(Icons.forward_rounded),
                label: const Text('Proceed'),
                onPressed: () {
                  final valid =
                      _signInFormKey.currentState?.validate() ?? false;
                  if (valid) bloc.add(const SignInProceeded());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
