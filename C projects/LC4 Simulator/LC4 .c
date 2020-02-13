/*
 * LC4.c: Defines simulator functions for executing instructions
 */

#include "LC4.h"
#include <stdio.h>
#define INSN_OP(I) ((I) >> 12)
#define INSN_11_9(I) (((I) >> 9) & 0x7)
#define INSN_8_0(I)  ((I) & 0x1FF)                
#define INSN_5_3(I) ((I >> 3) & 0x7) 
#define INSN_4_0(I) ((I) & 0x1F)          
#define INSN_8_6(I) ((I >> 6) & 0x7)
#define INSN_2_0(I) ((I) & 0x7)
#define INSN_8_7(I) ((I >> 7) & 0x3)
#define INSN_6_0(I) ((I) & 0x7F)
#define INSN_11(I) ((I >> 11) & 0x1)
#define INSN_10_0(I) ((I) & 0x7FF)
#define INSN_3_0(I) ((I) & 0xF)
#define INSN_5_4(I) ((I >> 4) & 0x3)
#define INSN_5_0(I) ((I) & 0x3F)       
#define INSN_7_0(I) ((I) & 0xFF)
#define PSR_15(I) ((I >> 15) & 0x1)

/*
 * Clear all of the control signals (set to 0)
 */
void ClearSignals(MachineState* CPU) {
    CPU->rsMux_CTL = 0;
    CPU->rdMux_CTL = 0;
    
    CPU->regFile_WE = 0;
    CPU->NZP_WE = 0;
    CPU->DATA_WE = 0;

    
    CPU->regInputVal = 0;
    CPU->NZPVal = 0;
    CPU->dmemAddr = 0;
    CPU->dmemValue = 0;
}

/*
 * Reset the machine state as Pennsim would do
 */
void Reset(MachineState* CPU) {
    int i; 
    CPU->PC = 0x8200;
    CPU->PSR = 0x8002;
    for (i=0; i < 8; i++) {
        CPU->R[i] = 0; 
    }
    for (i=0; i < 65536; i++) {
        CPU->memory[i] = 0; 
    }
    
    ClearSignals(CPU); 

}

/*
 * This function should write out the current state of the CPU to the file output.
 */
void WriteOut(MachineState* CPU, FILE* output) {
    unsigned int PC = CPU->PC; 
    unsigned short int instr = CPU->memory[PC]; 
    char instr_binary[17];
    unsigned int regFileWE = CPU->regFile_WE; 
    unsigned int register_write; 
    unsigned int register_write_value; 
    unsigned int NZP_WE = CPU->NZP_WE; 
    unsigned int NZPVal;  
    unsigned int DATA_WE = CPU->DATA_WE; 
    unsigned int dmemAddr = CPU->dmemAddr; 
    unsigned int dmemValue = CPU ->dmemValue;
    int i;
    
    //printf("write out\n");
    
    /* convert decimal instr into binary string/char array and store in instr_binary */
    instr_binary[16] = '\0'; 
    for (i=15; i > -1; i--) {
        if (instr % 2 == 0) {
            instr_binary[i] = '0'; 
        } else {
            instr_binary[i] = '1';    
        }
        instr /= 2; 
    }
    
    //printf("binary string: %s", instr_binary); 
    
    
    /* determine register to be written into */
    if (regFileWE == 0) {
        register_write = 0;
        register_write_value = 0; 
    } else {
        register_write_value = CPU->regInputVal;
        if (CPU->rdMux_CTL == 0) {
            register_write = INSN_11_9(CPU->memory[PC]); 
        } else {
            register_write = 7; 
        } 
    }
    
    /* determine NZPval depending on NZP_WE */
    if (NZP_WE == 0) {
        NZPVal = 0; 
    } else {
        NZPVal = CPU->NZPVal; 
    }
    
    fprintf (output, "%04X %s %01d %01d %04X %01d %01d %01d %04X %04X\n", 
             PC, instr_binary, regFileWE, register_write, register_write_value, 
             NZP_WE, NZPVal, DATA_WE, dmemAddr, dmemValue);

}


/*
 * This function should execute one LC4 datapath cycle.
 */
