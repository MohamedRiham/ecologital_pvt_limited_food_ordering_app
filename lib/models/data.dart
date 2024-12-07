import 'package:ecologital_pvt_limited_food_ordering_app/models/result.dart';

class Data {
  final Result result;

  Data({required this.result});

  factory Data.fromJson(dynamic json) {
    return Data(result: Result.fromJson(json['Result']));
  }
}
