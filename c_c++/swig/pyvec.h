#ifndef PYVEC_H_
#define PYVEC_H_

class PyVec {
public:
    PyVec(int n) {
        size_ = n;
        data_ = new float[n];
        if (!data_) {
            size_ = 0;
            throw "mem alloc failure";
        }
    }

    virtual ~PyVec() {
        if (data_ != NULL) {
            delete [] data_;
            data_ = NULL;
            size_ = 0;
        }
    }

private:
    float *data_;
    int    size_;
};
    

#endif