int UpdateMachineState(MachineState* CPU, FILE* output) {
    unsigned short int instr;
    unsigned int opcode;
    unsigned int rs_num; 
    unsigned int rt_num; 
    unsigned int rd_num; 
    signed int rs; 
    signed int rt;
    signed int rd; 
    unsigned short int sext_unsigned; 
    signed short int sext_signed;
    unsigned short int psr_temp;
    unsigned int psr_MSB; 
    
     
    
    //printf("pc value : %04x\n", CPU->PC);
    //printf("instr: %04x\n", instr);
    
    while (CPU->PC != 0x80FF) {
        
        psr_MSB = PSR_15(CPU->PSR);
        
        instr = CPU->memory[CPU->PC];
    
        /* set registers/psr_temp for LDR, STR, RTI, HICONST, CONST, TRAP */
        rs_num = INSN_8_6(instr); 
        rt_num = INSN_11_9(instr); 
        rd_num = INSN_11_9(instr);
    
        rs = CPU->R[rs_num]; 
        rt = CPU->R[rt_num];
        
        if (psr_MSB == 0 && (CPU->PC) >= 0x8000) {
            return 3; 
        }
        
        if (CPU->PC >= 0x2000 && (CPU->PC) <= 0x7FFF) {
            return 1; 
        }

        /* bits [15:12] of instr */
        opcode = INSN_OP(instr);
        
        //printf("opcode: %d\n", opcode);
        
        switch (opcode) {
            case 0:
                BranchOp(CPU, output);
                break; 
            case 1: 
                ArithmeticOp(CPU, output); 
                break; 
            case 2: 
                ComparativeOp(CPU, output); 
                break; 
            case 5: 
                LogicalOp(CPU, output); 
                break; 
            case 12: 
                JumpOp(CPU, output); 
                break; 
            case 4: 
                JSROp(CPU, output); 
                break; 
            case 10:
                ShiftModOp(CPU, output); 
                break;
                
            /* LDR Rd Rs IMM6 */
            case 6:
                sext_signed = INSN_5_0(instr);
                sext_signed <<= 10; 
                sext_signed >>= 10; 
                
                if (rs + sext_signed < 0x2000) {
                    printf("error 2: cannot read data from a code address\n");
                    return 2; 
                }
                
                if (psr_MSB == 0 && (rs + sext_signed) >= 0x8000) {
                    printf("error 3: cannot read data from an OS section in user mode\n"); 
                    return 3; 
                }
                
                rd = CPU->memory[rs + sext_signed];
                CPU->R[rd_num] = rd;
                
                CPU->rsMux_CTL = 0; 
                CPU->rtMux_CTL = 0; 
                CPU->rdMux_CTL = 0; 
                CPU->regFile_WE = 1;
                CPU->NZP_WE = 1; 
                CPU->DATA_WE = 0; 
                
                CPU->regInputVal = rd; 
                SetNZP(CPU, rd);
                CPU->dmemAddr = rs + sext_signed; 
                CPU->dmemValue = rd;
                
                if (psr_MSB == 0 && (CPU->PC + 1) >= 0x8000) {
                    printf("error 3: accessing OS section in user mode\n"); 
                return 3; 
                }
        
                if (CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) {
                    printf("error 1: address is in data section\n");
                return 1; 
                }
                
                WriteOut(CPU, output); 
                
                /* PC++ */
                CPU->PC++; 
                break;
                
            /* STR Rt Rs IMM6 */
            case 7:
                
                sext_signed = INSN_5_0(instr);
                sext_signed <<= 10; 
                sext_signed >>= 10; 
                
                if (rs + sext_signed < 0x2000) {
                    printf("error 2: cannot write data to a code address\n");
                    return 2; 
                }
                //printf("psr_msb: %d", psr_MSB);
                if (psr_MSB == 0 && ((rs + sext_signed) >= 0x8000)) {
                    printf("error 3: cannot write data to an OS section in user mode\n"); 
                    return 3; 
                }
                
                CPU->memory[rs + sext_signed] = rt;
                
                CPU->rsMux_CTL = 0; 
                CPU->rtMux_CTL = 1; 
                CPU->rdMux_CTL = 0; 
                CPU->regFile_WE = 0;
                CPU->NZP_WE = 0; 
                CPU->DATA_WE = 1; 
                
                CPU->NZPVal = 0; 
                CPU->regInputVal = 0; 
                CPU->dmemAddr = rs + sext_signed; 
                CPU->dmemValue = rt;
                
                if (psr_MSB == 0 && (CPU->PC + 1) >= 0x8000) {
                    printf("error 3: accessing OS section in user mode\n"); 
                return 3; 
                }
        
                if (CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) {
                    printf("error 1: address is in data section\n");
                return 1; 
                }
                
                WriteOut(CPU, output); 
                
                /* PC++ */
                CPU->PC++; 
                break;
                
            /* RTI */
            case 8:
                
                //psr_temp = CPU->PSR; 
                
                /* remove PSR[15] and set to 0 */
                CPU->PSR -= 0x8000; 
                
                CPU->rsMux_CTL = 1; 
                CPU->rtMux_CTL = 0; 
                CPU->rdMux_CTL = 0; 
                CPU->regFile_WE = 0;
                CPU->NZP_WE = 0; 
                CPU->DATA_WE = 0;
                
                CPU->NZPVal = 0; 
                CPU->regInputVal = 0; 
                CPU->dmemAddr = 0; 
                CPU->dmemValue = 0;
                
                if (psr_MSB == 0 && (CPU->R[7]) >= 0x8000) {
                    printf("error 3: accessing OS section in user mode\n"); 
                return 3; 
                }
        
                if (CPU->R[7] >= 0x2000 && (CPU->R[7]) <=0x7FFF) {
                    printf("error 1: address is in data section\n");
                return 1; 
                }
                
                WriteOut(CPU, output); 
                
                //printf("does it reach rti \n");
                
                
                /* update PC with R[7] */
                CPU->PC = CPU->R[7];
                break; 
                
            /* CONST Rd IMM9 */
            case 9: 
                
                sext_signed = INSN_8_0(instr);
                sext_signed <<= 7; 
                sext_signed >>= 7; 
                rd = sext_signed;
                //printf("const sext: %d", rd);
                CPU->R[rd_num] = rd; 
                
                CPU->rsMux_CTL = 0; 
                CPU->rtMux_CTL = 0; 
                CPU->rdMux_CTL = 0; 
                CPU->regFile_WE = 1;
                CPU->NZP_WE = 1; 
                CPU->DATA_WE = 0; 
                
                CPU->regInputVal = rd; 
                SetNZP(CPU, rd); 
                CPU->dmemAddr = 0; 
                CPU->dmemValue = 0;
                
                if (psr_MSB == 0 && (CPU->PC + 1) >= 0x8000) {
                    printf("error 3: accessing OS section in user mode\n"); 
                return 3; 
                }
                //printf("does it reach here \n");
        
                if ((CPU->PC + 1) >= 0x2000 && (CPU->PC + 1) <=0x7FFF) {
                    printf("error 1 in const: address is in data section\n");
                return 1; 
                }
                
                WriteOut(CPU, output); 
                
                /* PC++ */
                CPU->PC++; 
                break;
                
            /* HICONST Rd, UIMM8 */
            case 13:
                
                sext_unsigned = INSN_7_0(instr);
                rd = CPU->R[rd_num]; 
                rd = ((rd & 0xFF) | (sext_unsigned << 8)); 
                CPU->R[rd_num] = rd; 
                
                CPU->rsMux_CTL = 2; 
                CPU->rtMux_CTL = 0; 
                CPU->rdMux_CTL = 0; 
                CPU->regFile_WE = 1;
                CPU->NZP_WE = 1; 
                CPU->DATA_WE = 0; 
                
                CPU->regInputVal = rd; 
                SetNZP(CPU, rd); 
                CPU->dmemAddr = 0; 
                CPU->dmemValue = 0;
                
                if (psr_MSB == 0 && (CPU->PC + 1) >= 0x8000) {
                    printf("error 3: accessing OS section in user mode\n"); 
                return 3; 
                }
        
                if (CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) {
                    printf("error 1: address is in data section\n");
                return 1; 
                }
                
                WriteOut(CPU, output); 
                
                /* PC++ */
                CPU->PC++; 
                break;
                
            /* TRAP UIMM8 */
            case 15: 
                sext_unsigned = INSN_7_0(instr);
                //printf("trap sext: %x", sext_unsigned);
                CPU->R[7] = (CPU->PC + 1);
                CPU->PSR += 0x8000; 
                
                CPU->rsMux_CTL = 0; 
                CPU->rtMux_CTL = 0; 
                CPU->rdMux_CTL = 1; 
                CPU->regFile_WE = 1;
                CPU->NZP_WE = 1; 
                CPU->DATA_WE = 0; 
            
                CPU->regInputVal = (CPU->PC + 1); 
                /* assign NZPVal based on PC + 1 */
                SetNZP(CPU, CPU->PC + 1); 
            
                CPU->dmemAddr = 0; 
                CPU->dmemValue = 0;
        
                if ((0x8000 | sext_unsigned) >= 0x2000 && (0x8000 | sext_unsigned) <=0x7FFF) {
                    printf("error 1: address is in data section\n");
                return 1; 
                }
                
                WriteOut(CPU, output);  
                
                /* update PC */
                //printf("pc: %x", (0x8000 | sext_unsigned)); 
                CPU->PC = (0x8000 | sext_unsigned);
                break; 

            default: 
                printf("error 4: invalid opcode\n");
                return 4;
            }
    
    }
    return 0;
}


