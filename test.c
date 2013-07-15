#include "qsort.h"
#include "printarray.h"

int main(void) {
  int array[10];

  array[0] = 14;
  array[1] = 2;
  array[2] = 7;
  array[3] = 1;
  array[4] = 25;
  array[5] = 18;
  array[6] = 5;
  array[7] = 4;
  array[8] = 7;
  array[9] = 12;

  printarray(array, 10);

  qsort(array, 0, 9);

  printarray(array, 10);

  return 0;
}
