#include <iostream>
#include <vector>
#include <algorithm>
#include "qformat.hpp"

namespace {

using namespace tinymind;

template <int FractionalBits>
struct Q : QValue<16 - FractionalBits, FractionalBits, true> {
  using Base = QValue<16 - FractionalBits, FractionalBits, true>;
  Q(float f = 0.0f) : Base(f * (Base::MaxFractionalPartValue + 1)) {}

  operator float() const {
    return Base::getValue() / (float) (Base::MaxFractionalPartValue + 1);
  }
  friend std::ostream& operator<<(std::ostream& os, Q q) {
    os << (float) q;
    return os;
  }
};

}

int main() {
  Q<15> a(0.5f);
  Q<15> b(0.25f);

  std::cout << "a     = " << a << std::endl;
  std::cout << "b     = " << b << std::endl;
  std::cout << "a * b = " << (a * b) << std::endl;

  std::cout << std::endl;

  std::vector<float> v = {1.2f, 3.4f, 5.6f, 7.8f};
  std::vector<float> c = {0.12f, 0.34f, 0.56f, 0.78f};

  const int FracBits = 11;

  std::vector<Q<FracBits>> qv(v.size());
  std::vector<Q<FracBits>> qc(c.size());
  std::transform(v.begin(), v.end(), qv.begin(), [](auto f) { return Q<FracBits>(f); });
  std::transform(c.begin(), c.end(), qc.begin(), [](auto f) { return Q<FracBits>(f); });

  float s = 0;
  Q<FracBits> qs(0.0f);

  for (int i = 0; i < c.size(); i++) {
    s += v[i] * c[i];
    qs += qv[i] * qc[i];
  }

  std::cout << "s  = " << s << std::endl;
  std::cout << "qs = " << qs << std::endl;

  return 0;
}
