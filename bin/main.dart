import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:isolate';
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

  static void futureCall(ffi.Pointer<ffi.Int8> value) {
    print("异步返回了" + value.cast<Utf8>().toDartString());
  }
}

void asyncCallback() {
  print('asyncCallback called');
}

void _handleNativeMessage(dynamic message) {
  print('_handleNativeMessage $message');
  final int address = message;
  nativeLibrary.executeCallback(Pointer<Void>.fromAddress(address).cast());
  _receivePort.close();
}

ReceivePort _receivePort = ReceivePort();

typedef NativeAsyncCallbackFunc = Void Function();
final NativeLibrary nativeLibrary = initLibrary();
void main() {
  // 初始化互调框架

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

  nativeLibrary.callDart(ffi.Pointer.fromFunction(DartFunctions.dartFunction),
      ffi.Pointer.fromFunction(DartFunctions.add, 0));

  // *************** Dart读取C变量值 **************

  debugPrint(ffi.sizeOf<ffi.Int64>());

  ffi.Pointer<ffi.Uint8> bytes =
      malloc.allocate<ffi.Uint8>(ffi.sizeOf<ffi.Uint8>());

  malloc.free(bytes);

  // ********** 结构体 *************
  // dart 初始化一个student 调用C函数初始化
  var name = "幺风JSShou".toNativeUtf8();
  var student = nativeLibrary.initStudent(name.cast<ffi.Int8>(), 25, 100);
  debugPrint(
      "姓名：${student.name.cast<Utf8>().toDartString()} ,年龄：${student.age} , 分数：${student.score}");
  malloc.free(name);
  /************共用体 *******/
  var contactType = nativeLibrary.createContactType();
  var phone = "13032003004".toNativeUtf8();
  contactType.phone = phone.cast();
  debugPrint(
      "电话：${contactType.email.cast<Utf8>().toDartString()}, email: ${contactType.phone.cast<Utf8>().toDartString()}");
  var email = "13032003004@gmail.com".toNativeUtf8();
  contactType.email = email.cast();
  debugPrint(
      "电话：${contactType.email.cast<Utf8>().toDartString()}, email: ${contactType.phone.cast<Utf8>().toDartString()}");
  malloc.free(phone);
  malloc.free(email);

  // ********** 类 **********/
  SportMan man = nativeLibrary.createSportMan();
  nativeLibrary.setManName(man, "SY".toNativeUtf8().cast());
  debugPrint(
      "运动员名称：" + nativeLibrary.getManName(man).cast<Utf8>().toDartString());

  SportManType m = SportManType(nativeLibrary);
  m.setName('SY is a dog');
  debugPrint(m.getName());

  // ********** 异步 **********/
  // nativeLibrary.getFuture(ffi.Pointer.fromFunction(DartFunctions.futureCall));
  // WidgetsFlutterBinding.ensureInitialized();
  StreamSubscription? _subscription;
  void ensureNativeInitialized() {
    var nativeInited =
        nativeLibrary.InitDartApiDL(NativeApi.initializeApiDLData);
    assert(nativeInited == 0, 'DART_API_DL_MAJOR_VERSION != 2');
    _subscription = _receivePort.listen(_handleNativeMessage);
    nativeLibrary.registerSendPort(_receivePort.sendPort.nativePort);
  }

  ensureNativeInitialized();
  var asyncFunc = Pointer.fromFunction<NativeAsyncCallbackFunc>(asyncCallback);
  nativeLibrary.nativeAsyncCallback(asyncFunc);
  nativeLibrary.nativeAsyncCallback(asyncFunc);
}

/*** 以下是类封装 */
class SportManType {
  //extends ffi.Opaque
  String? _name;
  late NativeLibrary _lib;
  late SportMan man;

  SportManType(NativeLibrary library) {
    _lib = library;
    man = _lib.createSportMan();
  }

  String getName() {
    return _lib.getManName(man).cast<Utf8>().toDartString();
  }

  void setName(String name) {
    _lib.setManName(man, name.toNativeUtf8().cast());
  }
}

/**** 类封装 end ***/
/*** 以下是异步封装 */
// C++调用成功后回调

/*** 异步封装end */

/*** 以下是工具方法 */
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
