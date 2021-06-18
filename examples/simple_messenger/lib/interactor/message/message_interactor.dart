import '../../data/message.dart';
import 'repository/message_repository.dart';

class MessageInteractor {
  const MessageInteractor({required MessageRepository repo}) : _repo = repo;

  final MessageRepository _repo;

  Stream<List<Message>> getMessages() => _repo.getMessages();

  Future<void> sendMessage(Message message) => _repo.sendMessage(message);
}
