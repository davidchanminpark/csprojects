/*
 * trace.c: location of main() to start the simulator
 */

#include "loader.h"

// Global variable defining the current state of the machine
MachineState* CPU;

int main(int argc, char** argv)
{
    FILE* output_file; 
    int i; 
    
    CPU = malloc(sizeof(MachineState));
    
    Reset(CPU);
    /*printf("test1\n");*/
    if (argc > 1) {
        output_file = fopen (argv[1], "w"); 
        for (i=2; i < argc; i++) { 
            if (ReadObjectFile(argv[i], CPU) == 1) {
                printf("error: obj file not specified/valid\n");
                return -1; 
            }
        }
    } else {
        printf ("error: no obj files found\n");
        return -1;
    }
    
    //printf("instr at 8200: %04x", CPU->memory[0x8200]);
    //printf("instr at 8201: %04x", CPU->memory[0x8201]);

     
    UpdateMachineState(CPU, output_file); 
    
    
     /*write out memory with code and data out to output_file */
    /*for (i=0; i < 65536; i++) {
        if (CPU->memory[i] != 0) {
            fprintf (output_file, "address: %05d contents: 0x%04x\n", i, CPU->memory[i]);
        }
    }*/
    
    
    fclose (output_file); 
    free(CPU); 
    return 0;
}
