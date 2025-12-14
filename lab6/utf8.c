
#include "utf8.h"
#include <stdint.h> 
#include <cstddef>
#include <cstdio> 


void decode_utf8(const char* s){
    size_t i = 0;
    while (s[i] != '\0') {
        if ((s[i] & 0x80) == 0) {
            uint32_t single_byte = s[i] & 0x7F;
            report_character(single_byte, 1);
            i += 1;
        } else if ((s[i] & 0xE0) == 0xC0) {
            uint32_t two_byte_first = s[i] & 0x1F;
            uint32_t two_byte_second = s[i+1] & 0x3F;
            uint32_t bytes = (two_byte_first << 6) | two_byte_second;
            report_character(bytes, 2);
            i += 2;
        } else if ((s[i] & 0xF0) == 0xE0) {
            uint32_t three_byte_first = s[i] & 0x0F;
            uint32_t three_byte_second = s[i+1] & 0x3F;
            uint32_t three_byte_third = s[i+2] & 0x3f;
            uint32_t bytes = (three_byte_first << 12) | (three_byte_second << 6) | three_byte_third;
            report_character(bytes, 3);
            i += 3;
        } else if ((s[i] & 0xF8) == 0xF0) {
            uint32_t four_byte_first = s[i] & 0x07;
            uint32_t four_byte_second = s[i+1] & 0x3F;
            uint32_t four_byte_third = s[i+2] & 0x3F;
            uint32_t four_byte_fourth = s[i+3] & 0x3f;
            uint32_t bytes = (four_byte_first << 18) | (four_byte_second << 12) | (four_byte_third << 6) | four_byte_fourth;
            report_character(bytes, 4);
            i += 4;
        } else {
            printf("<li>Unknown byte, 0x%02hhx</li>\n", s[i]);
            i++;
        }
    }
}

