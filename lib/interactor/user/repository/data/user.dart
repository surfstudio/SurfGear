import 'package:flutter_template/domain/user.dart';
import 'package:flutter_template/interactor/base/transformable.dart';

/// Респонс на ответ сервера
///
/// Использовал [https://javiercbk.github.io/json_to_dart/] для генерации
class UserResponse implements Transformable<User>{
  String name;
  String surname;
  String gender;
  String region;

  UserResponse({this.name, this.surname, this.gender, this.region});

  UserResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    gender = json['gender'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['gender'] = this.gender;
    data['region'] = this.region;
    return data;
  }

  @override
  User transform() {
    return User(name);
  }
}