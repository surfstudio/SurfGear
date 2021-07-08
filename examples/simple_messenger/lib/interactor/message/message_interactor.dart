import 'package:simple_messenger/data/message.dart';
import 'package:simple_messenger/interactor/message/repository/message_repository.dart';

class MessageInteractor {
  final MessageRepository _repo;

  const MessageInteractor({required MessageRepository repo}) : _repo = repo;

  Stream<List<Message>> getMessages() => _repo.getMessages();

  Future<void> sendMessage(Message message) => _repo.sendMessage(message);
}
