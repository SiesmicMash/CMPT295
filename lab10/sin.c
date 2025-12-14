
#define _POSIX_C_SOURCE 199309L
#include <assert.h>
#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include "lab10.h"

#define TIMING_RESULT(DESCR, CODE) do { \
    struct timespec start, end; \
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start); \
    CODE; \
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end); \
    double elapsed = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9; \
    printf("%25s took %7.1f ms\n", descr, elapsed * 1000); \
} while(0)


void sin_x87(double* input, double* output, uint64_t length);

void sin_stdlib(double* input, double* output, uint64_t length) {
    for (uint64_t i = 0; i < length; i++) {
        output[i] = sin(input[i]);
    }
}

double* create_array(uint64_t length) {
	double* arr = malloc(length * sizeof(double));
	for (uint64_t i = 0; i < length; i++) {
		arr[i] = ((double)rand() / RAND_MAX - 0.25);
	}
    return arr;
}

void sin_speed(const char* descr, void sin_func(double*, double*, uint64_t), uint64_t length) {
    double* input = create_array(length);
    assert(input != NULL);
    double* output = (double*)malloc(length * sizeof(double));
    assert(output != NULL);

    TIMING_RESULT(descr, sin_func(input, output, length));

    for (int i = 0; i < 10 && i < length; i++)
    {
        printf("%f\n", output[i]);
    }
    
    free(input);
    free(output);
}

int main(void) {
    sin_speed("warmup", sin_stdlib, 1000000);
    sin_speed("sin stdlib", sin_stdlib, 40000000);
    sin_speed("sin x87", sin_x87, 40000000);
    return 0;
}
