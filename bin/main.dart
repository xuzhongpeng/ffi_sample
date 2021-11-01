import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'dart:io' show Platform, Directory;

import 'package:path/path.dart' as path;
import 'bindings.dart';

// c调用dart方法
typedef Callback = Void Function(Int32, Int32);
typedef Native_calc = Void Function(Int32, Pointer<NativeFunction<Callback>>);
typedef FFI_calc = void Function(int, Pointer<NativeFunction<Callback>>);
void globalCallback(int src, int result) {
  print("globalCallback src=$src, result=$result");
}

void main() {
  // 初始化互调框架
  var libraryPath =
      path.join(Directory.current.path, 'library', 'build', 'libsample.so');
  if (Platform.isMacOS) {
    libraryPath = path.join(
        Directory.current.path, 'library', 'build', 'libsample.dylib');
  }
  if (Platform.isWindows) {
    libraryPath =
        path.join(Directory.current.path, 'library', 'Debug', 'libsample.dll');
  }
  final dylib = ffi.DynamicLibrary.open(libraryPath);
  final NativeLibrary nativeLibrary = NativeLibrary(dylib);

  // *************** 1. Dart调用C方法 **************

  // 调用C方法(无参)
  nativeLibrary.hello_world();
  // 调用C方法(有参)
  nativeLibrary.cPrint("hhh11".toNativeUtf8().cast<ffi.Int8>());
  print(nativeLibrary.multi_sum(33));

  // *************** 2. C调用Dart方法 **************
  // c调用dart
  nativeLibrary.calc(32, Pointer.fromFunction(globalCallback));

  // *************** 3. Dart读取C变量值 **************

  print('读取到int8的值是： ${nativeLibrary.int8}');
  nativeLibrary.int8 = 3333;
  print('读取到int8的值是： ${nativeLibrary.int8}');

  // *************** 4. C读取Dart变量值 **************
}
