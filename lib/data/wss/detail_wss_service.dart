import 'dart:convert';

import 'package:riverpod_app/data/models/detail_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../static/url_const.dart';

class DetailWssService {
  WebSocketChannel? _channel;
  void connect() {
    _channel = WebSocketChannel.connect(
      Uri.parse(UrlConst.detailUrl),
    );
  }

  void sendMessage(String message) {
    _channel?.sink.add(message);
  }

  Stream<DetailsModel>? getUpdatedPrice() {
    return _channel?.stream.map((e) {
      return DetailsModel.fromJson(jsonDecode(e));
    });
  }

  void disconnect() {
    _channel?.sink.close();
  }
}
