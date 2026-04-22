import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/injection_container.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../../../../core/widgets/global_background.dart';
import '../widgets/login_options_view.dart';
import '../widgets/email_login_form_view.dart';
import '../widgets/register_form_view.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _showEmailForm = false;
  bool _showRegisterForm = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.go('/home');
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: GlobalBackground(
            showSecondaryDecoration: _showEmailForm,
            child: SafeArea(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 0.05),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: _showRegisterForm
                    ? RegisterFormView(
                        key: const ValueKey('register_form'),
                        onBackPressed: () => setState(() {
                          _showRegisterForm = false;
                        }),
                        onLoginTapped: () => setState(() {
                          _showRegisterForm = false;
                          _showEmailForm = true;
                        }),
                      )
                    : _showEmailForm
                        ? EmailLoginFormView(
                            key: const ValueKey('email_form'),
                            onBackPressed: () =>
                                setState(() => _showEmailForm = false),
                            onRegisterTapped: () => setState(() {
                              _showEmailForm = false;
                              _showRegisterForm = true;
                            }),
                          )
                        : LoginOptionsView(
                            key: const ValueKey('login_options'),
                            onEmailLoginTapped: () =>
                                setState(() => _showEmailForm = true),
                            onRegisterTapped: () =>
                                setState(() => _showRegisterForm = true),
                          ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
