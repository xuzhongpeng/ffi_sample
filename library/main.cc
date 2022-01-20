#include <stdio.h>
#include "sample.h"

int main()
{
    printf("测试");
    hello_world();
    // 测试类的输入输出
    SportMan man = createSportMan();
    setManName(man, "让我起飞");
    // localPrint(getManName(man));

    // getFuture(back);

    return 0;
}