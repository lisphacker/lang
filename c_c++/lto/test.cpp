#include <iostream>
#include <exception>
#include "excgen.h"

int main(int argc, char **argv) {
    try{
        A a;
    }
    catch (std::exception &e) {
        std::cerr << "Caught " << e.what() << std::endl;
    }
    
    return 0;
    
}
