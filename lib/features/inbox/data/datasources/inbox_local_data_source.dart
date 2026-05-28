import '../models/consultation_room_model.dart';
import '../models/chat_message_model.dart';

abstract class InboxLocalDataSource {
  Future<List<ConsultationRoomModel>> getConsultationRooms(String currentUserId);
  Future<List<ChatMessageModel>> getChatMessages(String roomId);
  Future<ChatMessageModel> sendMessage({
    required String roomId,
    required String senderId,
    required String message,
    String? replyToId,
    String? replyToMessage,
    String? replyToSenderId,
    String? attachmentUrl,
    String? attachmentType,
    String? attachmentName,
  });
  Future<ChatMessageModel> editMessage({
    required String roomId,
    required String messageId,
    required String newMessage,
  });
  Future<void> markMessagesAsRead(String roomId, String currentUserId);
}

const String _dummyCurrentUser = 'user-client-001';
const String _dummyProfessional1 = 'user-arch-001';
const String _dummyProfessional2 = 'user-arch-002';

class InboxLocalDataSourceImpl implements InboxLocalDataSource {
  final List<ConsultationRoomModel> _rooms = [
    ConsultationRoomModel(
      id: 'room-001',
      projectId: 'project-001',
      clientId: _dummyCurrentUser,
      professionalId: _dummyProfessional1,
      status: 'active',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now().subtract(const Duration(minutes: 28)),
      projectTitle: 'Modern Zen Villa',
      otherUserName: 'Ars. Adrian Wijaya',
      otherUserAvatarUrl: null,
      lastMessage: 'Denah revisi sudah saya kirimkan...',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 28)),
      unreadCount: 3,
    ),
    ConsultationRoomModel(
      id: 'room-002',
      projectId: 'project-002',
      clientId: _dummyCurrentUser,
      professionalId: _dummyProfessional2,
      status: 'active',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(minutes: 28)),
      projectTitle: 'Tropical Residence',
      otherUserName: 'Ars. Sarah Wijaya',
      otherUserAvatarUrl: null,
      lastMessage: 'Jadwal survey sudah dikonfirmasi...',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 28)),
      unreadCount: 0,
    ),
  ];

  final Map<String, List<ChatMessageModel>> _messages = {
    'room-001': [
      ChatMessageModel(
        id: 'msg-001',
        roomId: 'room-001',
        senderId: _dummyProfessional1,
        message: '👋 Selamat datang! Ada yang bisa saya bantu terkait proyek Anda?',
        isRead: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      ChatMessageModel(
        id: 'msg-002',
        roomId: 'room-001',
        senderId: _dummyCurrentUser,
        message: 'Halo Ars. Adrian, saya ingin diskusi mengenai desain ruang tamu.',
        isRead: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 4)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 4)),
      ),
      ChatMessageModel(
        id: 'msg-003',
        roomId: 'room-001',
        senderId: _dummyCurrentUser,
        message: 'Apakah bisa menggunakan konsep open space?',
        isRead: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 3, minutes: 30)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 3, minutes: 30)),
        replyToId: 'msg-001',
        replyToMessage: '👋 Selamat datang! Ada yang bisa saya bantu terkait proyek Anda?',
        replyToSenderId: _dummyProfessional1,
      ),
      ChatMessageModel(
        id: 'msg-004',
        roomId: 'room-001',
        senderId: _dummyProfessional1,
        message: 'Tentu bisa! Konsep open space sangat cocok untuk Modern Zen Villa.',
        isRead: true,
        isEdited: true,
        editedAt: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
      ),
      ChatMessageModel(
        id: 'msg-005',
        roomId: 'room-001',
        senderId: _dummyProfessional1,
        message: 'Denah revisi sudah saya kirimkan, silakan dicek dan berikan feedback ya Pak.',
        isRead: false,
        createdAt: DateTime.now().subtract(const Duration(minutes: 28)),
        updatedAt: DateTime.now().subtract(const Duration(minutes: 28)),
      ),
    ],
    'room-002': [
      ChatMessageModel(
        id: 'msg-101',
        roomId: 'room-002',
        senderId: _dummyProfessional2,
        message: 'Halo! Saya Ars. Sarah, arsitek yang akan menangani proyek Tropical Residence Anda.',
        isRead: true,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        updatedAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
      ChatMessageModel(
        id: 'msg-102',
        roomId: 'room-002',
        senderId: _dummyCurrentUser,
        message: 'Halo Ars. Sarah! Senang berkenalan. Kapan kita bisa mulai survey lokasi?',
        isRead: true,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      ChatMessageModel(
        id: 'msg-103',
        roomId: 'room-002',
        senderId: _dummyProfessional2,
        message: 'Jadwal survey sudah dikonfirmasi untuk hari Senin, 2 Juni 2026 pukul 09.00 WIB ya Pak.',
        isRead: true,
        createdAt: DateTime.now().subtract(const Duration(minutes: 28)),
        updatedAt: DateTime.now().subtract(const Duration(minutes: 28)),
      ),
    ],
  };

  @override
  Future<List<ConsultationRoomModel>> getConsultationRooms(
      String currentUserId) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _rooms
        .where((r) => r.clientId == currentUserId || r.professionalId == currentUserId)
        .toList();
  }

  @override
  Future<List<ChatMessageModel>> getChatMessages(String roomId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List<ChatMessageModel>.from(_messages[roomId] ?? []);
  }

  @override
  Future<ChatMessageModel> sendMessage({
    required String roomId,
    required String senderId,
    required String message,
    String? replyToId,
    String? replyToMessage,
    String? replyToSenderId,
    String? attachmentUrl,
    String? attachmentType,
    String? attachmentName,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final newMessage = ChatMessageModel(
      id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
      roomId: roomId,
      senderId: senderId,
      message: message,
      isRead: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      replyToId: replyToId,
      replyToMessage: replyToMessage,
      replyToSenderId: replyToSenderId,
      attachmentUrl: attachmentUrl,
      attachmentType: attachmentType,
      attachmentName: attachmentName,
    );
    _messages[roomId] ??= [];
    _messages[roomId]!.add(newMessage);
    return newMessage;
  }

  @override
  Future<ChatMessageModel> editMessage({
    required String roomId,
    required String messageId,
    required String newMessage,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final messages = _messages[roomId];
    if (messages == null) throw Exception('Room not found');
    final index = messages.indexWhere((m) => m.id == messageId);
    if (index == -1) throw Exception('Message not found');

    final old = messages[index];
    final diff = DateTime.now().difference(old.createdAt);
    if (diff.inMinutes > 30) throw Exception('Batas waktu edit (30 menit) telah habis');

    final edited = ChatMessageModel(
      id: old.id,
      roomId: old.roomId,
      senderId: old.senderId,
      message: newMessage,
      metadata: old.metadata,
      isRead: old.isRead,
      createdAt: old.createdAt,
      updatedAt: DateTime.now(),
      replyToId: old.replyToId,
      replyToMessage: old.replyToMessage,
      replyToSenderId: old.replyToSenderId,
      isEdited: true,
      editedAt: DateTime.now(),
      attachmentUrl: old.attachmentUrl,
      attachmentType: old.attachmentType,
      attachmentName: old.attachmentName,
    );
    _messages[roomId]![index] = edited;
    return edited;
  }

  @override
  Future<void> markMessagesAsRead(String roomId, String currentUserId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final messages = _messages[roomId];
    if (messages == null) return;
    for (int i = 0; i < messages.length; i++) {
      if (messages[i].senderId != currentUserId && !messages[i].isRead) {
        final m = messages[i];
        _messages[roomId]![i] = ChatMessageModel(
          id: m.id, roomId: m.roomId, senderId: m.senderId, message: m.message,
          metadata: m.metadata, isRead: true,
          createdAt: m.createdAt, updatedAt: DateTime.now(),
          replyToId: m.replyToId, replyToMessage: m.replyToMessage,
          replyToSenderId: m.replyToSenderId, isEdited: m.isEdited,
          editedAt: m.editedAt, attachmentUrl: m.attachmentUrl,
          attachmentType: m.attachmentType, attachmentName: m.attachmentName,
        );
      }
    }
  }
}
