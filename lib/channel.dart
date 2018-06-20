import 'package:phoenix_wings/phoenix_wings.dart';

class Channel {
  final String url;
  final PhoenixSocket socket;
  final PhoenixChannel chatChannel;

  var presences = {};

  Channel._(this.url, this.socket, this.chatChannel) {
    chatChannel.join();
  }

  factory Channel({String url, String user}) {
    url ??= "ws://192.168.7.206:4000/socket/websocket";
    user ??= "Unknown";
    var _opts = new PhoenixSocketOptions();
    _opts.params["user"] = user;
    _opts.params["vsn"] = "2.0.0";
    var socket = new PhoenixSocket(url, socketOptions: _opts);

    socket.connect();

    socket.onError((error) => print("socket.onError: $error"));
    socket.onClose((msg) => print("socket.onClose: $msg"));

    var chatChannel = socket.channel("room:lobby", {});

    return Channel._(url, socket, chatChannel);
  }
}
