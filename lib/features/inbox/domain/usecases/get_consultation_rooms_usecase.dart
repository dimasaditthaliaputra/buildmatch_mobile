import '../entities/consultation_room_entity.dart';
import '../repositories/inbox_repository.dart';

class GetConsultationRoomsUseCase {
  final InboxRepository repository;
  GetConsultationRoomsUseCase(this.repository);

  Future<List<ConsultationRoomEntity>> call(String currentUserId) {
    return repository.getConsultationRooms(currentUserId);
  }
}
