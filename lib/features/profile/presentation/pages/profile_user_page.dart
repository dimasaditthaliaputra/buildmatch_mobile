import 'package:buildmatch_mobile/core/theme/app_colors.dart';
import 'package:buildmatch_mobile/core/theme/app_text_styles.dart';
import 'package:buildmatch_mobile/core/utils/screen_size.dart';
import 'package:buildmatch_mobile/core/utils/validators.dart';
import 'package:buildmatch_mobile/core/utils/snackbar_utils.dart';
import 'package:buildmatch_mobile/core/widgets/global_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../config/injection_container.dart';
import '../../domain/entities/profile_entity.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/avatar_picker_widget.dart';
import '../widgets/file_upload_widget.dart';
import '../widgets/profile_form_field_widget.dart';

class SetupProfilePage extends StatelessWidget {
  final String role;

  const SetupProfilePage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => sl<ProfileBloc>(),
      child: SetupProfileView(role: role),
    );
  }
}

class SetupProfileView extends StatefulWidget {
  final String role;

  const SetupProfileView({super.key, required this.role});

  @override
  State<SetupProfileView> createState() => _SetupProfileViewState();
}

class _SetupProfileViewState extends State<SetupProfileView> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _npwpNumberController = TextEditingController();
  final _nibNumberController = TextEditingController();

  // Selected Uploaded Files / Avatar
  String? _selectedAvatarPath;
  String? _npwpFile;
  String? _nibFile;
  String? _certificationFile;

  @override
  void initState() {
    super.initState();

    // Set up listeners for real-time validation / active button updates
    _nameController.addListener(_onFieldChanged);
    _phoneController.addListener(_onFieldChanged);
    _addressController.addListener(_onFieldChanged);
    _npwpNumberController.addListener(_onFieldChanged);
    _nibNumberController.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _npwpNumberController.dispose();
    _nibNumberController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    // Re-evaluate form state to dynamically enable/disable submit button
    setState(() {});
  }

  bool get _isContractor => widget.role.toLowerCase() == 'contractor';

  bool get _isFormValid {
    if (_isContractor) {
      return _nameController.text.trim().isNotEmpty &&
          _npwpNumberController.text.trim().isNotEmpty &&
          _npwpFile != null &&
          _nibNumberController.text.trim().isNotEmpty &&
          _nibFile != null &&
          _selectedAvatarPath != null;
    } else {
      // Client/Architect: Name is required to enable, others optional or validated
      return _nameController.text.trim().isNotEmpty;
    }
  }

  void _submitProfile() {
    if (!_formKey.currentState!.validate()) return;

    final profile = ProfileEntity(
      role: widget.role.toLowerCase(),
      avatarUrl: _selectedAvatarPath,
      name: _nameController.text.trim(),
      phone: _isContractor ? null : _phoneController.text.trim(),
      address: _isContractor ? null : _addressController.text.trim(),
      npwpNumber: _isContractor ? _npwpNumberController.text.trim() : null,
      npwpFile: _isContractor ? _npwpFile : null,
      nibNumber: _isContractor ? _nibNumberController.text.trim() : null,
      nibFile: _isContractor ? _nibFile : null,
      certificationFile: _isContractor ? _certificationFile : null,
    );

    context.read<ProfileBloc>().add(SubmitProfileEvent(profile));
  }

  @override
  Widget build(BuildContext context) {
    final double paddingHorizontal = context.widthPct(0.06).clamp(16.0, 24.0);
    final double titleFontSize = (context.screenWidth * 0.08).clamp(24.0, 30.0);
    final double subtitleFontSize = (context.screenWidth * 0.038).clamp(
      13.0,
      16.0,
    );
    final double buttonHeight = (context.screenHeight * 0.07).clamp(48.0, 56.0);
    final double buttonFontSize = (context.screenWidth * 0.04).clamp(
      14.0,
      17.0,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: GlobalAppBar(
        title: 'BuildMatch',
        titleFontWeight: FontWeight.w700,
        backgroundColor: Colors.transparent,
        titleSpacing: paddingHorizontal,
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSubmitSuccess) {
            SnackbarUtils.showSuccess('Profil Anda berhasil dikonfigurasi!');

            final roleLower = widget.role.toLowerCase();
            if (roleLower == 'contractor') {
              context.go('/contractor-dashboard');
            } else if (roleLower == 'architect') {
              context.go('/architect-dashboard');
            } else {
              context.go('/dashboard-client');
            }
          } else if (state is ProfileSubmitFailure) {
            SnackbarUtils.showError(state.errorMessage);
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final bool isSubmitting = state is ProfileSubmitting;

            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: paddingHorizontal,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              'Lengkapi Profil',
                              style: AppTextStyles.heading1.copyWith(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _isContractor
                                  ? 'Isi formulir data perusahaan kontraktor Anda secara lengkap dan valid.'
                                  : 'Lengkapi data diri Anda untuk memulai perjalanan proyek terbaik di BuildMatch.',
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontSize: subtitleFontSize,
                                color: AppColors.textSecondaryDark,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Avatar Picker Widget
                            AvatarPickerWidget(
                              selectedImagePath: _selectedAvatarPath,
                              onImageSelected: (imagePath) {
                                setState(() {
                                  _selectedAvatarPath = imagePath;
                                });
                              },
                            ),
                            const SizedBox(height: 32),

                            // Form Fields based on chosen role
                            if (!_isContractor) ...[
                              // CLIENT / ARCHITECT FORM
                              ProfileFormFieldWidget(
                                controller: _nameController,
                                label: 'Nama Lengkap',
                                hintText: 'Masukkan nama lengkap Anda',
                                prefixIcon: const Icon(
                                  LucideIcons.user,
                                  size: 20,
                                ),
                                validator: (val) =>
                                    Validators.required(val, 'Nama lengkap'),
                              ),
                              const SizedBox(height: 20),
                              ProfileFormFieldWidget(
                                controller: _phoneController,
                                label: 'Nomor Telepon',
                                hintText: 'Contoh: 081234567890',
                                keyboardType: TextInputType.phone,
                                prefixIcon: const Icon(
                                  LucideIcons.phone,
                                  size: 20,
                                ),
                                validator: (val) {
                                  if (val != null && val.isNotEmpty) {
                                    return Validators.phone(val);
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              ProfileFormFieldWidget(
                                controller: _addressController,
                                label: 'Alamat',
                                hintText: 'Masukkan alamat lengkap Anda',
                                maxLines: 3,
                                prefixIcon: const Icon(
                                  LucideIcons.mapPin,
                                  size: 20,
                                ),
                              ),
                            ] else ...[
                              // CONTRACTOR FORM
                              ProfileFormFieldWidget(
                                controller: _nameController,
                                label: 'Nama Perusahaan',
                                hintText: 'Masukkan nama perusahaan kontraktor',
                                prefixIcon: const Icon(
                                  LucideIcons.building,
                                  size: 20,
                                ),
                                validator: (val) =>
                                    Validators.required(val, 'Nama perusahaan'),
                              ),
                              const SizedBox(height: 20),
                              ProfileFormFieldWidget(
                                controller: _npwpNumberController,
                                label: 'Nomor NPWP Perusahaa',
                                hintText: 'Contoh: 12.345.678.9-012.345',
                                keyboardType: TextInputType.number,
                                prefixIcon: const Icon(
                                  LucideIcons.creditCard,
                                  size: 20,
                                ),
                                validator: (val) =>
                                    Validators.required(val, 'Nomor NPWP'),
                              ),
                              const SizedBox(height: 20),

                              // Berkas NPWP Uploader
                              FileUploadWidget(
                                label: 'Berkas NPWP',
                                fileName: _npwpFile,
                                isRequired: true,
                                isSquare: true,
                                onFileChanged: (fileName) {
                                  setState(() {
                                    _npwpFile = fileName;
                                  });
                                },
                              ),

                              ProfileFormFieldWidget(
                                controller: _nibNumberController,
                                label: 'Nomor NIB',
                                hintText: 'Masukkan 13 digit nomor NIB Anda',
                                keyboardType: TextInputType.number,
                                prefixIcon: const Icon(
                                  LucideIcons.fileSpreadsheet,
                                  size: 20,
                                ),
                                validator: (val) =>
                                    Validators.required(val, 'Nomor NIB'),
                              ),
                              const SizedBox(height: 20),

                              // Berkas NIB Uploader
                              FileUploadWidget(
                                label: 'Berkas NIB',
                                fileName: _nibFile,
                                isRequired: true,
                                isSquare: true,
                                onFileChanged: (fileName) {
                                  setState(() {
                                    _nibFile = fileName;
                                  });
                                },
                              ),

                              // Sertifikasi Uploader (Optional)
                              FileUploadWidget(
                                label: 'Upload Sertifikat',
                                fileName: _certificationFile,
                                isRequired: false,
                                isSquare: false,
                                onFileChanged: (fileName) {
                                  setState(() {
                                    _certificationFile = fileName;
                                  });
                                },
                              ),
                            ],
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Submit Button
                  Padding(
                    padding: EdgeInsets.all(paddingHorizontal),
                    child: ElevatedButton(
                      onPressed: (!_isFormValid || isSubmitting)
                          ? null
                          : _submitProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isContractor
                            ? AppColors.contractorPrimary
                            : AppColors.primary,
                        disabledBackgroundColor: AppColors.primaryGrey
                            .withOpacity(0.3),
                        foregroundColor: Colors.white,
                        disabledForegroundColor: Colors.white70,
                        elevation: _isFormValid ? 4 : 0,
                        shadowColor:
                            (_isContractor
                                    ? AppColors.contractorPrimary
                                    : AppColors.primary)
                                .withOpacity(0.4),
                        minimumSize: Size.fromHeight(buttonHeight),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: isSubmitting
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Text(
                              'Simpan Profil',
                              style: AppTextStyles.button.copyWith(
                                fontSize: buttonFontSize,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
