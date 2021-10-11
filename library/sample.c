// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include <stdio.h>
#include <stdlib.h>
#include "sample.h"

int int8 = -108;

int main()
{
    hello_world();
    return 0;
}
void hello_world()
{
    printf("Hello World\n");
}

// 传入string类型
void cPrint(char *str) 
{
    printf("%s\n", str);
    free(str);
}
int multi_sum(float nr_count, ...) {
    int sum = 2;
    printf("%f\n", nr_count);
    return sum;
}

// 调用dart函数
void calc(int src, void (*callback)(int, int)) {
    int result = src * 10000;
    callback(src, result);
}