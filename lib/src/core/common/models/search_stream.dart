import 'dart:async';

class SearchStream {
  static final _instance = SearchStream._internal();
  late Stream<String> _stream;
  final StreamController<String> _controller = StreamController<String>();

  init() {
    _stream = _controller.stream.asBroadcastStream();
    _controller.add("");
  }

  addValueToStream(String value) {
    _controller.add(value);
  }

  Stream<String> getStream() {
    return _stream;
  }

  disposeStream() {
    _stream.drain();
    _controller.close();

  }

  factory SearchStream() => _instance;

  SearchStream._internal();
}
