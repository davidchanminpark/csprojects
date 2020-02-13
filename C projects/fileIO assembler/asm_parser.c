/***************************************************************************
 * file name   : asm_parser.c                                              *
 * author      : tjf & you                                                 *
 * description : the functions are declared in asm_parser.h                *
 *               The intention of this library is to parse a .ASM file     *
 *			        										               * 
 *                                                                         *
 ***************************************************************************
 *
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "asm_parser.h"

/* to do - implement all the functions in asm_parser.h */

/* writes text from asm file into program[][], each row ends with '\0' */
int read_asm_file (char* filename, char program [ROWS][COLS]) {
    char char_array[ROWS * COLS]; 
    int i; 
    int j;
    FILE *file = fopen(filename, "r");
    
    /* if error while opening file, print error */
    if (file == NULL) {
        printf("error2: read_asm_file() filed.\n");
        return 2; 
    }
    
    /* fill program double array */
    for (i=0; i<ROWS; i++) {
        fgets(program[i], COLS, file);
        
        /* replace next line char with 0 */
        for (j=0; j<COLS; j++) {
            if (program[i][j] == '\n') {
                program[i][j] = '\0';
            }
        }
        
        /* if last col in row is not 0, then replace it with 0 */
        if (program[i][COLS - 1] != '\0'){
            program[i][COLS - 1] = '\0';
        }
        /*bool = 0;*/
        /*printf("Row %i has contents %s\n", i, program[i]);
        printf("Row %i's first char is %i\n", i, program[i][0]);*/
        }
    return 0; 
}

int parse_instruction (char* instr, char* instr_bin_str) {
    const char space[2] = " ";
    char *token;
    /*printf("instr received is %s\n", instr);*/
    char instr_copy[COLS];
    
    /*instr_copy = malloc(COLS * sizeof(char));
    if (instr_copy == NULL) {
        return 1; 
    }*/

    strcpy (instr_copy, instr);
    /*printf("instr_copy is %s \n", instr_copy);*/
    
    /*token = malloc(COLS * sizeof(char));*/
    if (token == NULL) {
        return 1; 
    }
    
    /* get the first token */
   token = strtok(instr_copy, space);
   /*printf("first token is %s\n", token);*/
   /*free(instr_copy);*/
   
   /*printf("first token is %s\n", token);*/
   if (strcmp(token, "ADD\0") == 0) {
       /*printf("instr arg is %s", instr);*/
       parse_add(instr, instr_bin_str);
   } else if (strcmp(token, "MUL\0") == 0) {
       parse_mul(instr, instr_bin_str);
   } else if (strcmp(token, "SUB\0") == 0) {
       parse_sub(instr, instr_bin_str);
   } else if (strcmp(token, "DIV\0") == 0) {
       parse_div(instr, instr_bin_str);
   } else if (strcmp(token,"AND\0") == 0) {
       parse_and(instr, instr_bin_str);
   } else if (strcmp(token, "OR\0") == 0) {
       parse_or(instr, instr_bin_str);
   } else if (strcmp(token, "XOR\0") == 0) {
       parse_xor(instr, instr_bin_str);
   } else {
       printf("error3: parse_instruction() failed\n");
       return 3; 
   }
   /*free(token);*/
   
   return 0;
}

int parse_reg (char reg_num, char* ptr) {
    int i; 
    char *reg; 
    /*printf("the register file number is %c\n", reg_num);
    printf("the index is currently at %p \n", ptr);*/
    switch (reg_num) {
        case '0' : 
            reg = "000";
            for (i=0; i<3; i++, ptr++) {
                *ptr = reg[i];
            }
            break; 
        case '1' :
            reg = "001";
            for (i=0; i<3; i++, ptr++) {
                *ptr = reg[i]; 
            }
            break;
        case '2' :
            reg = "010";
            for (i=0; i<3; i++, ptr++) {
                *ptr = reg[i]; 
            }
            break;
        case '3' :
            reg = "011";
            for (i=0; i<3; i++, ptr++) {
                *ptr = reg[i]; 
            }
            break;
        case '4' :
            reg = "100";
            for (i=0; i<3; i++, ptr++) {
                *ptr = reg[i]; 
            }
            break; 
        case '5' :
            reg = "101";
            for (i=0; i<3; i++, ptr++) {
                *ptr = reg[i]; 
            }
            break;
        case '6' :
            reg = "110";
            for (i=0; i<3; i++, ptr++) {
                *ptr = reg[i]; 
            }
            break; 
        case '7' :
            reg = "111";
            for (i=0; i<3; i++, ptr++) {
                *ptr = reg[i]; 
            }
            break;
        default : 
            printf("error5: parse_reg() failed.");
            return 5; 
    } 
    return 0; 
}


