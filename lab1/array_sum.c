#include <stdio.h>
#include "array_sum.h"


int32_t array_sum(int32_t *arr, uint32_t n) {
		
	int32_t count = 0;
	for (int i = 0; i < n; i++) {
		count += arr[i];
	}
		
	return count;
}