//////////////// PARSING HELPER FUNCTIONS ///////////////////////////



/*
 * Parses rest of branch operation and updates state of machine.
 */
void BranchOp(MachineState* CPU, FILE* output) {
    unsigned int subopcode;
    signed short int sext; 
    unsigned short int instr;
    unsigned int psr_MSB; 
    
    instr = CPU->memory[CPU->PC]; 
    
    /* bits[11:9] of instr */
    subopcode = INSN_11_9(instr);
    
    /* bits[8:0] of instr */
    sext = INSN_8_0(instr);
    sext <<= 7; 
    sext >>= 7; 
    
    psr_MSB = PSR_15(CPU->PSR); 
    
    /* 1. update controls and output values
     * 2. write out to output file
     * 3. update PC */
    switch (subopcode) {
        /*NOP*/
        case 0: 
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 0;
            CPU->NZP_WE = 0; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = 0; 

            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0;
            
            if (psr_MSB == 0 && (CPU->PC + 1) >= 0x8000) {
                printf("error 3: accessing OS section in user mode\n"); 
            } else if (CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) {
                printf("error 1 in nop: address is in data section\n");
            } else {
                WriteOut(CPU, output); 
            }
            CPU->PC++;
            break; 
            
        /*BRn IMM9*/
        case 4: 
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 0;
            CPU->NZP_WE = 0; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = 0; 

            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0; 
            
            if (psr_MSB == 0 && ((CPU->PC + 1) >= 0x8000 || (CPU->PC + sext + 1) >= 0x8000 )) {
                printf("error 3: accessing OS section in user mode\n");  
            }
        
            else if ((CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) || 
                ((CPU->PC + sext + 1) >= 0x2000 && (CPU->PC + sext + 1) <= 0x7FFF)) {
                printf("error 1: address is in data section\n");
            } else {
                WriteOut(CPU, output);
            }

            /* if NZPVal is neg then PC + sext + 1 else PC + 1 */
            if (CPU->NZPVal == 4) {
                CPU->PC += (sext + 1);  
            } else {
                CPU->PC++; 
            }
            break; 
            
        /*BRnz IMM9*/
        case 6: 
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 0;
            CPU->NZP_WE = 0; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = 0; 
 
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0; 
            
            if (psr_MSB == 0 && ((CPU->PC + 1) >= 0x8000 || (CPU->PC + sext + 1) >= 0x8000 )) {
                printf("error 3: accessing OS section in user mode\n"); 
            }
        
            else if ((CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) || 
                ((CPU->PC + sext + 1) >= 0x2000 && (CPU->PC + sext + 1) <= 0x7FFF)) {
                printf("error 1: address is in data section\n");
            } else {
                WriteOut(CPU, output); 
            }

            /* if NZPVal is neg or zero then PC + sext + 1 else PC + 1 */
            if (CPU->NZPVal == 4 || CPU->NZPVal == 2) {
                CPU->PC += (sext + 1);  
            } else {
                CPU->PC++; 
            }
            break;
            
        /*BRnp IMM9*/
        case 5: 
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 0;
            CPU->NZP_WE = 0; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = 0; 
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0;
            
            if (psr_MSB == 0 && ((CPU->PC + 1) >= 0x8000 || (CPU->PC + sext + 1) >= 0x8000 )) {
                printf("error 3: accessing OS section in user mode\n");  
            }
        
            else if ((CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) || 
                ((CPU->PC + sext + 1) >= 0x2000 && (CPU->PC + sext + 1) <= 0x7FFF)) {
                printf("error 1: address is in data section\n"); 
            } else {
                 WriteOut(CPU, output); 
            }

            /* if NZPVal is neg or pos then PC + sext + 1 else PC + 1 */
            if (CPU->NZPVal == 4 || CPU->NZPVal == 1) {
                CPU->PC += (sext + 1);  
            } else {
                CPU->PC++; 
            }
            break;
            
        /*BRz IMM9*/
        case 2: 
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 0;
            CPU->NZP_WE = 0; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = 0; 
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0;
            
            if (psr_MSB == 0 && ((CPU->PC + 1) >= 0x8000 || (CPU->PC + sext + 1) >= 0x8000 )) {
                printf("error 3: accessing OS section in user mode\n"); 
            }
        
            else if ((CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) || 
                ((CPU->PC + sext + 1) >= 0x2000 && (CPU->PC + sext + 1) <= 0x7FFF)) {
                printf("error 1: address is in data section\n");
            } else {
                WriteOut(CPU, output); 
            }

            /* if NZPVal is zero then PC + sext + 1 else PC + 1 */
            if (CPU->NZPVal == 2) {
                CPU->PC += (sext + 1);  
            } else {
                CPU->PC++; 
            }
            break;
            
        /*BRzp IMM9*/
        case 3: 
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 0;
            CPU->NZP_WE = 0; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = 0; 
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0; 
            
            if (psr_MSB == 0 && ((CPU->PC + 1) >= 0x8000 || (CPU->PC + sext + 1) >= 0x8000 )) {
                printf("error 3: accessing OS section in user mode\n"); 
            }
        
            else if ((CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) || 
                ((CPU->PC + sext + 1) >= 0x2000 && (CPU->PC + sext + 1) <= 0x7FFF)) {
                printf("error 1: address is in data section\n");
            } else {
                WriteOut(CPU, output);
            }

            /* if NZPVal is zero or pos then PC + sext + 1 else PC + 1 */
            if (CPU->NZPVal == 2 || CPU->NZPVal == 1) {
                CPU->PC += (sext + 1);  
            } else {
                CPU->PC++; 
            }
            break;
            
        /*BRp IMM9*/
        case 1: 
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 0;
            CPU->NZP_WE = 0; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = 0; 
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0;
            
            if (psr_MSB == 0 && ((CPU->PC + 1) >= 0x8000 || (CPU->PC + sext + 1) >= 0x8000 )) {
                printf("error 3: accessing OS section in user mode\n"); 
            }
        
            else if ((CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) || 
                ((CPU->PC + sext + 1) >= 0x2000 && (CPU->PC + sext + 1) <= 0x7FFF)) {
                printf("error 1: address is in data section\n");
            } else {
                WriteOut(CPU, output);
            }

            /* if NZPVal is pos then PC + sext + 1 else PC + 1 */
            if (CPU->NZPVal == 1) {
                CPU->PC += (sext + 1);  
            } else {
                CPU->PC++; 
            }
            break;
            
        /*BRnzp IMM9*/
        case 7: 
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 0;
            CPU->NZP_WE = 0; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = 0; 
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0; 
            
            if (psr_MSB == 0 && ((CPU->PC + 1) >= 0x8000 || (CPU->PC + sext + 1) >= 0x8000 )) {
                printf("error 3: accessing OS section in user mode\n"); 
            }
        
            else if ((CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) || 
                ((CPU->PC + sext + 1) >= 0x2000 && (CPU->PC + sext + 1) <= 0x7FFF)) {
                printf("error 1: address is in data section\n");
            } else {
                WriteOut(CPU, output); 
            }

            /* PC + sext + 1*/
            CPU->PC += (sext + 1); 
            break;
    }
}