/* parse add instruction and store in instr_bin_str */
int parse_add(char* instr, char* instr_bin_str) {
    const char space[2] = " ";
    char *token = strtok(instr, space);
    char sub_opcode = '0';
    char *opcode = "0001"; 
    int i;
    
    /* fill opcode */
    for (i=0; i<4; i++) {
        /*printf("the index is currently at %p \n", instr_bin_str);*/
        instr_bin_str[i] = opcode[i]; 
    }
    
    /* split line by space */
    printf("The token right now is %s\n", token);
    if (token == NULL) {
        printf("error4: parse_add() failed\n");
        return 4; 
    }
    
    /* advance token */
    token = strtok(NULL, space);
    printf("The token right now is %s\n", token);
    
    if (token == NULL) {
        printf("error4: parse_add() failed\n");
        return 4; 
    }
    
    /* first register */
    parse_reg (token[1], &instr_bin_str[4]);
    token = strtok(NULL, space);
    printf("The token right now is %s\n", token);
    
    if (token == NULL) {
        printf("error4: parse_add() failed\n");
        return 4; 
    }
    
    /* second register */
    parse_reg (token[1], &instr_bin_str[7]);
    
    /* instr_bin_str[10:12] is unique to instruction */
    parse_reg (sub_opcode, &instr_bin_str[10]);
    token = strtok(NULL, space);
    printf("The instr right now is %s\n", instr);
    
    if (token == NULL) {
        printf("error4: parse_add() failed\n");
        return 4; 
    }
    
    /* third register */
    parse_reg (token[1], &instr_bin_str[13]);
    
    /* fill last index with 0 */
    instr_bin_str[16] = '\0';

    return 0; 
}

int parse_mul(char* instr, char* instr_bin_str) {
    const char space[2] = " ";
    char *token = strtok(instr, space);
    char *opcode = "0001";
    char sub_opcode = '1';
    int i;
    
    if (token == NULL) {
        printf("error4: parse_mul() failed\n");
        return 4; 
    }
    
    /* fill opcode */
    for (i=0; i<4; i++) {
        /*printf("the index is currently at %p \n", instr_bin_str);*/
        instr_bin_str[i] = opcode[i]; 
    }

    /* advance token */
    token = strtok(NULL, space);
    
    if (token == NULL) {
        printf("error4: parse_mul() failed\n");
        return 4; 
    }
    
    /* first register */
    parse_reg (token[1], &instr_bin_str[4]);
    token = strtok(NULL, space);
    
    if (token == NULL) {
        printf("error4: parse_mul() failed\n");
        return 4; 
    }
    
    /* second register */
    parse_reg (token[1], &instr_bin_str[7]);
    
    /* instr_bin_str[10:12] is unique to instruction */
    parse_reg (sub_opcode, &instr_bin_str[10]);
    token = strtok(NULL, space);
    
    if (token == NULL) {
        printf("error4: parse_mul() failed\n");
        return 4; 
    }
    
    /* third register */
    parse_reg (token[1], &instr_bin_str[13]);
    
    /* fill last index with 0 */
    instr_bin_str[16] = '\0';

    return 0; 
}

int parse_sub(char* instr, char* instr_bin_str) {
    const char space[2] = " ";
    char *token = strtok(instr, space); 
    char *opcode = "0001";
    char sub_opcode = '2';
    int i;
    
    if (token == NULL) {
        printf("error4: parse_sub() failed\n");
        return 4; 
    }
    
    /* fill opcode */
    for (i=0; i<4; i++) {
        /*printf("the index is currently at %p \n", instr_bin_str);*/
        instr_bin_str[i] = opcode[i]; 
    }

    /* advance token */
    token = strtok(NULL, space);
    
    if (token == NULL) {
        printf("error4: parse_sub() failed\n");
        return 4; 
    }
    
    /* first register */
    parse_reg (token[1], &instr_bin_str[4]);
    token = strtok(NULL, space);
    
    if (token == NULL) {
        printf("error4: parse_sub() failed\n");
        return 4; 
    }
    
    /* second register */
    parse_reg (token[1], &instr_bin_str[7]);
    
    /* instr_bin_str[10:12] is unique to instruction */
    parse_reg (sub_opcode, &instr_bin_str[10]);
    token = strtok(NULL, space);
    
    if (token == NULL) {
        printf("error4: parse_sub() failed\n");
        return 4; 
    }
    
    /* third register */
    parse_reg (token[1], &instr_bin_str[13]);
    
    /* fill last index with 0 */
    instr_bin_str[16] = '\0';

    return 0;  
}

