class ResultNotFoundException implements Exception {
  String message;
  ResultNotFoundException(this.message);

  @override
  String toString() {
    return "${this.runtimeType}: ${this.message}";
  }
}