#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

unsigned divide(int a, int b) {
    asm (
        ".p2align 4\n"
        "div%=:      cdq\n\t"
        "   idiv    ecx\n"
        "   test    edx, edx\n"
        "   sete    al\n"
        /* "   mov     eax, edx\n" */
        "div_end%=:\n"
        : "+a" (a), "+c" (b)
        :
        : "edx"
    );
    return a;
}

int main(int argc, char** argv) {
    assert(argc > 2);
    int a = atoi(argv[1]), b = atoi(argv[2]);

    printf(divide(a, b) ? "true\n" : "false\n");

    return 0;
}
