import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'dart:io';

void main(List<String> arguments) {
  final channel = IOWebSocketChannel.connect(
      'wss://ws.binaryws.com/websockets/v3?app_id=1089');

  channel.stream.listen((message) {
    final decodedMessage = jsonDecode(message);
    final name = decodedMessage['tick']['symbol'];
    final price = decodedMessage['tick']['quote'];
    final epochTime = decodedMessage['tick']['epoch'];

    final time = DateTime.fromMillisecondsSinceEpoch(epochTime * 1000);

    print('Name: $name, Price: $price, Date: $time');
  });
  print('Please Enter Symbol Name : ');
  final userInput = stdin.readLineSync();
  channel.sink.add('{"ticks":"$userInput"}');
}
