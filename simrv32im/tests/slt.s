# 1 "slt.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "slt.S"
# See LICENSE for license details.

#*****************************************************************************
# slt.S
#-----------------------------------------------------------------------------

# Test slt instruction.


# 1 "riscv_test.h" 1
# 11 "slt.S" 2
# 1 "test_macros.h" 1






#-----------------------------------------------------------------------
# Helper macros
#-----------------------------------------------------------------------
# 18 "test_macros.h"
# We use a macro hack to simpify code generation for various numbers
# of bubble cycles.
# 34 "test_macros.h"
#-----------------------------------------------------------------------
# RV64UI MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Tests for instructions with immediate operand
#-----------------------------------------------------------------------
# 90 "test_macros.h"
#-----------------------------------------------------------------------
# Tests for vector config instructions
#-----------------------------------------------------------------------
# 118 "test_macros.h"
#-----------------------------------------------------------------------
# Tests for an instruction with register operands
#-----------------------------------------------------------------------
# 146 "test_macros.h"
#-----------------------------------------------------------------------
# Tests for an instruction with register-register operands
#-----------------------------------------------------------------------
# 240 "test_macros.h"
#-----------------------------------------------------------------------
# Test memory instructions
#-----------------------------------------------------------------------
# 317 "test_macros.h"
#-----------------------------------------------------------------------
# Test branch instructions
#-----------------------------------------------------------------------
# 402 "test_macros.h"
#-----------------------------------------------------------------------
# Test jump instructions
#-----------------------------------------------------------------------
# 431 "test_macros.h"
#-----------------------------------------------------------------------
# RV64UF MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Tests floating-point instructions
#-----------------------------------------------------------------------
# 567 "test_macros.h"
#-----------------------------------------------------------------------
# Pass and fail code (assumes test num is in x28)
#-----------------------------------------------------------------------
# 579 "test_macros.h"
#-----------------------------------------------------------------------
# Test data section
#-----------------------------------------------------------------------
# 12 "slt.S" 2