/*
 * Parses rest of arithmetic operation and prints out.
 */
void ArithmeticOp(MachineState* CPU, FILE* output) {
    unsigned int subopcode;
    signed short int sext; 
    unsigned short int instr;
    unsigned int rs_num; 
    unsigned int rt_num;
    unsigned int rd_num; 
    signed int rs; 
    signed int rt;
    signed int rd;
    unsigned int psr_MSB; 
    
    psr_MSB = PSR_15(CPU->PSR); 
    
    instr = CPU->memory[CPU->PC]; 
    
    /* bits[5:3] of instr */
    subopcode = INSN_5_3(instr);
    
    /* bits[4:0] of instr */
    sext = INSN_4_0(instr);
    sext <<= 11; 
    //printf("sext at add: %d", sext); 
    sext >>= 11; 
    
    
    /* extract rs, rt, rd register numbers */
    rs_num = INSN_8_6(instr); 
    rt_num = INSN_2_0(instr); 
    rd_num = INSN_11_9(instr); 
    
    rs = CPU->R[rs_num]; 
    rt = CPU->R[rt_num];
    
    /* 1. update controls and output values
     * 2. write out to output file
     * 3. update PC */
    switch (subopcode) {
        /*ADD Rd Rs Rt*/
        case 0: 
            
            /*operation*/
            rd = rs + rt; 
            CPU->R[rd_num] = rd; 
            
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 1;
            CPU->NZP_WE = 1; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = rd;
            
            /*set nzpval 4 if neg, 2 if zero, 1 if pos and update PSR[2:0]*/
            SetNZP(CPU, rd); 
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0;
            
            if (psr_MSB == 0 && (CPU->PC + 1) >= 0x8000) {
                printf("error 3: accessing OS section in user mode\n"); 
            }
        
            else if (CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) {
                printf("error 1: address is in data section\n");
            } else {
                WriteOut(CPU, output);
            }
            CPU->PC++;
            break; 
            
        /*MUL Rd Rs Rt*/
        case 1: 
            
            /*operation*/
            rd = rs * rt; 
            CPU->R[rd_num] = rd; 
            
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 1;
            CPU->NZP_WE = 1; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = rd;
            
            /*set nzpval 4 if neg, 2 if zero, 1 if pos and update PSR[2:0]*/
            SetNZP(CPU, rd); 
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0;
            
            if (psr_MSB == 0 && (CPU->PC + 1) >= 0x8000) {
                printf("error 3: accessing OS section in user mode\n");  
            }
        
            else if (CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) {
                printf("error 1: address is in data section\n"); 
            } else {
                WriteOut(CPU, output);
            }

            CPU->PC++;
            break;
            
        /*SUB Rd Rs Rt*/
        case 2: 
            
            /*operation*/
            rd = rs - rt; 
            CPU->R[rd_num] = rd; 
            
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 1;
            CPU->NZP_WE = 1; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = rd;
            
            /*set nzpval 4 if neg, 2 if zero, 1 if pos and update PSR[2:0]*/
            SetNZP(CPU, rd);
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0;
            
            if (psr_MSB == 0 && (CPU->PC + 1) >= 0x8000) {
                printf("error 3: accessing OS section in user mode\n");  
            }
        
            else if (CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) {
                printf("error 1: address is in data section\n");
            } else {
               WriteOut(CPU, output); 
            }
            CPU->PC++;
            break; 
            
        /*DIV Rd Rs Rt*/
        case 3: 
            
            /*operation*/
            rd = rs / rt; 
            CPU->R[rd_num] = rd; 
            
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 1;
            CPU->NZP_WE = 1; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = rd;
            
            /*set nzpval 4 if neg, 2 if zero, 1 if pos and update PSR[2:0]*/
            SetNZP(CPU, rd);
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0;
            
            if (psr_MSB == 0 && (CPU->PC + 1) >= 0x8000) {
                printf("error 3: accessing OS section in user mode\n");  
            }
        
            else if (CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) {
                printf("error 1: address is in data section\n");
            } else {
               WriteOut(CPU, output); 
            }
            
            CPU->PC++;
            break;
            
        /*ADD Rd Rs IMM5*/
        default: 
            
            /*operation*/
            rd = rs + sext; 
            CPU->R[rd_num] = rd; 
            
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 1;
            CPU->NZP_WE = 1; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = rd;
            
            /*set nzpval 4 if neg, 2 if zero, 1 if pos and update PSR[2:0]*/
            SetNZP(CPU, rd);
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0;
            
            if (psr_MSB == 0 && (CPU->PC + 1) >= 0x8000) {
                printf("error 3: accessing OS section in user mode\n"); 
            }
        
            else if (CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) {
                printf("error 1: address is in data section\n");
            } else {
                WriteOut(CPU, output);
            }
            CPU->PC++;
    }
}

