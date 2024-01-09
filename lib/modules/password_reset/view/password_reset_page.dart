import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/password_reset/password_reset.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

typedef PasswordResetBlocSelector<T>
    = BlocSelector<PasswordResetBloc, PasswordResetState, T>;

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({required this.email, super.key});
  final String? email;

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _passwordResetFormKey = GlobalKey<FormState>();
  // TextEditingControllers
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  // FocusNodes
  final _emailFocusNode = FocusNode();
  final _currentPasswordFocusNode = FocusNode();
  final _newPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.email != null) _emailController.text = widget.email!;
  }

  @override
  void dispose() {
    // TextEditingControllers
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    // FocusNodes
    _emailFocusNode.dispose();
    _currentPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PasswordResetBloc>();

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          context.sliverAppBar('Password Reset'),
        ],
        body: PasswordResetBlocSelector<bool>(
          selector: (state) => state.status.isLoading,
          builder: (context, isLoading) {
            return TranslucentLoader(
              enabled: isLoading,
              child: Form(
                key: _passwordResetFormKey,
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
                      onChanged: (value) =>
                          bloc.add(PasswordResetEdited(email: value)),
                    ),
                    const SizedBox(height: AppThemes.height * 4),
                    // Current Password
                    PasswordResetBlocSelector<bool>(
                      selector: (state) => state.obscureCurrentPassword,
                      builder: (context, obscureCurrentPassword) {
                        return TextFormField(
                          controller: _currentPasswordController,
                          focusNode: _currentPasswordFocusNode,
                          validator: Validator.password,
                          onFieldSubmitted:
                              _currentPasswordFocusNode.onSubmitted,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureCurrentPassword,
                          decoration: InputDecoration(
                            border: AppThemes.outlineInputBorder,
                            label: const Text('Current Password'),
                            suffixIcon: IconButton(
                              onPressed: () => bloc.add(
                                const PasswordResetObscureCurrentPasswordToggled(),
                              ),
                              icon: Icon(
                                obscureCurrentPassword
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                              ),
                            ),
                          ),
                          onChanged: (value) => bloc
                              .add(PasswordResetEdited(currentPassword: value)),
                        );
                      },
                    ),
                    const SizedBox(height: AppThemes.height * 4),
                    // New Password
                    PasswordResetBlocSelector<bool>(
                      selector: (state) => state.obscureNewPassword,
                      builder: (context, obscureNewPassword) {
                        return TextFormField(
                          controller: _newPasswordController,
                          focusNode: _newPasswordFocusNode,
                          validator: Validator.password,
                          onFieldSubmitted:
                              _currentPasswordFocusNode.onSubmitted,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureNewPassword,
                          decoration: InputDecoration(
                            border: AppThemes.outlineInputBorder,
                            label: const Text('New Password'),
                            suffixIcon: IconButton(
                              onPressed: () => bloc.add(
                                const PasswordResetObscureNewPasswordToggled(),
                              ),
                              icon: Icon(
                                obscureNewPassword
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                              ),
                            ),
                          ),
                          onChanged: (value) =>
                              bloc.add(PasswordResetEdited(newPassword: value)),
                        );
                      },
                    ),
                    const SizedBox(height: AppThemes.height * 4),
                    // Proceed button
                    BlocListener<PasswordResetBloc, PasswordResetState>(
                      listenWhen: (previous, current) =>
                          previous.statusMsg != current.statusMsg,
                      listener: (context, state) =>
                          context.showAppSnackBar(state.statusMsg),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.forward_rounded),
                        label: const Text('Proceed'),
                        onPressed: () {
                          final valid =
                              _passwordResetFormKey.currentState?.validate() ??
                                  false;
                          if (valid) {
                            bloc.add(const PasswordResetProceeded());
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
