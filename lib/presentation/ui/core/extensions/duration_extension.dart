extension DurationExtension on Duration {
  String get timeFormat {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    final hoursText = "$hours".padLeft(2, '0');
    final minutesText = "$minutes".padLeft(2, '0');
    final secondsText = "$seconds".padLeft(2, '0');

    if (hours > 0) {
      return "$hoursText:$minutesText:$secondsText";
    }

    return "$minutesText:$secondsText";
  }
}
