import 'package:buildmatch_mobile/core/theme/app_colors.dart';
import 'package:buildmatch_mobile/core/theme/app_text_styles.dart';
import 'package:buildmatch_mobile/core/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/global_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _initialized = false;
  bool _isImageReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _initSplash();
    }
  }

  Future<void> _initSplash() async {
    await precacheImage(
      const AssetImage('assets/icons/buildmatch.png'),
      context,
    );

    if (mounted) {
      setState(() {
        _isImageReady = true;
      });
    }

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isImageReady) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      );
    }

    return Scaffold(
      body: GlobalBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const Logo(),
              const SizedBox(height: 6),
              Text('BuildMatch', style: AppTextStyles.heading1Primary),
            ],
          ),
        ),
      ),
    );
  }
}
