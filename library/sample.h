// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
#include <stdint.h>

// 基础数据类型
int8_t int8 = -108;
int16_t int16 = -16;
int32_t int32 = -32;
int64_t int64 = -64;
uint8_t uint8 = 208;
uint16_t uint16 = 16;
uint32_t uint32 = 32;
uint64_t uint64 = 64;
float float32 = 0.12;
double double64 = 0.64;
char* str1 = "Dart FFI SAMPLE";


// 函数
void hello_world();

void cPrint(char *str);

int multi_sum(float nr_count, ...);

void calc(int src, void (*callback)(int, int));