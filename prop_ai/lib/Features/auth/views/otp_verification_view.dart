import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prop_ai/Features/auth/views/reset_password_view.dart';
import 'package:prop_ai/Features/auth/views/widgets/auth_button.dart';
import 'package:prop_ai/Features/auth/views/widgets/auth_header.dart';
import 'package:prop_ai/core/theme/theme.dart';

class OtpVerificationView extends StatefulWidget {
  const OtpVerificationView({super.key, required this.email});

  final String email;

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  static const int _otpLength = 6;
  static const int _initialSeconds = 60;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  Timer? _timer;
  int _remainingSeconds = _initialSeconds;

  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(_otpLength, (_) => TextEditingController());

    _focusNodes = List.generate(_otpLength, (_) => FocusNode());

    _startTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes.first.requestFocus();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();

    for (final controller in _controllers) {
      controller.dispose();
    }

    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();

    setState(() {
      _remainingSeconds = _initialSeconds;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 1) {
        timer.cancel();

        setState(() {
          _remainingSeconds = 0;
        });

        return;
      }

      setState(() {
        _remainingSeconds--;
      });
    });
  }

  String get _otp {
    return _controllers.map((controller) => controller.text).join();
  }

  bool get _isOtpComplete {
    return _otp.length == _otpLength;
  }

  void _onOtpChanged(String value, int index) {
    if (value.length > 1) {
      final digits = value.replaceAll(RegExp(r'\D'), '');

      for (int i = 0; i < digits.length; i++) {
        final targetIndex = index + i;

        if (targetIndex >= _otpLength) {
          break;
        }

        _controllers[targetIndex].text = digits[i];
      }

      final nextIndex = (index + digits.length).clamp(0, _otpLength - 1);

      _focusNodes[nextIndex].requestFocus();

      setState(() {});

      return;
    }

    if (value.isNotEmpty && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    setState(() {});
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event, int index) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _controllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();

      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  void _verifyOtp() {
    FocusScope.of(context).unfocus();

    if (!_isOtpComplete) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the complete 6-digit verification code'),
        ),
      );

      return;
    }

    setState(() {
      _isVerifying = true;
    });

    // Temporary local validation.
    // API verification will be added later.

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      setState(() {
        _isVerifying = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ResetPasswordView()),
      );
    });
  }

  void _resendOtp() {
    if (_remainingSeconds > 0) {
      return;
    }

    for (final controller in _controllers) {
      controller.clear();
    }

    _startTimer();

    _focusNodes.first.requestFocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('A new verification code has been sent')),
    );

    setState(() {});
  }

  String _formatTime() {
    final seconds = _remainingSeconds.toString().padLeft(2, '0');

    return '00:$seconds';
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
        child: Center(
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
                      title: 'Verify your email',
                      subtitle: 'We sent a 6-digit verification code to your email address.',
                    ),

                    SizedBox(height: AppSpacing.md),

                    Text(
                      widget.email,
                      style: AppTextStyle.semiBold14.copyWith(
                        color: AppColors.primary600,
                      ),
                    ),

                    SizedBox(height: AppSpacing.xl),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(_otpLength, (index) {
                        return SizedBox(
                          width: 48,
                          height: 58,
                          child: Focus(
                            onKeyEvent: (node, event) =>
                                _handleKeyEvent(node, event, index),
                            child: TextFormField(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: AppTextStyle.semiBold20.copyWith(
                                color: AppColors.textPrimary,
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                filled: true,
                                fillColor: AppColors.background,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.md,
                                  ),
                                  borderSide: BorderSide(
                                    color: AppColors.border,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.md,
                                  ),
                                  borderSide: BorderSide(
                                    color: AppColors.border,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.md,
                                  ),
                                  borderSide: BorderSide(
                                    color: AppColors.primary500,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                _onOtpChanged(value, index);
                              },
                            ),
                          ),
                        );
                      }),
                    ),

                    SizedBox(height: AppSpacing.xl),

                    Center(
                      child: Text(
                        _remainingSeconds > 0
                            ? 'Resend code in ${_formatTime()}'
                            : 'Didn’t receive the code?',
                        style: AppTextStyle.regular14.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),

                    SizedBox(height: AppSpacing.xs),

                    Center(
                      child: TextButton(
                        onPressed: _remainingSeconds == 0 ? _resendOtp : null,
                        child: Text(
                          'Resend code',
                          style: AppTextStyle.semiBold14.copyWith(
                            color: _remainingSeconds == 0
                                ? AppColors.primary600
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: AppSpacing.lg),

                    AuthButton(
                      text: _isVerifying ? 'Verifying...' : 'Verify code',
                      onPressed: _isVerifying ? null : _verifyOtp,
                    ),

                    SizedBox(height: AppSpacing.lg),

                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Change email address',
                          style: AppTextStyle.medium14.copyWith(
                            color: AppColors.primary600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
