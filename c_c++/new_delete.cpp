#include <iostream>

class Vector2 {
public:
    Vector2(float x = 0, float y = 0): _x(x), _y(y) {
        std::cout << "Vector2(" << x << ", " << y << ")" << std::endl;
    }

    void *operator new(size_t size) {
        std::cout << "new(" << size << ")" << std::endl;
        return malloc(size);
    }

    void *operator new[](size_t size) {
        std::cout << "new[](" << size << ")" << std::endl;
        return malloc(size);
    }

protected:
    float _x, _y;
};

int main() {
    auto v = new Vector2(10, 20);
    auto va = new Vector2[10];

    return 0;
}
