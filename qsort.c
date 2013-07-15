#include "qsort.h"

static void swap(int *a, int *b);

void qsort(int *array, int left, int right) {
  if (left < right) {
    int pivot = (left + right) / 2;
    int pivotvalue = array[pivot];

    int *i = &array[left];
    int *j = &array[right];

    while (i < j) {
      while (*i < pivotvalue) {
        ++i;
      }
      while (*j > pivotvalue) {
        --j;
      }

      if (i <= j) {
        swap(i, j);

        ++i;
        --j;
      }
    }

    qsort(array, left, j - array);
    qsort(array, i - array, right);
  }
}

static void swap(int *a, int* b) {
  int aux = *b;
  *b = *a;
  *a = aux;
}
