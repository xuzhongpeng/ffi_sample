echo $1
if [ "$1" == "-a" ]
then
  cd library/build
  cmake ..
  make
  cd -
  dart run ffigen
fi

echo "开始运行Dart命令...\n"
dart bin/main.dart