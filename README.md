
# 前置条件

> 运行环境 MacOS 10.15.6
> 
> GCC 12.0.0
> 
> cmake 3.20.1
>
> make 3.81
>
> dart 2.14.2

# 使用步骤：

## 方法1
### 下载依赖
```
dart pub get
```

### 编译C代码

1. 生成Makefile

```shell
# 进入build文件夹内
cd library/build
# 创建Makefile
cmake ..
# 编译
make
```

此步骤将会在library/build文件夹下生成`libsample.dylib`文件(MacOS)

### 使用ffigen生成dart代码

执行命令：
```
dart run ffigen
```
将会在bin目录下生成bindings.dart

### 执行
```
dart run bin/main.dart
```

## 方法2
直接执行build.sh
```
#第一次运行
chmod 777 ./build.sh
build.sh -a
```
当带有『-a』参数时，会编译cpp代码并生成bindings.dart文件，不带参数时相当于直接运行『dart bin/main.dart』.



windows编译
gcc -c .\sample.cc -o sample.o
gcc .\sample.o -o main.exe -lstdc++
编译dll
gcc -shared -o .\Debug\libsample.dll sample.cc -lstdc++