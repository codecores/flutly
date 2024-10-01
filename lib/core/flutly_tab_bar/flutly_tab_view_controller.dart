class FlutlyTabViewController {
  String tag;
  int length;
  int? initalIndex;
  Duration? animationDuration;

  FlutlyTabViewController({
    required this.tag,
    required this.length,
    this.initalIndex,
    this.animationDuration,
  }) {
    initalIndex ??= 0;
  }
}
