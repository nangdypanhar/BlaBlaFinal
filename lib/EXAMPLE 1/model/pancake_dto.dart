import 'package:week_3_blabla_project/EXAMPLE%201/model/pancake.dart';

class PancakeDto {
  static Pancake fromJson(String id, Map<String, dynamic> json) {
    return Pancake(id: id, color: json['color'], price: json['price']);
  }

  static Map<String, dynamic> toJson(Pancake pancake) {
    return {'name': pancake.color, 'price': pancake.price};
  }
}