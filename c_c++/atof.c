#include <stdlib.h>
#include <stdio.h>

int main() {
    char s[] = "-1500.1";
    printf("%s %f\n", s, atof(s));
    return 0;
}
