#include <stdio.h>

typedef void (*ctor_function_t)(void);

void a(void);
void b(void);
void c(void);
void d(void);
void e(void);
void f(void);
void g(void);
void h(void);
void i(void);

int main(void) {
  ctor_function_t functions[9];
  functions[0] = &a;
  functions[1] = &b;
  functions[2] = &c;
  functions[3] = &d;
  functions[4] = &e;
  functions[5] = &f;
  functions[6] = &g;
  functions[7] = &h;
  functions[8] = &i;

  ctor_function_t *start = functions + 3;
  ctor_function_t *end = functions + 3;

  if (start < end) {
    for (; start != end; ++start) {
      printf("start: %p\n", start);
    }
  } else {
    for (; start != end;) {
      --start;
      printf("end: %p\n", start);
    }
  }
}

void a(void) {
  printf("a()\n");
}

void b(void) {
  printf("b()\n");
}

void c(void) {
  printf("c()\n");
}

void d(void) {
  printf("d()\n");
}

void e(void) {
  printf("e()\n");
}

void f(void) {
  printf("f()\n");
}

void g(void) {
  printf("g()\n");
}

void h(void) {
  printf("h()\n");
}

void i(void) {
  printf("i()\n");
}
