class EnvironmentVariable {
  EnvironmentVariable({
    required this.path,
    this.comment,
  });

  final String? comment;
  final String path;

  @override
  String toString() {
    final buffer = StringBuffer();
    if (comment != null && comment!.isNotEmpty) {
      buffer.writeln('# $comment');
    }
    buffer.writeln('export PATH="$path:\$PATH"');
    return buffer.toString();
  }
}
