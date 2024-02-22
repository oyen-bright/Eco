import 'dart:async';

class StreamHandler<T> {
  final _controller = StreamController<T>();

  Sink<T> get sink => _controller.sink;

  Stream<T> get stream => _controller.stream;

  void push(T data) {
    sink.add(data);
  }

  void close() {
    _controller.close();
  }
}
