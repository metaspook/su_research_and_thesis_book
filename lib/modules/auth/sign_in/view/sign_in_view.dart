import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/auth/auth.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

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
    final isLoading = context
        .select((SignInBloc bloc) => bloc.state.status == SignInStatus.loading);

    return TranslucentLoader(
      enabled: isLoading,
      child: Form(
        key: _signInFormKey,
        child: ListView(
          padding: AppThemes.viewPadding * 2,
          children: [
            const SizedBox(height: AppThemes.height * 2),
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
            const SizedBox(height: AppThemes.height * 4),
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
            const SizedBox(height: AppThemes.height * 1.5),
            // Remember me button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SignInBlocSelector<bool>(
                  selector: (state) => state.rememberMe,
                  builder: (context, rememberMe) {
                    return GestureDetector(
                      onTap: () => bloc.add(const SignInRememberMeToggled()),
                      child: Row(
                        children: [
                          Checkbox(
                            visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity,
                            ),
                            value: rememberMe,
                            onChanged: (_) =>
                                bloc.add(const SignInRememberMeToggled()),
                          ),
                          const Text('Remember me'),
                        ],
                      ),
                    );
                  },
                ),
                // Forget Password button
                SignInBlocSelector<String>(
                  selector: (state) => state.email,
                  builder: (context, email) {
                    return TextButton.icon(
                      icon: const Icon(Icons.help_center_rounded),
                      label: const Text('Forget Password'),
                      onPressed: email.isEmpty
                          ? null
                          : () =>
                              context.pushNamed(AppRouter.passwordReset.name!),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: AppThemes.height * 2),
            // Proceed button
            SignInBlocConsumer(
              listenWhen: (previous, current) => current.status.hasMessage,
              listener: (context, state) {
                final snackBar = SnackBar(
                  backgroundColor: context.theme.snackBarTheme.backgroundColor
                      ?.withOpacity(.25),
                  behavior: SnackBarBehavior.floating,
                  content: Text(state.statusMsg),
                );
                context.scaffoldMessenger.showSnackBar(snackBar);
              },
              builder: (context, state) {
                final enabled =
                    state.email.isNotEmpty || state.password.isNotEmpty;
                return ElevatedButton.icon(
                  icon: const Icon(Icons.forward_rounded),
                  label: const Text('Proceed'),
                  onPressed: enabled
                      ? () {
                          final valid =
                              _signInFormKey.currentState?.validate() ?? false;
                          if (valid) bloc.add(const SignInProceeded());
                        }
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
