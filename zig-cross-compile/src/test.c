#include "mathtest.h"
#include <stdio.h>

//
// main app is C but uses Zig lib
//
int main(int argc, char **argv) {
    printf("Running C and Zig all compiled together WOW \n");
    int result = add(42, 1337);
    printf("%d\n", result);
    return 0;
}