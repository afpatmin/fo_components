class Time {
  int hour;
  int minute;

  Time({required this.hour, required this.minute});

  //String _format(int x) {

  //  }

  @override
  String toString() {
    if ("$hour".length < 2 && "$minute".length < 2) {
      return "0$hour:0$minute";
    }
    if ("$hour".length < 2 && "$minute".length == 2) {
      return "0$hour:$minute";
    }
    if ("$hour".length == 2 && "$minute".length < 2) {
      return "$hour:0$minute";
    } else {
      return "$hour:$minute";
    }
  }
}
