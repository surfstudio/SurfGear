// Copyright (c) 2019-present, SurfStudio LLC
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

/// Содержит информацию фактов о котиках
class Fact {
  /// Содержание строки
  final String? content;

  /// Далинна строки
  final int? length;

  const Fact({
    this.content,
    this.length,
  });

  factory Fact.fromJson(Map<String, dynamic> json) => Fact(
        content: json['fact'] as String?,
        length: json['length'] as int?,
      );
}