/*
 * Parses rest of comparative operation and prints out.
 */
void ComparativeOp(MachineState* CPU, FILE* output) {
    unsigned int subopcode;
    signed short int sext_signed;
    unsigned short int sext_unsigned;
    unsigned short int instr;
    unsigned int rs_num; 
    unsigned int rt_num;
    signed int rs_signed; 
    signed int rt_signed;
    unsigned int rs_unsigned; 
    unsigned int rt_unsigned;
    unsigned short int psr_temp;
    unsigned int psr_MSB; 
    
    psr_MSB = PSR_15(CPU->PSR); 
    
    instr = CPU->memory[CPU->PC]; 
    
    /* bits[8:7] of instr */
    subopcode = INSN_8_7(instr);
    
    /* bits[6:0] of instr */
    sext_signed = INSN_6_0(instr);
    sext_signed <<= 9; 
    sext_signed >>= 9; 
    sext_unsigned = INSN_6_0(instr); 
    
    /* extract rs, rt register numbers */
    rs_num = INSN_11_9(instr); 
    rt_num = INSN_2_0(instr); 
    
    rs_signed = CPU->R[rs_num]; 
    rt_signed = CPU->R[rt_num];
    
    rs_unsigned = CPU->R[rs_num];
    rt_unsigned = CPU->R[rt_num];
    
    /* 1. update controls and output values
     * 2. write out to output file
     * 3. update PC */
    switch (subopcode) {
        /*CMP Rs Rt*/
        case 0: 
            
            CPU->rsMux_CTL = 2; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 0;
            CPU->NZP_WE = 1; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = 0; 
            
            /*set nzpval 4 if neg, 2 if zero, 1 if pos and update PSR[2:0]*/
            if (rs_signed < rt_signed) {
                CPU->NZPVal = 4;
                psr_temp = CPU->PSR; 
                /* preserve PSR[15] and clear bits[3:0]*/
                psr_temp = psr_temp >> 3; 
                psr_temp = psr_temp << 3;
                /* add 100 to the last 3 bits */
                CPU->PSR = psr_temp + 4; 
            } else if (rs_signed == rt_signed) {
                CPU->NZPVal = 2;
                psr_temp = CPU->PSR; 
                /* preserve PSR[15] and clear bits[3:0]*/
                psr_temp = psr_temp >> 3; 
                psr_temp = psr_temp << 3;
                /* add 010 to the last 3 bits */
                CPU->PSR = psr_temp + 2; 
            } else {
                CPU->NZPVal = 1;
                psr_temp = CPU->PSR; 
                /* preserve PSR[15] and clear bits[3:0]*/
                psr_temp = psr_temp >> 3; 
                psr_temp = psr_temp << 3;
                /* add 001 to the last 3 bits */
                CPU->PSR = psr_temp + 1; 
            }
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0;
            
            if (psr_MSB == 0 && (CPU->PC + 1) >= 0x8000) {
                printf("error 3: accessing OS section in user mode\n"); 
            }
        
            else if (CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) {
                printf("error 1: address is in data section\n");
            } else {
                WriteOut(CPU, output);
            }
            CPU->PC++;
            break; 
            
        /*CMPU Rs Rt*/
        case 1: 
            
            CPU->rsMux_CTL = 2; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 0;
            CPU->NZP_WE = 1; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = 0; 
            
            /*set nzpval 4 if neg, 2 if zero, 1 if pos and update PSR[2:0]*/
            if (rs_unsigned < rt_unsigned) {
                CPU->NZPVal = 4;
            } else if (rs_unsigned == rt_unsigned) {
                CPU->NZPVal = 2;
            } else {
                CPU->NZPVal = 1;
            }
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0;
            
            if (psr_MSB == 0 && (CPU->PC + 1) >= 0x8000) {
                printf("error 3: accessing OS section in user mode\n"); 
            }
        
            else if (CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) {
                printf("error 1: address is in data section\n");
            } else {
                WriteOut(CPU, output);
            }
            CPU->PC++;
            break;
            
        /*CMPI Rs IMM7*/
        case 2: 
            
            CPU->rsMux_CTL = 2; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 0;
            CPU->NZP_WE = 1; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = 0; 
            
            /*set nzpval 4 if neg, 2 if zero, 1 if pos and update PSR[2:0]*/
            if (rs_signed < sext_signed) {
                CPU->NZPVal = 4;
            } else if (rs_signed == sext_signed) {
                CPU->NZPVal = 2;
            } else {
                CPU->NZPVal = 1;
            }
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0;
            
            if (psr_MSB == 0 && (CPU->PC + 1) >= 0x8000) {
                printf("error 3: accessing OS section in user mode\n");  
            }
        
            else if (CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) {
                printf("error 1: address is in data section\n");
            } else {
                 WriteOut(CPU, output);
            }
            CPU->PC++;
            break;
            
        /*CMPIU Rs UIMM7*/
        case 3: 

            CPU->rsMux_CTL = 2; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 0;
            CPU->NZP_WE = 1; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = 0; 
            
            /*set nzpval 4 if neg, 2 if zero, 1 if pos and update PSR[2:0]*/
            if (rs_unsigned < sext_unsigned) {
                CPU->NZPVal = 4;
            } else if (rs_unsigned == sext_unsigned) {
                CPU->NZPVal = 2;
            } else {
                CPU->NZPVal = 1;
            }
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0;
            
            if (psr_MSB == 0 && (CPU->PC + 1) >= 0x8000) {
                printf("error 3: accessing OS section in user mode\n"); 
            } 
        
            else if (CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) {
                printf("error 1: address is in data section\n");
            } else {
                 WriteOut(CPU, output);
            }
            CPU->PC++;
            break;
    }
}

