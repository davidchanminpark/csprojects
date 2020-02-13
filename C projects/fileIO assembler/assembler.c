/***************************************************************************
 * file name   : assembler.c                                               *
 * author      : tjf & you                                                 *
 * description : This program will assemble a .ASM file into a .OBJ file   *
 *               This program will use the "asm_parser" library to achieve *
 *			     its functionality.										   * 
 *                                                                         *
 ***************************************************************************
 *
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "asm_parser.h"

int main(int argc, char** argv) {

	char* filename = NULL ;					// name of ASM file
	char  program [ROWS][COLS] ; 			// ASM file line-by-line
	char  program_bin_str [ROWS][17] ; 		// instructions converted to a binary string
	unsigned short int program_bin [ROWS] ; // instructions in binary (HEX)
    int i;
    int j; 

    if (argc > 1) {
        filename = argv[1];
        printf ("The argument supplied is %s\n", filename);
    } else {
        printf ("error1: usage: ./assembler <assembly_file.asm.\n");
    }
    
    memset(program, '\0', COLS * ROWS);
    memset(program_bin, 0, ROWS);
    
    read_asm_file (filename, program);
    
    for (i=0; i < ROWS; i++) {
        if (strlen(program[i]) != 0) {
            parse_instruction(program[i], program_bin_str[j]);

            program_bin[j] = str_to_bin(program_bin_str[j]);
            program_bin[j] = handle_endian(program_bin[j]); 

            j++;
        }
    }
    
    write_obj_file (filename, program_bin);
    
    return 0; 

}
