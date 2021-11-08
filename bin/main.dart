import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';
import 'dart:io' show Platform, Directory;

import 'package:path/path.dart' as path;
import 'bindings.dart';

// c调用dart方法
// typedef Callback = ffi.Void Function(ffi.Int32, ffi.Int32);
// typedef Native_calc = ffi.Void Function(
//     ffi.Int32, ffi.Pointer<ffi.NativeFunction<Callback>>);
// typedef FFI_calc = void Function(
//     int, ffi.Pointer<ffi.NativeFunction<Callback>>);

class DartFunctions {
  static void dartFunction() {
    debugPrint("Dart 方法被调用了");
  }

  static int add(int num1, int num2) {
    debugPrint("num1: ${num1}, num2: ${num2}");
    return num1 + num2;
  }
}

void main() {
  // 初始化互调框架

  final NativeLibrary nativeLibrary = initLibrary();

  // *************** 基础数据类型 **************
  debugPrint('\n*************** 1. 基础数据类型 **************\n');
  debugPrint("int8=${nativeLibrary.int8}");
  debugPrint("int16=${nativeLibrary.int16}");
  debugPrint("int32=${nativeLibrary.int32}");
  debugPrint("int64=${nativeLibrary.int64}");
  debugPrint("uint8=${nativeLibrary.uint8}");
  debugPrint("uint16=${nativeLibrary.uint16}");
  debugPrint("uint32=${nativeLibrary.uint32}");
  debugPrint("uint64=${nativeLibrary.uint64}");
  debugPrint("float32=${nativeLibrary.float32}");
  debugPrint("double64=${nativeLibrary.double64}");
  debugPrint("string=${nativeLibrary.str1.cast<Utf8>().toDartString()}");

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
  nativeLibrary.str1 = "修改一下".toNativeUtf8().cast<ffi.Int8>();
  debugPrint("修改后:");
  debugPrint("int8=${nativeLibrary.int8}");
  debugPrint("int16=${nativeLibrary.int16}");
  debugPrint("int32=${nativeLibrary.int32}");
  debugPrint("int64=${nativeLibrary.int64}");
  debugPrint("uint8=${nativeLibrary.uint8}");
  debugPrint("uint16=${nativeLibrary.uint16}");
  debugPrint("uint32=${nativeLibrary.uint32}");
  debugPrint("uint64=${nativeLibrary.uint64}");
  debugPrint("float32=${nativeLibrary.float32}");
  debugPrint("double64=${nativeLibrary.double64}");
  debugPrint("string=${nativeLibrary.str1.cast<Utf8>().toDartString()}");

  // *************** Dart调用C函数 **************
  debugPrint('\n*************** Dart调用C方法 **************\n');
  // 无参数无返回值 调用C方法(无参)
  nativeLibrary.hello_world();
  // 有参数
  nativeLibrary.cPrint("我认为这个输出很有意义".toNativeUtf8().cast<ffi.Int8>());
  // 有返回值
  debugPrint("有返回值 -> " + nativeLibrary.getName().cast<Utf8>().toDartString());
  // 有参有返回值
  debugPrint("有参有返回值 -> ${nativeLibrary.multi_sum(33)}");

  // *************** C调用Dart函数 **************
  // c调用dart

  nativeLibrary.callDart(ffi.Pointer.fromFunction(DartFunctions.dartFunction),ffi.Pointer.fromFunction(DartFunctions.add, 0));


  // *************** Dart读取C变量值 **************

  debugPrint(ffi.sizeOf<ffi.Int64>());

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

void debugPrint(dynamic str) {
  print("[Dart]: ${str.toString()}");
}
