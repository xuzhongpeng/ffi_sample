
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

## 下载依赖
```
dart pub get
```

## 编译C代码

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

## 使用ffigen生成dart代码

执行命令：
```
dart run ffigen
```
将会在bin目录下生成bindings.dart

## 执行
```
dart run bin/main.dart
```
