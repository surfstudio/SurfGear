import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:surfgear_webpage/assets/images.dart';

enum ModuleStatus { surf, alpha, beta, release }

class Module {
  final String name;
  final String link;
  final ModuleStatus status;
  final String description;
  final String imgPath;

  Module({
    this.name,
    this.link,
    this.status,
    this.description,
    this.imgPath,
  });
}

List<String> _stubImages = [icLib1, icLib2, icLib2, icLib4, icLib5, icLib6];

Future<List<Module>> get modules async {
  final json = await rootBundle.loadString('assets/libraries_config.json');
  final jsonList = jsonDecode(json) as List;

  return [
    for (var i = 0; i < jsonList.length; i++)
      Module(
        name: jsonList[i]['name'],
        link: jsonList[i]['link'],
        description: jsonList[i]['description'],
        status: _mapStatus(jsonList[i]['status']),
        imgPath: jsonList[i]['imgPath'] ?? _stubImages[i % _stubImages.length],
      ),
  ];
}

ModuleStatus _mapStatus(String status) {
  switch (status) {
    case 'alpha':
      return ModuleStatus.alpha;
    case 'beta':
      return ModuleStatus.beta;
    case 'release':
      return ModuleStatus.release;
    default:
      return ModuleStatus.surf;
  }
}
