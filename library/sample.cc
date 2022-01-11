// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include "sample.h"
#include <pthread.h>

void localPrint(const char *str, ...);
// 输出日志信息函数
void localPrint(const char *str, ...)
{
    printf("[CPP]: ");
    va_list args;        //定义一个va_list类型的变量，用来储存单个参数
    va_start(args, str); //使args指向可变参数的第一个参数
    vprintf(str, args);  //必须用vprintf等带V的
    va_end(args);        //结束可变参数的获取
    printf("\n");
}
void back(const char *str)
{
    localPrint(str);
}
int main()
{
    hello_world();
    // 测试类的输入输出
    SportMan man = createSportMan();
    setManName(man, "让我起飞");
    localPrint(getManName(man));

    getFuture(back);

    return 0;
}

/*** 开始测试 ***/
void hello_world()
{
    localPrint("Hello World");
}
const char *getName()
{
    return "My name is 大哥大";
}

// 传入string类型
void cPrint(char *str)
{
    localPrint("%s", str);
    free(str);
}
int multi_sum(float nr_count, ...)
{
    localPrint("%f", nr_count);
    return 2;
}
// 调用dart函数
void callDart(void (*callback)(), int (*add)(int, int))
{
    localPrint("现在调用Dart函数");
    callback();

    localPrint("调用Dart Add函数");
    int result = add(1, 2);
    localPrint("Add 结果 %d", result);
}

Student initStudent(char *name, int age, float score)
{
    Student st = {name, age, score};
    return st;
}

union ContactType createContactType()
{
    union ContactType contactInfo;
    return contactInfo;
}

// 类
SportMan createSportMan()
{
    return new SportManType();
}
void setManName(SportMan self, const char *name)
{
    SportManType *p = reinterpret_cast<SportManType *>(self);
    p->setName(name);
}
const char *getManName(SportMan self)
{
    SportManType *p = reinterpret_cast<SportManType *>(self);
    return p->getName();
}

struct thread_data
{
    FUNC *callback;
};
void* say_hello(void *args)
{
    void (*callback1)(const char *) = (void (*)(const char *)) args;
    localPrint("Hello Runoob！");
    callback1("哈哈哈1");
    // pthread_exit(NULL);
    return 0;
}
// 异步测试
void getFuture(void (*callback1)(const char *))
{

    pthread_t tids;
    // callback1("嘻嘻");
    int ret = pthread_create(&tids, NULL, say_hello, (void *)callback1);
    if (ret != 0)
    {
        localPrint("pthread_create error: error_code=%d", ret);
    }
    localPrint("输出结束");
    pthread_exit(NULL);
}

// Initialize `dart_api_dl.h`
DART_EXPORT intptr_t InitDartApiDL(void *data) {
    localPrint("InitDartApiDL");
    return Dart_InitializeApiDL(data);
}