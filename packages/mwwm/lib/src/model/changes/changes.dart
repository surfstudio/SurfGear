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

/// Signal for [Model] to perform some action,
/// i.e. download or upload data.
///
/// `R` is a type of result which is returned after
/// performing the action.
abstract class Change<R> {
  @override
  String toString() {
    return '$runtimeType';
  }
}

/// A Change that return Future as result
/// `R` - type of result inside Future
abstract class FutureChange<R> extends Change<Future<R>> {}

/// A Change thate return Stream as result
/// `R` - type of result inside Stream
abstract class StreamChange<R> extends Change<Stream<R>> {}
