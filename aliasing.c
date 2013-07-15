#include <stdlib.h>

int alias1() {
  int i = 0;
  int value = rand();

  switch (value) {
    case 0:
      i += 1;
    case 1:
      i += 2;
      break;
    case 2:
      i += 5;
      break;
    case 3:
      break;
    case 4:
      i += 5;
      break;
    default:
      break;
  }

  return i;
}

int alias2(int choice) {
  // First non-entry block, should have more than once predecessor.
  if (choice == 0) {
    return 0;
  } else {
    switch (choice) {
      case 1:
        return 1;
      case 2:
        return 2;
      default:
        return 5;
    }
  }
}
