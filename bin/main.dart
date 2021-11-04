import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';
import 'dart:io' show Platform, Directory;

import 'package:path/path.dart' as path;
import 'bindings.dart';

// c调用dart方法
typedef Callback = ffi.Void Function(ffi.Int32, ffi.Int32);
typedef Native_calc = ffi.Void Function(
    ffi.Int32, ffi.Pointer<ffi.NativeFunction<Callback>>);
typedef FFI_calc = void Function(
    int, ffi.Pointer<ffi.NativeFunction<Callback>>);
void globalCallback(int src, int result) {
  print("globalCallback src=$src, result=$result");
}

void main() {
  // 初始化互调框架

  final NativeLibrary nativeLibrary = initLibrary();

  // *************** 基础数据类型 **************
  print('\n*************** 1. 基础数据类型 **************\n');
  print("int8=${nativeLibrary.int8}");
  print("int16=${nativeLibrary.int16}");
  print("int32=${nativeLibrary.int32}");
  print("int64=${nativeLibrary.int64}");
  print("uint8=${nativeLibrary.uint8}");
  print("uint16=${nativeLibrary.uint16}");
  print("uint32=${nativeLibrary.uint32}");
  print("uint64=${nativeLibrary.uint64}");
  print("float32=${nativeLibrary.float32}");
  print("double64=${nativeLibrary.double64}");
  print("string=${nativeLibrary.str1.cast<Utf8>().toDartString()}");

  nativeLibrary.int8++;
  nativeLibrary.int16++;
  nativeLibrary.int32++;
  nativeLibrary.int64++;
  nativeLibrary.uint8++;
  nativeLibrary.uint16++;
  nativeLibrary.uint32++;
  nativeLibrary.uint64++;
  nativeLibrary.float32++;
  nativeLibrary.double64++;
  nativeLibrary.str1 = "修改一下".toNativeUtf8().cast();
  print("修改后:");
  print("int8=${nativeLibrary.int8}");
  print("int16=${nativeLibrary.int16}");
  print("int32=${nativeLibrary.int32}");
  print("int64=${nativeLibrary.int64}");
  print("uint8=${nativeLibrary.uint8}");
  print("uint16=${nativeLibrary.uint16}");
  print("uint32=${nativeLibrary.uint32}");
  print("uint64=${nativeLibrary.uint64}");
  print("float32=${nativeLibrary.float32}");
  print("double64=${nativeLibrary.double64}");
  print("string=${nativeLibrary.str1.cast<Utf8>().toDartString()}");

  // *************** Dart调用C方法 **************
  print('\n*************** Dart调用C方法 **************\n');
  // 调用C方法(无参)
  nativeLibrary.hello_world();
  // 调用C方法(有参)
  nativeLibrary.cPrint("hhh11".toNativeUtf8().cast<ffi.Int8>());
  print(nativeLibrary.multi_sum(33));

  // *************** C调用Dart方法 **************
  // c调用dart
  nativeLibrary.calc(32, ffi.Pointer.fromFunction(globalCallback));

  // *************** Dart读取C变量值 **************

  print('读取到int8的值是： ${nativeLibrary.int8}');
  nativeLibrary.int8 = 3333;
  print('读取到int8的值是： ${nativeLibrary.int8}');

  print(ffi.sizeOf<ffi.Int64>());

  ffi.Pointer<ffi.Uint8> bytes =
      malloc.allocate<ffi.Uint8>(ffi.sizeOf<ffi.Uint8>());

  malloc.free(bytes);

  // *************** C读取Dart变量值 **************
}

/// 初始化library
NativeLibrary initLibrary() {
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
  return NativeLibrary(dylib);
}