/*
 * Parses rest of logical operation and prints out.
 */
void LogicalOp(MachineState* CPU, FILE* output) {
    unsigned int subopcode;
    signed short int sext; 
    unsigned short int instr;
    unsigned int rs_num; 
    unsigned int rt_num;
    unsigned int rd_num; 
    signed int rs; 
    signed int rt;
    signed int rd;
    unsigned int psr_MSB; 
    
    psr_MSB = PSR_15(CPU->PSR); 
    
    instr = CPU->memory[CPU->PC]; 
    
    /* bits[5:3] of instr */
    subopcode = INSN_5_3(instr);
    
    /* bits[4:0] of instr */
    sext = INSN_4_0(instr);
    sext <<= 11; 
    sext >>= 11; 
    
    /* extract rs, rt, rd register numbers */
    rs_num = INSN_8_6(instr); 
    rt_num = INSN_2_0(instr); 
    rd_num = INSN_11_9(instr); 
    
    rs = CPU->R[rs_num]; 
    rt = CPU->R[rt_num];
    
    /* 1. update controls and output values
     * 2. write out to output file
     * 3. update PC */
    switch (subopcode) {
        /*AND Rd Rs Rt*/    
        case 0: 
            
            /*operation*/
            rd = rs & rt; 
            CPU->R[rd_num] = rd; 
            
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 1;
            CPU->NZP_WE = 1; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = rd;
            
            /*set nzpval 4 if neg, 2 if zero, 1 if pos and update PSR[2:0]*/
            SetNZP(CPU, rd); 
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0; 
            
            if (psr_MSB == 0 && (CPU->PC + 1) >= 0x8000) {
                printf("error 3: accessing OS section in user mode\n"); 
            }
        
            else if (CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) {
                printf("error 1: address is in data section\n");
            } else {
                WriteOut(CPU, output);
            }
            CPU->PC++;
            break; 
            
        /*NOT Rd Rs*/    
        case 1: 
            
            /*operation*/
            rd = 0 - rs; 
            CPU->R[rd_num] = rd; 
            
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 1;
            CPU->NZP_WE = 1; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = rd;
            
            /*set nzpval 4 if neg, 2 if zero, 1 if pos and update PSR[2:0]*/
            SetNZP(CPU, rd);
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0;
            
            if (psr_MSB == 0 && (CPU->PC + 1) >= 0x8000) {
                printf("error 3: accessing OS section in user mode\n"); 
            }
        
            else if (CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) {
                printf("error 1: address is in data section\n"); 
            } else {
                WriteOut(CPU, output);
            }
            
            CPU->PC++;
            break; 
            
        /*OR Rd Rs Rt*/    
        case 2: 
            
            /*operation*/
            rd = rs | rt; 
            CPU->R[rd_num] = rd; 
            
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 1;
            CPU->NZP_WE = 1; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = rd;
            
            /*set nzpval 4 if neg, 2 if zero, 1 if pos and update PSR[2:0]*/
            SetNZP(CPU, rd);
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0; 
            
            if (psr_MSB == 0 && (CPU->PC + 1) >= 0x8000) {
                printf("error 3: accessing OS section in user mode\n"); 
            }
        
            else if (CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) {
                printf("error 1: address is in data section\n");
            } else {
                WriteOut(CPU, output);
            }
            CPU->PC++;
            break;
            
        /*XOR Rd Rs Rt*/    
        case 3: 
            
            /*operation*/
            rd = rs ^ rt; 
            CPU->R[rd_num] = rd; 
            
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 1;
            CPU->NZP_WE = 1; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = rd;
            
            /*set nzpval 4 if neg, 2 if zero, 1 if pos and update PSR[2:0]*/
            SetNZP(CPU, rd);
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0;
            
            if (psr_MSB == 0 && (CPU->PC + 1) >= 0x8000) {
                printf("error 3: accessing OS section in user mode\n");  
            }
        
            else if (CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) {
                printf("error 1: address is in data section\n");

            } else {
                 WriteOut(CPU, output);
            }
            CPU->PC++;
            break;
            
        /*AND Rd Rs IMM6*/
        default: 
            
            /*operation*/
            rd = rs & sext; 
            CPU->R[rd_num] = rd; 
            
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 1;
            CPU->NZP_WE = 1; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = rd;
            
            /*set nzpval 4 if neg, 2 if zero, 1 if pos and update PSR[2:0]*/
            SetNZP(CPU, rd);
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0;
            
            if (psr_MSB == 0 && (CPU->PC + 1) >= 0x8000) {
                printf("error 3: accessing OS section in user mode\n"); 

            }
        
            else if (CPU->PC + 1 >= 0x2000 && (CPU->PC + 1) <=0x7FFF) {
                printf("error 1: address is in data section\n");
            } else {
                 WriteOut(CPU, output);
            }
            CPU->PC++;
    }
}

/*
 * Parses rest of jump operation and prints out.
 */
