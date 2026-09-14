import 'package:flutter/material.dart';
import 'package:prop_ai/Features/auth/views/password_reset_success_view.dart';
import 'package:prop_ai/Features/auth/views/widgets/auth_button.dart';
import 'package:prop_ai/Features/auth/views/widgets/auth_header.dart';
import 'package:prop_ai/Features/auth/views/widgets/auth_text_field.dart';
import 'package:prop_ai/core/theme/theme.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain an uppercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain a number';
    }

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  void _resetPassword() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const PasswordResetSuccessView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.xl,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AuthHeader(
                    title: 'Create new password',
                    subtitle: 'Your new password must be different from previously used passwords.',
                  ),

                  SizedBox(height: AppSpacing.xl),

                  AuthTextField(
                    controller: _passwordController,
                    label: 'New password',
                    hintText: 'Enter your new password',
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    validator: _validatePassword,
                  ),

                  SizedBox(height: AppSpacing.md),

                  AuthTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirm password',
                    hintText: 'Re-enter your new password',
                    textInputAction: TextInputAction.done,
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    validator: _validateConfirmPassword,
                  ),

                  SizedBox(height: AppSpacing.md),

                  Text(
                    'Password must contain:',
                    style: AppTextStyle.medium14.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),

                  SizedBox(height: AppSpacing.sm),

                  _PasswordRequirement(
                    text: 'At least 8 characters',
                    controller: _passwordController,
                    validator: (password) => password.length >= 8,
                  ),

                  _PasswordRequirement(
                    text: 'At least one uppercase letter',
                    controller: _passwordController,
                    validator: (password) =>
                        RegExp(r'[A-Z]').hasMatch(password),
                  ),

                  _PasswordRequirement(
                    text: 'At least one number',
                    controller: _passwordController,
                    validator: (password) =>
                        RegExp(r'[0-9]').hasMatch(password),
                  ),

                  SizedBox(height: AppSpacing.xl),

                  AuthButton(text: 'Reset password', onPressed: _resetPassword),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordRequirement extends StatefulWidget {
  const _PasswordRequirement({
    required this.text,
    required this.controller,
    required this.validator,
  });

  final String text;
  final TextEditingController controller;
  final bool Function(String password) validator;

  @override
  State<_PasswordRequirement> createState() => _PasswordRequirementState();
}

class _PasswordRequirementState extends State<_PasswordRequirement> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_update);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_update);
    super.dispose();
  }

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isValid = widget.validator(widget.controller.text);

    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle_outline : Icons.circle_outlined,
            size: 18,
            color: isValid ? AppColors.success500 : AppColors.textMuted,
          ),
          SizedBox(width: AppSpacing.sm),
          Text(
            widget.text,
            style: AppTextStyle.regular14.copyWith(
              color: isValid ? AppColors.success500 : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
