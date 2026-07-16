class PendingAction {
  String? testName;
  String? date;
  String? time;

  PendingAction({
    this.testName,
    this.date,
    this.time,
  });

  void clear() {
    testName = null;
    date = null;
    time = null;
  }
}