int parse_div(char* instr, char* instr_bin_str) {
    const char space[2] = " ";
    char *token = strtok(instr, space);
    char *opcode = "0001";
    char sub_opcode = '3';
    int i;
    
    if (token == NULL) {
        printf("error4: parse_div() failed\n");
        return 4; 
    }
    
    /* fill opcode */
    for (i=0; i<4; i++) {
        /*printf("the index is currently at %p \n", instr_bin_str);*/
        instr_bin_str[i] = opcode[i]; 
    }

    /* advance token */
    token = strtok(NULL, space);
    
    if (token == NULL) {
        printf("error4: parse_div() failed\n");
        return 4; 
    }
    
    /* first register */
    parse_reg (token[1], &instr_bin_str[4]);
    token = strtok(NULL, space);
    
    if (token == NULL) {
        printf("error4: parse_div() failed\n");
        return 4; 
    }
    
    /* second register */
    parse_reg (token[1], &instr_bin_str[7]);
    
    /* instr_bin_str[10:12] is unique to instruction */
    parse_reg (sub_opcode, &instr_bin_str[10]);
    token = strtok(NULL, space);
    
    if (token == NULL) {
        printf("error4: parse_div() failed\n");
        return 4; 
    }
    
    /* third register */
    parse_reg (token[1], &instr_bin_str[13]);
    
    /* fill last index with 0 */
    instr_bin_str[16] = '\0';

    return 0;  
}

int parse_and(char* instr, char* instr_bin_str) {
    const char space[2] = " ";
    char *token = strtok(instr, space); 
    char *opcode = "0101";
    char sub_opcode = '0';
    int i;
    
    if (token == NULL) {
        printf("error4: parse_and() failed\n");
        return 4; 
    }
    
    /* fill opcode */
    for (i=0; i<4; i++) {
        /*printf("the index is currently at %p \n", instr_bin_str);*/
        instr_bin_str[i] = opcode[i]; 
    }

    /* advance token */
    token = strtok(NULL, space);
    
    if (token == NULL) {
        printf("error4: parse_and() failed\n");
        return 4; 
    }
    
    /* first register */
    parse_reg (token[1], &instr_bin_str[4]);
    token = strtok(NULL, space);
    
    if (token == NULL) {
        printf("error4: parse_and() failed\n");
        return 4; 
    }
    
    /* second register */
    parse_reg (token[1], &instr_bin_str[7]);
    
    /* instr_bin_str[10:12] is unique to instruction */
    parse_reg (sub_opcode, &instr_bin_str[10]);
    token = strtok(NULL, space);
    
    if (token == NULL) {
        printf("error4: parse_and() failed\n");
        return 4; 
    }
    
    /* third register */
    parse_reg (token[1], &instr_bin_str[13]);
    
    /* fill last index with 0 */
    instr_bin_str[16] = '\0';

    return 0;  
}

int parse_or(char* instr, char* instr_bin_str) {
    const char space[2] = " ";
    char *token = strtok(instr, space);
    char *opcode = "0101";
    char sub_opcode = '2';
    int i;
    
    if (token == NULL) {
        printf("error4: parse_or() failed\n");
        return 4; 
    }
    
    /* fill opcode */
    for (i=0; i<4; i++) {
        /*printf("the index is currently at %p \n", instr_bin_str);*/
        instr_bin_str[i] = opcode[i]; 
    }

    /* advance token */
    token = strtok(NULL, space);
    
    if (token == NULL) {
        printf("error4: parse_or() failed\n");
        return 4; 
    }
    
    /* first register */
    parse_reg (token[1], &instr_bin_str[4]);
    token = strtok(NULL, space);
    
    if (token == NULL) {
        printf("error4: parse_or() failed\n");
        return 4; 
    }
    
    /* second register */
    parse_reg (token[1], &instr_bin_str[7]);
    
    /* instr_bin_str[10:12] is unique to instruction */
    parse_reg (sub_opcode, &instr_bin_str[10]);
    token = strtok(NULL, space);
    
    if (token == NULL) {
        printf("error4: parse_or() failed\n");
        return 4; 
    }
    
    /* third register */
    parse_reg (token[1], &instr_bin_str[13]);
    
    /* fill last index with 0 */
    instr_bin_str[16] = '\0';

    return 0;  
}

