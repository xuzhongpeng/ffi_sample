// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'dart:io' show Platform, Directory;
import 'dart:typed_data';

import 'package:path/path.dart' as path;
import 'bindings.dart';

// FFI signature of the hello_world C function
typedef HelloWorldFunc = ffi.Void Function();
// Dart type definition for calling the C foreign function
typedef HelloWorld = void Function();
// c调用dart方法
typedef Callback = Void Function(Int32, Int32);
typedef Native_calc = Void Function(Int32, Pointer<NativeFunction<Callback>>);
typedef FFI_calc = void Function(int, Pointer<NativeFunction<Callback>>);
void globalCallback(int src, int result) {
  print("globalCallback src=$src, result=$result");
}

void main() {
  // Open the dynamic library
  var libraryPath =
      path.join(Directory.current.path, 'ibrary', 'build', 'libsample.so');
  if (Platform.isMacOS) {
    libraryPath =
        path.join(Directory.current.path, 'library', 'build', 'libsample.dylib');
  }
  if (Platform.isWindows) {
    libraryPath = path.join(
        Directory.current.path, 'library', 'Debug', 'libsample.dll');
  }

  final dylib = ffi.DynamicLibrary.open(libraryPath);

  final NativeLibrary nativeLibrary = NativeLibrary(dylib);

  print('读取到int8的值是： ${nativeLibrary.int8}');
  nativeLibrary.int8 = 3333;
  print('读取到int8的值是： ${nativeLibrary.int8}');

  // Look up the C function 'hello_world'
  nativeLibrary.hello_world();
  nativeLibrary.cPrint("hhh11".toNativeUtf8().cast<ffi.Int8>());
  print(nativeLibrary.multi_sum(33));

  // c调用dart
  nativeLibrary.calc(32, Pointer.fromFunction(globalCallback));
}
