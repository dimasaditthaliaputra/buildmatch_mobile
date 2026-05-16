import 'dart:async';
import 'package:buildmatch_mobile/core/utils/snackbar_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/main_button.dart';
import '../widgets/otp/otp_input_field.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String otpCode = "";
  Timer? _timer;
  int _remainingSeconds = 480;
  bool _canResend = false;
  bool _hasError = false;
  static const String _endTimeKey = 'otp_end_time';

  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  Future<void> _initTimer() async {
    final prefs = await SharedPreferences.getInstance();
    final endTimeMillis = prefs.getInt(_endTimeKey);
    final now = DateTime.now().millisecondsSinceEpoch;

    if (endTimeMillis == null || endTimeMillis < now) {
      _startNewTimer(prefs);
    } else {
      setState(() {
        _remainingSeconds = ((endTimeMillis - now) / 1000).round();
        _canResend = false;
      });
      _startTimer();
    }
  }

  void _startNewTimer(SharedPreferences prefs) {
    final endTime = DateTime.now().add(const Duration(seconds: 480));
    prefs.setInt(_endTimeKey, endTime.millisecondsSinceEpoch);

    setState(() {
      _remainingSeconds = 480;
      _canResend = false;
    });

    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();

        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(_endTimeKey);
      }
    });
  }

  Future<void> _resendCode() async {
    if (!_canResend) return;

    // TODO: Panggil API resend OTP disini

    final prefs = await SharedPreferences.getInstance();
    _startNewTimer(prefs);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Verifikasi', style: AppTextStyles.heading3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 24.0,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 48,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'Masukan kode verifikasi\nanda',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.heading1,
                      ),
                      const SizedBox(height: 40),
                      OtpInputField(
                        length: 4,
                        hasError: _hasError,
                        onChanged: (code) {
                          setState(() {
                            otpCode = code;
                            _hasError = false;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      Text(
                        _formattedTime,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.heading3.copyWith(
                          color: _canResend
                              ? AppColors.textSecondary
                              : AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 32),
                      RichText(
                        text: TextSpan(
                          style: AppTextStyles.bodyMedium.copyWith(height: 1.5),
                          children: [
                            const TextSpan(
                              text:
                                  'Kami mengirimkan kode verifikasi ke email Anda di ',
                            ),
                            TextSpan(
                              text: 'john*****@gmail.com. ',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primaryMedium,
                                height: 1.5,
                              ),
                            ),
                            const TextSpan(
                              text:
                                  'Anda dapat memeriksa kotak masuk email Anda.',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      RichText(
                        text: TextSpan(
                          style: AppTextStyles.bodyMedium,
                          children: [
                            const TextSpan(
                              text: 'Saya belum menerima kodenya? ',
                            ),
                            TextSpan(
                              text: 'Kirim lagi.',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: _canResend
                                    ? AppColors.primaryMedium
                                    : AppColors.textSecondary,
                                decoration: TextDecoration.underline,
                                decorationColor: _canResend
                                    ? AppColors.primaryMedium
                                    : AppColors.textSecondary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _resendCode,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      MainButton(
                        text: 'Verifikasi',
                        backgroundColor: otpCode.length == 4
                            ? AppColors.primary
                            : AppColors.primaryLight,
                        onPressed: otpCode.length == 4
                            ? () {
                                // TODO: Ganti dengan pemanggilan API BLoC/UseCase
                                if (otpCode != '1234') {
                                  setState(() {
                                    _hasError = true;
                                  });

                                  SnackbarUtils.showError('Kode OTP salah!');
                                } else {
                                  setState(() {
                                    _hasError = false;
                                  });
                                }
                              }
                            : null,
                      ),
                      const Spacer(),
                      const FooterText(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FooterText extends StatelessWidget {
  const FooterText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppTextStyles.caption.copyWith(height: 1.5),
        children: [
          const TextSpan(text: 'Dengan mendaftar, Anda menyetujui '),
          TextSpan(
            text: 'Ketentuan',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          const TextSpan(text: ' & \n'),
          TextSpan(
            text: 'Kebijakan',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          const TextSpan(text: ' kami.'),
        ],
      ),
    );
  }
}
