import 'package:netzpolitik_mobile/models/reply.dart';

class ReplyDeserializer {

  static List<Reply> deserialize(List json) {

    var replies =  json?.map(
            (e) => e == null ? null : Reply.fromJson(e as Map<String, dynamic>)
      )?.toList();

    for (var reply in replies) {
      for (var possibleChild in replies) {
        if (possibleChild.parent == reply.id) {
          reply.replies.add(possibleChild);
        }
      }
    }

    return replies;
  }

}