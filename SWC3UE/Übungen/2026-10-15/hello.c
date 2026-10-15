#include <stdio.h>
#include <stdlib.h>
#include <assert.h> 

#if !defined EXIT_SUCCESS
    #define EXIT_SUCCESS 0
#endif


void test_1 () {
    printf("Hello, World!\n");
}

void test_2 (int argc, char* argv[]) {
    assert(argv != NULL);
    for (int i = 0; i < argc; i++) {
        printf("%d: '%s'\n", i, argv[i]);
    }
}

int calculate (int a, int b, char op) {
    switch (op) {
        case '+': return a + b;
        case '-': return a - b;
        case '*': return a * b;
        case '/': return b != 0 ? a / b : 0;
    }

    assert(0 && "Falscher Operator!");
}

void test_3 (int argc, char* argv[]) {
    assert(argc >= 4);
    assert(argv != NULL);
    assert(argv[2] != NULL);
    assert(argv[3] != NULL);

    int a = atoi(argv[1]);    // *(argv + 1)
    char op = argv[2][0];      // *(*(argv + 2) + 0)
    int b = atoi(argv[3]);     // *(argv + 3)

    printf("%d\n", calculate(a, b, op   ));

}

int main(int argc, char* argv[]) {
    test_1();
    test_2(argc, argv);
    test_3(argc, argv);

    return EXIT_SUCCESS;
}
