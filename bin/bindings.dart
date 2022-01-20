// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
import 'dart:ffi' as ffi;

/// demo
class NativeLibrary {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  NativeLibrary(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  NativeLibrary.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  late final ffi.Pointer<ffi.Int8> _int8 = _lookup<ffi.Int8>('int8');

  int get int8 => _int8.value;

  set int8(int value) => _int8.value = value;

  late final ffi.Pointer<ffi.Int16> _int16 = _lookup<ffi.Int16>('int16');

  int get int16 => _int16.value;

  set int16(int value) => _int16.value = value;

  late final ffi.Pointer<ffi.Int32> _int32 = _lookup<ffi.Int32>('int32');

  int get int32 => _int32.value;

  set int32(int value) => _int32.value = value;

  late final ffi.Pointer<ffi.Int64> _int64 = _lookup<ffi.Int64>('int64');

  int get int64 => _int64.value;

  set int64(int value) => _int64.value = value;

  late final ffi.Pointer<ffi.Uint8> _uint8 = _lookup<ffi.Uint8>('uint8');

  int get uint8 => _uint8.value;

  set uint8(int value) => _uint8.value = value;

  late final ffi.Pointer<ffi.Uint16> _uint16 = _lookup<ffi.Uint16>('uint16');

  int get uint16 => _uint16.value;

  set uint16(int value) => _uint16.value = value;

  late final ffi.Pointer<ffi.Uint32> _uint32 = _lookup<ffi.Uint32>('uint32');

  int get uint32 => _uint32.value;

  set uint32(int value) => _uint32.value = value;

  late final ffi.Pointer<ffi.Uint64> _uint64 = _lookup<ffi.Uint64>('uint64');

  int get uint64 => _uint64.value;

  set uint64(int value) => _uint64.value = value;

  late final ffi.Pointer<ffi.Float> _float32 = _lookup<ffi.Float>('float32');

  double get float32 => _float32.value;

  set float32(double value) => _float32.value = value;

  late final ffi.Pointer<ffi.Double> _double64 =
      _lookup<ffi.Double>('double64');

  double get double64 => _double64.value;

  set double64(double value) => _double64.value = value;

  late final ffi.Pointer<ffi.Pointer<ffi.Int8>> _str1 =
      _lookup<ffi.Pointer<ffi.Int8>>('str1');

  ffi.Pointer<ffi.Int8> get str1 => _str1.value;

  set str1(ffi.Pointer<ffi.Int8> value) => _str1.value = value;

  /// dart调C函数
  void hello_world() {
    return _hello_world();
  }

  late final _hello_worldPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function()>>('hello_world');
  late final _hello_world = _hello_worldPtr.asFunction<void Function()>();

  ffi.Pointer<ffi.Int8> getName() {
    return _getName();
  }

  late final _getNamePtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<ffi.Int8> Function()>>('getName');
  late final _getName =
      _getNamePtr.asFunction<ffi.Pointer<ffi.Int8> Function()>();

  void cPrint(
    ffi.Pointer<ffi.Int8> str,
  ) {
    return _cPrint(
      str,
    );
  }

  late final _cPrintPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Int8>)>>(
          'cPrint');
  late final _cPrint =
      _cPrintPtr.asFunction<void Function(ffi.Pointer<ffi.Int8>)>();

  int multi_sum(
    double nr_count,
  ) {
    return _multi_sum(
      nr_count,
    );
  }

  late final _multi_sumPtr =
      _lookup<ffi.NativeFunction<ffi.Int32 Function(ffi.Float)>>('multi_sum');
  late final _multi_sum = _multi_sumPtr.asFunction<int Function(double)>();

  /// C调用Dart函数
  void callDart(
    ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>> callback,
    ffi.Pointer<ffi.NativeFunction<ffi.Int32 Function(ffi.Int32, ffi.Int32)>>
        add,
  ) {
    return _callDart(
      callback,
      add,
    );
  }

