echo $1
if [ "$1" == "-a" ]
then
  cd library/build
  cmake ..
  make
  cd -
  dart run ffigen
fi
if [ "$1" == "-b" ]
then
  cd library/build
  make
  cd -
fi
echo "开始运行Dart命令...\n"
dart run