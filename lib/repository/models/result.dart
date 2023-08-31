class Result {
  late bool status;
  late int? code;
  late String? message;
  Result({
    required this.status,
    this.code,
    this.message,
  });
}
