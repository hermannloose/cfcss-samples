#include <stdio.h>

class A {
  public:
    A() {
      printf("A::A\n");
    }
};

class B {
  public:
    B() {
      printf("B::B\n");
    }
};

class C {
  public:
    C() {
      printf("C::C\n");
    }
};

A a __attribute__((init_priority(3000)));
B b __attribute__((init_priority(2000)));
C c __attribute__((init_priority(4000)));

int main() {
  return 0;
}