void JumpOp(MachineState* CPU, FILE* output) {
    unsigned int subopcode;
    signed short int sext;
    unsigned short int instr;
    unsigned int rs_num;  
    unsigned int rs; 
    unsigned int psr_MSB; 
    
    psr_MSB = PSR_15(CPU->PSR); 
    
    instr = CPU->memory[CPU->PC]; 
    
    /* bit[11] of instr */
    subopcode = INSN_11(instr);
    
    /* bits[10:0] of instr */
    sext = INSN_10_0(instr);
    sext <<= 5; 
    sext >>= 5; 
    
    /* extract rs register number */
    rs_num = INSN_8_6(instr);  
    
    rs = CPU->R[rs_num]; 
    
    /* 1. update controls and output values
     * 2. write out to output file
     * 3. update PC */
    /* JMPR Rs */
    if (subopcode == 0) {
        CPU->rsMux_CTL = 0; 
        CPU->rtMux_CTL = 0; 
        CPU->rdMux_CTL = 0; 
        CPU->regFile_WE = 0;
        CPU->NZP_WE = 0; 
        CPU->DATA_WE = 0; 
            
        CPU->regInputVal = 0; 
        CPU->NZPVal = 0; 
        CPU->dmemAddr = 0; 
        CPU->dmemValue = 0; 
        
        if (psr_MSB == 0 && rs >= 0x8000) {
            printf("error 3: accessing OS section in user mode\n"); 
        }
        
        else if (rs >= 0x2000 && rs <= 0x7FFF) {
            printf("error 1: address is in data section\n");
     
        } else {
            WriteOut(CPU, output); 
        }
            
        
        
        /* update PC */
        CPU->PC = rs;
        
    /* JMP IMM11 */
    } else {
        CPU->rsMux_CTL = 0; 
        CPU->rtMux_CTL = 0; 
        CPU->rdMux_CTL = 0; 
        CPU->regFile_WE = 0;
        CPU->NZP_WE = 0; 
        CPU->DATA_WE = 0; 
            
        CPU->regInputVal = 0; 
        CPU->NZPVal = 0;    
        CPU->dmemAddr = 0; 
        CPU->dmemValue = 0; 

        if (psr_MSB == 0 && (CPU->PC + 1 + sext) >= 0x8000) {
            printf("error 3: accessing OS section in user mode\n"); 

        }
        
        else if ((CPU->PC + 1 + sext) >= 0x2000 && (CPU->PC + 1 + sext) <=0x7FFF) {
            printf("error 1: address is in data section\n");
            
        } else {
            WriteOut(CPU, output);
        }
        
        /* update PC */
        CPU->PC += (1 + sext); 
    }
}

/*
 * Parses rest of JSR operation and prints out.
 */
void JSROp(MachineState* CPU, FILE* output) {
    unsigned int subopcode;
    signed short int sext;
    unsigned short int instr;
    unsigned int rs_num;  
    unsigned int rs;
    unsigned int psr_MSB; 
    
    psr_MSB = PSR_15(CPU->PSR); 
    
    instr = CPU->memory[CPU->PC]; 
    
    /* bit[11] of instr */
    subopcode = INSN_11(instr);
    
    /* bits[10:0] of instr */
    sext = INSN_10_0(instr);
    sext <<= 5; 
    sext >>= 5; 
    
    /* extract rs register number */
    rs_num = INSN_8_6(instr);  
    
    rs = CPU->R[rs_num]; 
    
    /* 1. update controls and output values
     * 2. write out to output file
     * 3. update PC */
    /* JSR IMM11 */
    if (subopcode == 1) {
        
        CPU->R[7] = (CPU->PC + 1); 
        
        CPU->rsMux_CTL = 0; 
        CPU->rtMux_CTL = 0; 
        CPU->rdMux_CTL = 1; 
        CPU->regFile_WE = 1;
        CPU->NZP_WE = 1; 
        CPU->DATA_WE = 0; 
            
        CPU->regInputVal = (CPU->PC + 1); 
        
        /* assign NZPVal based on PC + 1 */
        SetNZP(CPU, CPU->PC +1); 
        
        CPU->dmemAddr = 0; 
        CPU->dmemValue = 0; 
        
        
        if (psr_MSB == 0 && (((CPU->PC) & 0x8000) | (sext << 4)) >= 0x8000) {
            printf("error 3: accessing OS section in user mode\n"); 
 
        }
        
        else if ((((CPU->PC) & 0x8000) | (sext << 4)) >= 0x2000 
            && (((CPU->PC) & 0x8000) | (sext << 4)) <=0x7FFF) {
            printf("error 1: address is in data section\n");
 
        } else {
            WriteOut(CPU, output); 
        }
            
        
        
        /* update PC */
        CPU->PC = (((CPU->PC) & 0x8000) | (sext << 4));
    /* JSRR Rs */
    } else {
        CPU->R[7] = (CPU->PC + 1); 
        
        CPU->rsMux_CTL = 0; 
        CPU->rtMux_CTL = 0; 
        CPU->rdMux_CTL = 1; 
        CPU->regFile_WE = 1;
        CPU->NZP_WE = 1; 
        CPU->DATA_WE = 0; 
            
        CPU->regInputVal = (CPU->PC + 1); 
        
        /* assign NZPVal based on PC + 1 */
        SetNZP(CPU, CPU->PC + 1); 
        
        CPU->dmemAddr = 0; 
        CPU->dmemValue = 0;
        
        
        if (psr_MSB == 0 && rs >= 0x8000) {
            printf("error 3: accessing OS section in user mode\n"); 
 
        }
        
        else if (rs >= 0x2000 && rs <=0x7FFF) {
            printf("error 1: address is in data section\n");
   
        } else {
            WriteOut(CPU, output); 
        }
            
        
        
        /* update PC */
        CPU->PC = rs; 
    }
}

/*
 * Parses rest of shift/mod operations and prints out.
 */
