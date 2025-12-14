#include <stdint.h>
#include <stdlib.h>
#include "/home/usaidsyed/sfu/cmpt 295/lab11/version2-master/vectorclass.h"
#include "lab11.h"

double dot_double_vc(double* arr1, double* arr2, uint64_t length) {
    Vec4d total = Vec4d(0.0);

    uint64_t i = 0;
    for (; i + 4 <= length; i += 4) {
        Vec4d v1 = Vec4d().load(&arr1[i]);
        Vec4d v2 = Vec4d().load(&arr2[i]);
        total += v1 * v2;
    }

    double curTotal = horizontal_add(total);
    for (; i < length; i++) {
        curTotal+= arr1[i] * arr2[i];
    }

    return curTotal;
}

float dot_single_vc(float* arr1, float* arr2, uint64_t length) {
    Vec8f total = Vec8f(0.0f);
    uint64_t i = 0;
    for (; i + 8 <= length; i += 8) {
        Vec8f v1 = Vec8f().load(&arr1[i]);
        Vec8f v2 = Vec8f().load(&arr2[i]);
        total += v1 * v2;
    }
    float curTotal = horizontal_add(total);
    for (; i < length; i++) {
        curTotal += arr1[i] * arr2[i];
    }

    return curTotal;
}

void map_poly_double_vc(double* input, double* __restrict output, uint64_t length, double a, double b, double c, double d) {
    Vec4d va(a), vb(b), vc(c), vd(d);
    uint64_t i = 0;
    for (; i + 4 <= length; i += 4) {
        Vec4d x = Vec4d().load(&input[i]);
        Vec4d result = ((va * x + vb) * x + vc) * x + vd;
        result.store(&output[i]);
    }
    for (; i < length; i++) {
        double x = input[i];
        output[i] = a*x*x*x + b*x*x + c*x + d;
    }
}


void map_poly_single_vc(float* input, float* __restrict output, uint64_t length, float a, float b, float c, float d) {
    Vec8f va(a), vb(b), vc(c), vd(d);
    uint64_t i = 0;
    for (; i + 8 <= length; i += 8) {
        Vec8f x = Vec8f().load(&input[i]);
        Vec8f result = ((va * x + vb) * x + vc) * x + vd;
        result.store(&output[i]);
    }
    for (; i < length; i++) {
        float x = input[i];
        output[i] = a*x*x*x + b*x*x + c*x + d;
    }
}