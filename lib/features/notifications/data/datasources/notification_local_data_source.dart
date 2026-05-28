import '../models/notification_model.dart';

abstract class NotificationLocalDataSource {
  Future<List<NotificationModel>> getNotifications();
}

class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  @override
  Future<List<NotificationModel>> getNotifications() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Dummy data based on the slicing design
    return [
      NotificationModel(
        id: '1',
        userId: 'current_user',
        title: 'Penawaran Baru Diterima',
        body: 'PT. Maju Konstruksi mengirimkan penawaran harga untuk proyek infrastruktur baru.',
        category: 'project_approval',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
      ),
      NotificationModel(
        id: '2',
        userId: 'current_user',
        title: 'Pembayaran Milestone Cair',
        body: 'Dana sebesar Rp 350jt telah berhasil ditransfer ke rekening operasional Anda.',
        category: 'escrow_payout',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        isRead: true,
      ),
      NotificationModel(
        id: '3',
        userId: 'current_user',
        title: 'Dokumen Perlu Revisi',
        body: 'Admin meminta revisi pada dokumen Pajak Tahunan untuk kelengkapan administrasi.',
        category: 'system_alert',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
      NotificationModel(
        id: '4',
        userId: 'current_user',
        title: 'Deadline Proyek Mendekat',
        body: 'Proyek Penthouse Suite B akan berakhir dalam 48 jam ke depan.',
        category: 'milestone_update',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
      ),
      NotificationModel(
        id: '5',
        userId: 'current_user',
        title: 'Pesan dari Klien',
        body: 'Marcus Chen telah membalas pesan Anda terkait perubahan material atap.',
        category: 'chat',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        isRead: true,
        avatarUrl: 'https://i.pravatar.cc/150?img=11', // Dummy avatar
      ),
    ];
  }
}
