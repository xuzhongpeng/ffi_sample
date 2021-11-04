// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include <stdio.h>
#include <stdarg.h>  
#include <stdlib.h>
#include "sample.h"

void localPrint(const char* str, ...);
int main()
{
    hello_world();
    return 0;
}
void hello_world()
{
    localPrint("Hello World");
}
char* getName()
{
    return "My name is 大哥大";
}

// 传入string类型
void cPrint(char *str) 
{
    localPrint("%s", str);
    free(str);
}
int multi_sum(float nr_count, ...) {
    localPrint("%f", nr_count);
    return 2;
}

// 调用dart函数
void calc(int src, void (*callback)(int, int)) {
    int result = src * 10000;
    callback(src, result);
}

void localPrint(const char* str, ...) {
    printf("[CPP]: ");  
    va_list args;       //定义一个va_list类型的变量，用来储存单个参数  
    va_start(args,str); //使args指向可变参数的第一个参数  
    vprintf(str,args);  //必须用vprintf等带V的  
    va_end(args);       //结束可变参数的获取
    printf("\n");  
}