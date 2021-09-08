class FairCompileError extends Error {
  final String message;
  FairCompileError(this.message);
  @override
  String toString() => 'Fair compile error: $message';
}