class Bill {
  String id;
  String userId;
  String time;
  String voucherId;
  Bill({
    this.id = "",
    required this.userId,
    required this.time,
    required this.voucherId,
  }) {
    id = "${userId}_${time.replaceAll(" ", "_")}";
  }
}

void main() {
  Bill bill = Bill(
    userId: "cbn",
    time: DateTime.now().toString(),
    voucherId: "",
  );
  print(bill.id);
}