  late final _callDartPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>,
              ffi.Pointer<
                  ffi.NativeFunction<
                      ffi.Int32 Function(ffi.Int32, ffi.Int32)>>)>>('callDart');
  late final _callDart = _callDartPtr.asFunction<
      void Function(
          ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>,
          ffi.Pointer<
              ffi.NativeFunction<ffi.Int32 Function(ffi.Int32, ffi.Int32)>>)>();

  Student initStudent(
    ffi.Pointer<ffi.Int8> name,
    int age,
    double score,
  ) {
    return _initStudent(
      name,
      age,
      score,
    );
  }

  late final _initStudentPtr = _lookup<
      ffi.NativeFunction<
          Student Function(
              ffi.Pointer<ffi.Int8>, ffi.Int32, ffi.Float)>>('initStudent');
  late final _initStudent = _initStudentPtr
      .asFunction<Student Function(ffi.Pointer<ffi.Int8>, int, double)>();

  ContactType createContactType() {
    return _createContactType();
  }

  late final _createContactTypePtr =
      _lookup<ffi.NativeFunction<ContactType Function()>>('createContactType');
  late final _createContactType =
      _createContactTypePtr.asFunction<ContactType Function()>();

  SportMan createSportMan() {
    return _createSportMan();
  }

  late final _createSportManPtr =
      _lookup<ffi.NativeFunction<SportMan Function()>>('createSportMan');
  late final _createSportMan =
      _createSportManPtr.asFunction<SportMan Function()>();

  void setManName(
    SportMan self,
    ffi.Pointer<ffi.Int8> name,
  ) {
    return _setManName(
      self,
      name,
    );
  }

  late final _setManNamePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(SportMan, ffi.Pointer<ffi.Int8>)>>('setManName');
  late final _setManName = _setManNamePtr
      .asFunction<void Function(SportMan, ffi.Pointer<ffi.Int8>)>();

  ffi.Pointer<ffi.Int8> getManName(
    SportMan self,
  ) {
    return _getManName(
      self,
    );
  }

  late final _getManNamePtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<ffi.Int8> Function(SportMan)>>(
          'getManName');
  late final _getManName =
      _getManNamePtr.asFunction<ffi.Pointer<ffi.Int8> Function(SportMan)>();

  void getFuture(
    ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Int8>)>>
        callback,
  ) {
    return _getFuture(
      callback,
    );
  }

  late final _getFuturePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Pointer<
                  ffi.NativeFunction<
                      ffi.Void Function(
                          ffi.Pointer<ffi.Int8>)>>)>>('getFuture');
  late final _getFuture = _getFuturePtr.asFunction<
      void Function(
          ffi.Pointer<
              ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Int8>)>>)>();

  /// 初始化dart_api_dl相关数据
  int InitDartApiDL(
    ffi.Pointer<ffi.Void> data,
  ) {
    return _InitDartApiDL(
      data,
    );
  }

  late final _InitDartApiDLPtr =
      _lookup<ffi.NativeFunction<ffi.IntPtr Function(ffi.Pointer<ffi.Void>)>>(
          'InitDartApiDL');
  late final _InitDartApiDL =
      _InitDartApiDLPtr.asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  /// 将dart send port传递到C/C++内存缓存起来
  void registerSendPort(
    int send_port,
  ) {
    return _registerSendPort(
      send_port,
    );
  }

  late final _registerSendPortPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(Dart_Port)>>(
          'registerSendPort');
  late final _registerSendPort =
      _registerSendPortPtr.asFunction<void Function(int)>();

  /// 执行一个异步无返回值的异步函数
  void nativeAsyncCallback(
    VoidCallbackFunc callback,
  ) {
    return _nativeAsyncCallback(
      callback,
    );
  }

  late final _nativeAsyncCallbackPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(VoidCallbackFunc)>>(
          'nativeAsyncCallback');
  late final _nativeAsyncCallback =
      _nativeAsyncCallbackPtr.asFunction<void Function(VoidCallbackFunc)>();

  /// 执行dart传递回来的地址函数
  void executeCallback(
    VoidCallbackFunc callback,
  ) {
    return _executeCallback(
      callback,
    );
  }

  late final _executeCallbackPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(VoidCallbackFunc)>>(
          'executeCallback');
  late final _executeCallback =
      _executeCallbackPtr.asFunction<void Function(VoidCallbackFunc)>();
}

/// 结构体
class Student extends ffi.Struct {
  external ffi.Pointer<ffi.Int8> name;

  @ffi.Int32()
  external int age;

  @ffi.Float()
  external double score;
}

/// 共同体
class ContactType extends ffi.Union {
  external ffi.Pointer<ffi.Int8> phone;

  external ffi.Pointer<ffi.Int8> email;
}

typedef SportMan = ffi.Pointer<ffi.Void>;

/// A port is used to send or receive inter-isolate messages
typedef Dart_Port = ffi.Int64;

/// C调用Dart异步函数
typedef VoidCallbackFunc = ffi.Pointer<ffi.NativeFunction<ffi.Void Function()>>;
