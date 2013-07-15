#include <stdio.h>

typedef void (*fpointer)();

void fanin1(char *caller);

void a() {
  printf("a()\n");
  fanin1("caller_a");
}

void b() {
  printf("b()\n");
  fanin1("caller_b");
}

void c() {
  printf("c()\n");
  fanin1("caller_c");
}

static fpointer spointers[3] = { &a, &b, &c };

void fanin1(char *caller) {
  printf("fanin1(%s)\n", caller);
}

void fpointers() {
  fpointer pointers[3];
  pointers[0] = &a;
  pointers[1] = &b;
  pointers[2] = &c;

  printf("Now via function pointers ...\n");
  for (int i = 0; i < 3; i++) {
    (*pointers[i])();
  }
}

void staticfpointers() {
  printf("Static function pointers.\n");
  for (int i = 0; i < 3; i++) {
    (*spointers[i])();
  }
}

int main(void) {
  a();
  b();
  c();
  fpointers();
  staticfpointers();
  return 0;
}
