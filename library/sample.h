// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
#include <stdint.h>
#include "dart_api_dl.h"
// 因为本测试设计到了C++的类(用的C++编译的)，所以需要把函数都通过extern "C"导出让ffi识别
#ifdef __cplusplus
  #define EXPORT extern "C" 
  //__declspec(dllexport)
#else
  #define EXPORT // ffigen生成时，会使用C编译器，所以改成空即可
#endif
// 基础数据类型
EXPORT int8_t int8 = -108;
EXPORT int16_t int16 = -16;
EXPORT int32_t int32 = -32;
EXPORT int64_t int64 = -64;
EXPORT uint8_t uint8 = 208;
EXPORT uint16_t uint16 = 16;
EXPORT uint32_t uint32 = 32;
EXPORT uint64_t uint64 = 64;
EXPORT float float32 = 0.12;
EXPORT double double64 = 0.64;
EXPORT const char *str1 = "Dart FFI SAMPLE";

/**   dart调C函数   **/
// 无参无返回
EXPORT void hello_world();
// 有返回
EXPORT const char *getName();
// 有参数
EXPORT void cPrint(char *str);
// 有参数还有返回值
EXPORT int multi_sum(float nr_count, ...);

/**  C调用Dart函数  **/
EXPORT void callDart(void (*callback)(), int (*add)(int, int));

/** 结构体 **/
typedef struct
{
  char *name;
  int age;
  float score;
} Student;
// C创建一个Student
EXPORT Student initStudent(char *name, int age, float score);
/** 共同体 **/
EXPORT union ContactType
{
  char *phone;
  char *email;
};
EXPORT union ContactType createContactType();

/** 类 **/
#ifdef __cplusplus // 需要通过ifdef __cplusplus让C编译器跳过，ffigen无法识别此方法
class SportManType
{
  const char *name; //名称
public:
  void setName(const char *str)
  {
    name = str;
  }
  const char *getName()
  {
    return name;
  }
};
#endif
EXPORT typedef void* SportMan;

EXPORT SportMan createSportMan(); // 初始化SportManType类
EXPORT void setManName(SportMan self,const char *name); // 设置姓名
EXPORT const char *getManName(SportMan self); // 获取姓名


/**  C调用Dart函数(错误） **/
typedef void(FUNC)(const char *);
EXPORT void getFuture(void (*callback)(const char *));

/**  C调用Dart函数 **/
// Initialize `dart_api_dl.h`
DART_EXPORT intptr_t InitDartApiDL(void *data);

