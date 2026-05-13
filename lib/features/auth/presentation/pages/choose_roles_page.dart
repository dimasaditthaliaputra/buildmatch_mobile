import 'package:buildmatch_mobile/core/theme/app_colors.dart';
import 'package:buildmatch_mobile/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseRolesPage extends StatefulWidget {
  const ChooseRolesPage({super.key});

  @override
  State<ChooseRolesPage> createState() => _ChooseRolesPageState();
}

class _ChooseRolesPageState extends State<ChooseRolesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: Column(children: [
            
                    ],
                  )),

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Color(0XFF727785),
                    ),
                    children: [
                      const TextSpan(
                        text: 'Dengan melanjutkan, Anda menyetujui ',
                      ),
                      TextSpan(
                        text: 'Syarat',
                        style: GoogleFonts.inter(
                          color: AppColors.warning,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(text: ' & \n'),
                      TextSpan(
                        text: 'Ketentuan',
                        style: GoogleFonts.inter(
                          color: AppColors.warning,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(text: ' kami.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
