import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'error_state_view.dart';
import '../utils/snackbar_utils.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorStateView(
        onRetry: () {
          // Ketika dicoba lagi, arahkan kembali ke splash untuk memulai ulang alur
          SnackbarUtils.suppressSnackbars = true;
          context.go('/splash');
        },
      ),
    );
  }
}
