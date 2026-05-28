import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/error_state_view.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/global_custom_tab_bar.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';
import '../widgets/notification_item_widget.dart';

class ListNotificationPage extends StatelessWidget {
  const ListNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NotificationBloc>()..add(GetNotificationsEvent()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const GlobalAppBar(
          title: 'Notification Center',
        ),
        body: const _ListNotificationBody(),
      ),
    );
  }
}

class _ListNotificationBody extends StatefulWidget {
  const _ListNotificationBody();

  @override
  State<_ListNotificationBody> createState() => _ListNotificationBodyState();
}

class _ListNotificationBodyState extends State<_ListNotificationBody> {
  int _selectedTabIndex = 0; // Default to 'Hari Ini'

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildTabs(),
        Expanded(
          child: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is NotificationLoading) {
                return const Center(child: CircularProgressIndicator(color: AppColors.primary));
              } else if (state is NotificationError) {
                return ErrorStateView(
                  message: state.message,
                  onRetry: () => context.read<NotificationBloc>().add(GetNotificationsEvent()),
                );
              } else if (state is NotificationLoaded) {
                final allNotifications = state.notifications;
                final now = DateTime.now();

                final notifications = allNotifications.where((notification) {
                  final diff = now.difference(notification.createdAt);
                  if (_selectedTabIndex == 0) {
                    // Hari Ini
                    return diff.inDays == 0;
                  } else if (_selectedTabIndex == 1) {
                    // Minggu Ini
                    return diff.inDays > 0 && diff.inDays <= 7;
                  } else {
                    // Terdahulu
                    return diff.inDays > 7;
                  }
                }).toList();
                
                if (notifications.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryUltraLightGrey,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.notifications_off_outlined,
                            size: 40,
                            color: AppColors.primaryGrey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Belum Ada Notifikasi',
                          style: AppTextStyles.heading3.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Notifikasi baru akan muncul di sini',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return NotificationItemWidget(
                      notification: notifications[index],
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GlobalCustomTabBar(
        tabs: const ['Hari Ini', 'Minggu Ini', 'Terdahulu'],
        selectedIndex: _selectedTabIndex,
        onTabChanged: (index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        selectedTextColor: AppColors.textPrimary,
      ),
    );
  }
}
