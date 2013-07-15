#include "printarray.h"

#include <stdio.h>

void printarray(int *array, int length) {
  for (int i = 0; i < length; ++i) {
    printf("%i: %i\n", i, array[i]);
  }
}
