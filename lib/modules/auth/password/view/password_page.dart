import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/auth/auth.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final _passwordFormKey = GlobalKey<FormState>();
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
    // Restore form state.
    // _emailController.text = context.read<PasswordBloc>().state.email;
    // _passwordController.text = context.read<PasswordBloc>().state.password;
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
    final bloc = context.read<PasswordBloc>();
    final isLoading = context.select(
      (PasswordBloc bloc) => bloc.state.status == PasswordStatus.loading,
    );

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          context.sliverAppBar('Authentication 🔐'),
        ],
        body: TranslucentLoader(
          enabled: isLoading,
          child: Form(
            key: _passwordFormKey,
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
                  onChanged: (value) => bloc.add(PasswordEdited(email: value)),
                ),
                const SizedBox(height: AppThemes.height * 4),
                // Password
                Builder(
                  builder: (context) {
                    final isEmptyPassword = context.select(
                      (PasswordBloc bloc) => bloc.state.password.isEmpty,
                    );
                    final obscurePassword = context.select(
                      (PasswordBloc bloc) => bloc.state.obscurePassword,
                    );

                    return TextFormField(
                      controller: _currentPasswordController,
                      focusNode: _currentPasswordFocusNode,
                      validator: Validator.password,
                      onFieldSubmitted: _currentPasswordFocusNode.onSubmitted,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        border: AppThemes.outlineInputBorder,
                        label: const Text('Current Password'),
                        suffixIcon: IconButton(
                          onPressed: isEmptyPassword
                              ? null
                              : () => bloc
                                  .add(const PasswordObscurePasswordToggled()),
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                          ),
                        ),
                      ),
                      onChanged: (value) =>
                          bloc.add(PasswordEdited(password: value)),
                    );
                  },
                ),
                const SizedBox(height: AppThemes.height * 4),

                Builder(
                  builder: (context) {
                    final isEmptyPassword = context.select(
                      (PasswordBloc bloc) => bloc.state.password.isEmpty,
                    );
                    final obscurePassword = context.select(
                      (PasswordBloc bloc) => bloc.state.obscurePassword,
                    );

                    return TextFormField(
                      controller: _newPasswordController,
                      focusNode: _newPasswordFocusNode,
                      validator: Validator.password,
                      onFieldSubmitted: _currentPasswordFocusNode.onSubmitted,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        border: AppThemes.outlineInputBorder,
                        label: const Text('New Password'),
                        suffixIcon: IconButton(
                          onPressed: isEmptyPassword
                              ? null
                              : () => bloc
                                  .add(const PasswordObscurePasswordToggled()),
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                          ),
                        ),
                      ),
                      onChanged: (value) =>
                          bloc.add(PasswordEdited(password: value)),
                    );
                  },
                ),
                const SizedBox(height: AppThemes.height * 4),
                // Proceed button
                ElevatedButton.icon(
                  icon: const Icon(Icons.forward_rounded),
                  label: const Text('Proceed'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