int parse_xor(char* instr, char* instr_bin_str) {
    const char space[2] = " ";
    char *token = strtok(instr, space);
    char *opcode = "0101";
    char sub_opcode = '3';
    int i;
    
    if (token == NULL) {
        printf("error4: parse_xor() failed\n");
        return 4; 
    }
    
    /* fill opcode */
    for (i=0; i<4; i++) {
        /*printf("the index is currently at %p \n", instr_bin_str);*/
        instr_bin_str[i] = opcode[i]; 
    }
   
    /* advance token */
    token = strtok(NULL, space);
    
    if (token == NULL) {
        printf("error4: parse_xor() failed\n");
        return 4; 
    }
    
    /* first register */
    parse_reg (token[1], &instr_bin_str[4]);
    token = strtok(NULL, space);
    
    if (token == NULL) {
        printf("error4: parse_xor() failed\n");
        return 4; 
    }
    
    /* second register */
    parse_reg (token[1], &instr_bin_str[7]);
    
    /* instr_bin_str[10:12] is unique to instruction */
    parse_reg (sub_opcode, &instr_bin_str[10]);
    token = strtok(NULL, space);
    
    if (token == NULL) {
        printf("error4: parse_xor() failed\n");
        return 4; 
    }
    
    /* third register */
    parse_reg (token[1], &instr_bin_str[13]);
    
    /* fill last index with 0 */
    instr_bin_str[16] = '\0';

    return 0;  
}

unsigned short int handle_endian(unsigned short int raw) {
    unsigned short int copy;
    char binary[17];
    int i;
    char *ptr; 
    
    
    for (i=7; i > -1; i--) {
        if (raw % 2 == 0) {
            binary[i] = '0'; 
        } else {
            binary[i] = '1';
        }
        raw /= 2; 
    }
    for (i=15; i > 7; i--) {
        if (raw % 2 == 0) {
            binary[i] = '0'; 
        } else {
            binary[i] = '1';
        }
        raw /= 2; 
    }
    binary[16] = '\0';
    
    copy = strtol(binary, &ptr, 2);
    return copy;
}

unsigned short int str_to_bin (char* instr_bin_str) {
    char *ptr; 
    long ret; 
    unsigned short int converted_ret; 
    
    /* convert from string form to binary decimal form */
    ret = strtol(instr_bin_str, &ptr, 2);
    
    /* cast long int to unsinged short int */
    converted_ret = ret; 

    if (ret == 0) {
        printf("error6: str_to_bin() failed\n");
        return 6; 
    }
    return converted_ret; 
}

int write_obj_file (char* filename, unsigned short int program_bin[ROWS]) {
    size_t file_char_len = strlen(filename);
    char new_name[file_char_len + 1];
    FILE *new_file;
    unsigned short int code = 0xCADE;
    unsigned short int new_code; 
    unsigned short int init_address = 0;
    unsigned short int count_programs;
    unsigned short int new_count_programs; 
    int i;
    int test; 
    
    
    /* change last 3 letters to "obj" */
    for (i=0; i < file_char_len - 3; i++) {
        new_name[i] = filename[i]; 
    }
    new_name[file_char_len] = '\0'; 
    new_name[file_char_len - 1] = 'j'; 
    new_name[file_char_len - 2] = 'b';
    new_name[file_char_len - 3] = 'o';
    
    new_file = fopen(new_name, "wb");
    
    if (new_file == NULL) {
        printf("error7: write_obj_file() failed");
        return 7; 
    }
    
    printf("sizeofint is %lu", sizeof(int)); 
    
    new_code = handle_endian(code); 
    
    if (fwrite(&new_code, 2, 1, new_file) != 1) {
        printf("error7: write_obj_file() failed");
        return 7; 
    }
    
    if (fwrite(&init_address, 2, 1, new_file) != 1) {
        printf("error7: write_obj_file() failed");
        return 7; 
    }

    for (i=0; i<ROWS; i++) {
        if (program_bin[i] == 0) {
            break; 
        }
        count_programs++; 
    }
    new_count_programs = handle_endian(count_programs);
    fwrite(&new_count_programs, 2, 1, new_file); 
    
    for (i=0; i < count_programs; i++) {

        fwrite(program_bin, 2, 1, new_file);
        program_bin++; 
    }

    fclose (new_file); 
    
    return 0; 
}










    
    
        
       
    
    
    
