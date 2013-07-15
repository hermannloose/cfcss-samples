#include "initprio-a.h"

A a __attribute__((init_priority(3000)));

int main() {
  return 0;
}
