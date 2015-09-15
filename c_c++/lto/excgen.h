#include <exception>
#include <string>

int foo(int count);

class MyException : public std::exception {
public:
    MyException(const char *msg) {
        message_ = "my exception - ";
        message_ += msg;
    }

    virtual ~MyException() throw() {
    }

    const char *what() const throw() {
        return message_.c_str();
    }

protected:
    std::string message_;
};

class A {
public:
    A() {
        std::string msg = "funny stuff in ";
        msg += "constructor";
        throw MyException(msg.c_str());
    }

protected:
    std::string hello;
};
