class FlutlyTabViewController {
    int length;
    int? initalIndex;
    Duration? animationDuration;

    FlutlyTabViewController({required this.length, this.initalIndex, this.animationDuration}){
      if(this.initalIndex == null) initalIndex = 0;
    }
}