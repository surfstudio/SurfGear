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

/// Java-like enum
/// While extending this class you can create
/// a static method `byValue` returning
/// a class field.
///
/// Example:
/// ```dart
/// class TransactionType extends Enum<String> {
///   const TransactionType(String val) : super(val);
///
///   static const TransactionType IN = TransactionType('in');
///   static const TransactionType OUT = TransactionType('out');
///
///   static TransactionType byValue(String value) {
///     switch (value) {
///       case 'in':
///         return IN;
///       case 'out':
///         return OUT;
///       default:
///         return OUT;
///     }
///   }
/// }
/// ```
abstract class Enum<T> {
  const Enum(this.value);

  final T value;
}