void ShiftModOp(MachineState* CPU, FILE* output) {
    unsigned int subopcode;
    unsigned short int sext;
    unsigned short int instr;
    unsigned int rs_num;
    unsigned int rt_num; 
    unsigned int rd_num; 
    signed int rs;
    signed int rt;
    unsigned int rd_unsigned; 
    signed int rd_signed;
    unsigned int psr_MSB; 
    
    psr_MSB = PSR_15(CPU->PSR); 
    
    instr = CPU->memory[CPU->PC]; 
    
    /* bit[5:4] of instr */
    subopcode = INSN_5_4(instr);
    
    /* bits[3:0] of instr */
    sext = INSN_3_0(instr); 
    
    /* extract rs, rt, rd register number */
    rs_num = INSN_8_6(instr);
    rt_num = INSN_2_0(instr); 
    rd_num = INSN_11_9(instr); 
    
    rs = CPU->R[rs_num];
    rt = CPU->R[rt_num]; 
    
    /* 1. update controls and output values
     * 2. write out to output file
     * 3. update PC */
    switch (subopcode) {
            
        /* SLL Rd Rs UIMM4 */
        case 0: 
            
            /*operation*/
            rd_unsigned = rs << sext; 
            CPU->R[rd_num] = rd_unsigned; 
            
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 1;
            CPU->NZP_WE = 1; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = rd_unsigned;
            
            /*set nzpval 4 if neg, 2 if zero, 1 if pos and update PSR[2:0]*/
            SetNZP(CPU, rd_unsigned); 
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0; 
            
            if (psr_MSB == 0 && CPU->PC + 1 >= 0x8000) {
                printf("error 3: accessing OS section in user mode\n"); 
                
            }
        
            else if (CPU->PC + 1 >= 0x2000 && CPU->PC + 1 <=0x7FFF) {
                printf("error 1: address is in data section\n");
                 
            } else {
                WriteOut(CPU, output);
            }
            
            
            
            CPU->PC++;
            break;
         
        /* SRA Rd Rs UIMM4 */
        case 1: 
            
            /*operation*/
            rd_signed = rs >> sext; 
            CPU->R[rd_num] = rd_signed; 
            
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 1;
            CPU->NZP_WE = 1; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = rd_signed;
            
            /*set nzpval 4 if neg, 2 if zero, 1 if pos and update PSR[2:0]*/
            SetNZP(CPU, rd_signed); 
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0;
            
            if (psr_MSB == 0 && CPU->PC + 1 >= 0x8000) {
                printf("error 3: accessing OS section in user mode\n"); 
                
            }
        
            else if (CPU->PC + 1 >= 0x2000 && CPU->PC + 1 <=0x7FFF) {
                printf("error 1: address is in data section\n");
                 
            } else {
                WriteOut(CPU, output);
            }
            CPU->PC++;
            break;
        
        /* SRL Rd Rs UIMM4 */
        case 2:
            
            /*operation*/
            rd_unsigned = rs >> sext; 
            CPU->R[rd_num] = rd_unsigned; 
            
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 1;
            CPU->NZP_WE = 1; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = rd_unsigned;
            
            /*set nzpval 4 if neg, 2 if zero, 1 if pos and update PSR[2:0]*/
            SetNZP(CPU, rd_unsigned); 
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0; 
            
            if (psr_MSB == 0 && CPU->PC + 1 >= 0x8000) {
                printf("error 3: accessing OS section in user mode\n"); 
                
            }
        
            else if (CPU->PC + 1 >= 0x2000 && CPU->PC + 1 <=0x7FFF) {
                printf("error 1: address is in data section\n");
                 
            } else {
                 WriteOut(CPU, output);
            }
            
           
            
            CPU->PC++;
            break;
            
        /* MOD Rd Rs Rt */
        case 3: 
            
            /*operation*/
            rd_signed = rs % rt; 
            CPU->R[rd_num] = rd_signed; 
            
            CPU->rsMux_CTL = 0; 
            CPU->rtMux_CTL = 0; 
            CPU->rdMux_CTL = 0; 
            CPU->regFile_WE = 1;
            CPU->NZP_WE = 1; 
            CPU->DATA_WE = 0; 
            
            CPU->regInputVal = rd_signed;
            
            /*set nzpval 4 if neg, 2 if zero, 1 if pos and update PSR[2:0]*/
            SetNZP(CPU, rd_signed); 
            
            CPU->dmemAddr = 0; 
            CPU->dmemValue = 0;
            
            if (psr_MSB == 0 && CPU->PC + 1 >= 0x8000) {
                printf("error 3: accessing OS section in user mode\n"); 
              
            }
        
            else if (CPU->PC + 1 >= 0x2000 && CPU->PC + 1 <=0x7FFF) {
                printf("error 1: address is in data section\n");
                 
            } else {
                WriteOut(CPU, output);
            }
            
            
            
            CPU->PC++;
            break;
    }
}

/*
 * Set the NZP bits in the PSR.
 */
void SetNZP(MachineState* CPU, short result) {
    unsigned short int psr_temp;
    int MSB; 
    
    /** extract the MSB of result to check if it's negative */
    MSB = PSR_15(result); 
    
    if (MSB == 1) {
        CPU->NZPVal = 4;
        psr_temp = CPU->PSR; 
        /* preserve PSR[15] and clear bits[3:0]*/
        psr_temp = psr_temp >> 3; 
        psr_temp = psr_temp << 3;
        /* add 100 to the last 3 bits */
        CPU->PSR = psr_temp + 4; 
    } else if (result == 0) {
        CPU->NZPVal = 2;
        psr_temp = CPU->PSR; 
        /* preserve PSR[15] and clear bits[3:0]*/
        psr_temp = psr_temp >> 3; 
        psr_temp = psr_temp << 3;
        /* add 010 to the last 3 bits */
        CPU->PSR = psr_temp + 2; 
    } else {
        CPU->NZPVal = 1;
        psr_temp = CPU->PSR; 
        /* preserve PSR[15] and clear bits[3:0]*/
        psr_temp = psr_temp >> 3; 
        psr_temp = psr_temp << 3;
        /* add 001 to the last 3 bits */
        CPU->PSR = psr_temp + 1; 
    }
}
