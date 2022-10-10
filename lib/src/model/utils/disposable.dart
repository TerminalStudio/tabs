mixin Disposable {
  bool _disposed = false;

  bool get disposed => _disposed;

  void dispose() {
    if (_disposed) {
      return;
    }

    _disposed = true;
  }
}
