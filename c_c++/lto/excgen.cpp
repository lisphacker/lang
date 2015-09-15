#include <exception>
#include "excgen.h"

int foo(int count) {
    if (count == 5) {
        A a;
    }

    return count + 10;
}