.text; .global _start; .global slt_ret; _start: lui s0,%hi(test_name); addi s0,s0,%lo(test_name); name_print_loop: lb a0,0(s0); beqz a0,prname_done; li a7,11; ecall; addi s0,s0,1; j name_print_loop; test_name: .ascii "slt"; .byte '.','.',0x00; .balign 4, 0; prname_done:

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  test_2: li x1, 0x00000000; li x2, 0x00000000; slt x3, x1, x2;; li x29, 0; li x28, 2; bne x3, x29, fail;;
  test_3: li x1, 0x00000001; li x2, 0x00000001; slt x3, x1, x2;; li x29, 0; li x28, 3; bne x3, x29, fail;;
  test_4: li x1, 0x00000003; li x2, 0x00000007; slt x3, x1, x2;; li x29, 1; li x28, 4; bne x3, x29, fail;;
  test_5: li x1, 0x00000007; li x2, 0x00000003; slt x3, x1, x2;; li x29, 0; li x28, 5; bne x3, x29, fail;;

  test_6: li x1, 0x00000000; li x2, 0xffff8000; slt x3, x1, x2;; li x29, 0; li x28, 6; bne x3, x29, fail;;
  test_7: li x1, 0x80000000; li x2, 0x00000000; slt x3, x1, x2;; li x29, 1; li x28, 7; bne x3, x29, fail;;
  test_8: li x1, 0x80000000; li x2, 0xffff8000; slt x3, x1, x2;; li x29, 1; li x28, 8; bne x3, x29, fail;;

  test_9: li x1, 0x00000000; li x2, 0x00007fff; slt x3, x1, x2;; li x29, 1; li x28, 9; bne x3, x29, fail;;
  test_10: li x1, 0x7fffffff; li x2, 0x00000000; slt x3, x1, x2;; li x29, 0; li x28, 10; bne x3, x29, fail;;
  test_11: li x1, 0x7fffffff; li x2, 0x00007fff; slt x3, x1, x2;; li x29, 0; li x28, 11; bne x3, x29, fail;;

  test_12: li x1, 0x80000000; li x2, 0x00007fff; slt x3, x1, x2;; li x29, 1; li x28, 12; bne x3, x29, fail;;
  test_13: li x1, 0x7fffffff; li x2, 0xffff8000; slt x3, x1, x2;; li x29, 0; li x28, 13; bne x3, x29, fail;;

  test_14: li x1, 0x00000000; li x2, 0xffffffff; slt x3, x1, x2;; li x29, 0; li x28, 14; bne x3, x29, fail;;
  test_15: li x1, 0xffffffff; li x2, 0x00000001; slt x3, x1, x2;; li x29, 1; li x28, 15; bne x3, x29, fail;;
  test_16: li x1, 0xffffffff; li x2, 0xffffffff; slt x3, x1, x2;; li x29, 0; li x28, 16; bne x3, x29, fail;;

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  test_17: li x1, 14; li x2, 13; slt x1, x1, x2;; li x29, 0; li x28, 17; bne x1, x29, fail;;
  test_18: li x1, 11; li x2, 13; slt x2, x1, x2;; li x29, 1; li x28, 18; bne x2, x29, fail;;
  test_19: li x1, 13; slt x1, x1, x1;; li x29, 0; li x28, 19; bne x1, x29, fail;;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_20: li x4, 0; 1: li x1, 11; li x2, 13; slt x3, x1, x2; addi x6, x3, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, 1; li x28, 20; bne x6, x29, fail;;
  test_21: li x4, 0; 1: li x1, 14; li x2, 13; slt x3, x1, x2; nop; addi x6, x3, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, 0; li x28, 21; bne x6, x29, fail;;
  test_22: li x4, 0; 1: li x1, 12; li x2, 13; slt x3, x1, x2; nop; nop; addi x6, x3, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, 1; li x28, 22; bne x6, x29, fail;;

  test_23: li x4, 0; 1: li x1, 14; li x2, 13; slt x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, 0; li x28, 23; bne x3, x29, fail;;
  test_24: li x4, 0; 1: li x1, 11; li x2, 13; nop; slt x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, 1; li x28, 24; bne x3, x29, fail;;
  test_25: li x4, 0; 1: li x1, 15; li x2, 13; nop; nop; slt x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, 0; li x28, 25; bne x3, x29, fail;;
  test_26: li x4, 0; 1: li x1, 10; nop; li x2, 13; slt x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, 1; li x28, 26; bne x3, x29, fail;;
  test_27: li x4, 0; 1: li x1, 16; nop; li x2, 13; nop; slt x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, 0; li x28, 27; bne x3, x29, fail;;
  test_28: li x4, 0; 1: li x1, 9; nop; nop; li x2, 13; slt x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, 1; li x28, 28; bne x3, x29, fail;;

  test_29: li x4, 0; 1: li x2, 13; li x1, 17; slt x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, 0; li x28, 29; bne x3, x29, fail;;
  test_30: li x4, 0; 1: li x2, 13; li x1, 8; nop; slt x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, 1; li x28, 30; bne x3, x29, fail;;
  test_31: li x4, 0; 1: li x2, 13; li x1, 18; nop; nop; slt x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, 0; li x28, 31; bne x3, x29, fail;;
  test_32: li x4, 0; 1: li x2, 13; nop; li x1, 7; slt x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, 1; li x28, 32; bne x3, x29, fail;;
  test_33: li x4, 0; 1: li x2, 13; nop; li x1, 19; nop; slt x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, 0; li x28, 33; bne x3, x29, fail;;
  test_34: li x4, 0; 1: li x2, 13; nop; nop; li x1, 6; slt x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, 1; li x28, 34; bne x3, x29, fail;;

  test_35: li x1, -1; slt x2, x0, x1;; li x29, 0; li x28, 35; bne x2, x29, fail;;
  test_36: li x1, -1; slt x2, x1, x0;; li x29, 1; li x28, 36; bne x2, x29, fail;;
  test_37: slt x1, x0, x0;; li x29, 0; li x28, 37; bne x1, x29, fail;;
  test_38: li x1, 16; li x2, 30; slt x0, x1, x2;; li x29, 0; li x28, 38; bne x0, x29, fail;;

  bne x0, x28, pass; fail: j fail_print; fail_string: .ascii "FAIL\n\0"; .balign 4, 0; fail_print: la s0,fail_string; fail_print_loop: lb a0,0(s0); beqz a0,fail_print_exit; li a7,11; ecall; addi s0,s0,1; j fail_print_loop; fail_print_exit: li a7,93; li a0,1; ecall;; pass: j pass_print; pass_string: .ascii "PASS!\n\0"; .balign 4, 0; pass_print: la s0,pass_string; pass_print_loop: lb a0,0(s0); beqz a0,pass_print_exit; li a7,11; ecall; addi s0,s0,1; j pass_print_loop; pass_print_exit: jal zero,slt_ret;

slt_ret: li a7,93; li a0,0; ecall;

  .data
.balign 4;

 


