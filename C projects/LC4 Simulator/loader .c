/*
 * loader.c : Defines loader functions for opening and loading object files
 */

#include "loader.h"

// memory array location
unsigned short memoryAddress;

/* flip endianness of 2-byte short int */
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

/*
 * Read an object file and modify the machine state as described in the writeup
 */
int ReadObjectFile(char* filename, MachineState* CPU) {
    FILE *file = fopen(filename, "rb");
    unsigned short int header[1];
    unsigned short int address[1]; 
    unsigned short int n[1];
    unsigned short int line[1];
    unsigned short int file_index[1];
    int i;
    unsigned short int instr[1]; 
                     
                       
    if (file == NULL) {
        printf("error: file is not found");
        return 1; 
    }
    while (1) {                  
        if (fread(header, 2, 1, file) != 1) {
            break; 
        }
        header[0] = handle_endian(header[0]); 
    
        switch (header[0]) {
            /* .CODE header */
            case 0xCADE : 
                fread(address, 2, 1, file);
                memoryAddress = handle_endian(address[0]);
                fread(n, 2, 1, file);
                n[0] = handle_endian(n[0]);
                for (i=0; i < n[0]; i++) {
                    fread(instr, 2, 1, file); 
                    *instr = handle_endian(*instr);
                    CPU->memory[memoryAddress] = *instr;
                    memoryAddress++; 
                }
                break; 
            /* .DATA header */
            case 0xDADA : 
                fread(address, 2, 1, file);
                memoryAddress = handle_endian(address[0]);
                fread(n, 2, 1, file);
                *n = handle_endian(n[0]);
                for (i=0; i < n[0]; i++) {
                    fread(instr, 2, 1, file); 
                    *instr = handle_endian(*instr);
                    CPU->memory[memoryAddress] = *instr;
                    memoryAddress++; 
                }
                break; 
            /* SYMBOL header */
            case 0xC3B7 : 
                fread(address, 2, 1, file);
                    memoryAddress = handle_endian(address[0]);
                fread(n, 2, 1, file);
                n[0] = handle_endian(n[0]);
                for (i=0; i < n[0]; i++) {
                    fgetc(file); 
                }
                break; 
            /* FILENAME header */
            case 0x717E : 
                fread(n, 2, 1, file);
                *n = handle_endian(n[0]);
                for (i=0; i < n[0]; i++) {
                    fgetc(file); 
                }
                break;
            /* LINE NUMBER header */
            case 0x715E : 
                fread(address, 2, 1, file);
                memoryAddress = handle_endian(address[0]);
                fread(line, 2, 1, file);
                line[0] = handle_endian(line[0]);
                fread(file_index, 2, 1, file);
                line[0] = handle_endian(file_index[0]);
                break; 
            default : 
                printf("error: no header found, invalid obj\n");
                return 1; 
        }    
    }
    return 0;
}
        