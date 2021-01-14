// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// To parse this JSON data, do
//
//     final nameGeneratorResponse = nameGeneratorResponseFromJson(jsonString);

import 'dart:convert';

import 'package:name_generator/domain/user.dart';

class NameGeneratorResponse {
  String? name;
  String? address;
  int? height;
  double? weight;
  String? blood;
  String? eye;
  String? hair;
  String? username;
  String? password;

  NameGeneratorResponse({
    this.name,
    this.height,
    this.address,
    this.blood,
    this.eye,
    this.hair,
    this.weight,
    this.password,
    this.username,
  });

  factory NameGeneratorResponse.fromRawJson(String str) =>
      NameGeneratorResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NameGeneratorResponse.fromJson(Map<String, Object> json) => new NameGeneratorResponse(
        name: json["name"] as String,
        height: json["height"] == null ? null : json["height"] as int,
        address: json["address"] as String,
        blood: json["blood"] as String,
        eye: json["eye"] as String,
        hair: json["hair"] as String,
        weight: json["weight"] == null ? null : json["weight"] as double,
        password: json["password"] as String,
        username: json["username"] as String,
      );

  Map<String, Object?> toJson() => {
        "name": name,
        "height": height,
        "address": address,
        "blood": blood,
        "eye": eye,
        "hair": hair,
        "weight": weight,
        "password": password,
        "username": username,
      };

  User transform() => User(
        name: name,
        height: height,
        address: address,
        blood: blood,
        eye: eye,
        hair: hair,
        weight: weight,
        password: password,
        username: username,
      );
}
