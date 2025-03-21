# 1 "lh.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "lh.S"
# See LICENSE for license details.

#*****************************************************************************
# lh.S
#-----------------------------------------------------------------------------

# Test lh instruction.


# 1 "riscv_test.h" 1
# 11 "lh.S" 2
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
# 12 "lh.S" 2


.text; .global _start; .global lh_ret; _start: lui s0,%hi(test_name); addi s0,s0,%lo(test_name); name_print_loop: lb a0,0(s0); beqz a0,prname_done; li a7,11; ecall; addi s0,s0,1; j name_print_loop; test_name: .ascii "lh"; .byte '.','.',0x00; .balign 4, 0; prname_done:

  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  test_2: la x1, tdat; lh x3, 0(x1);; li x29, 0x000000ff; li x28, 2; bne x3, x29, fail;;
  test_3: la x1, tdat; lh x3, 2(x1);; li x29, 0xffffff00; li x28, 3; bne x3, x29, fail;;
  test_4: la x1, tdat; lh x3, 4(x1);; li x29, 0x00000ff0; li x28, 4; bne x3, x29, fail;;
  test_5: la x1, tdat; lh x3, 6(x1);; li x29, 0xfffff00f; li x28, 5; bne x3, x29, fail;;

  # Test with negative offset

  test_6: la x1, tdat4; lh x3, -6(x1);; li x29, 0x000000ff; li x28, 6; bne x3, x29, fail;;
  test_7: la x1, tdat4; lh x3, -4(x1);; li x29, 0xffffff00; li x28, 7; bne x3, x29, fail;;
  test_8: la x1, tdat4; lh x3, -2(x1);; li x29, 0x00000ff0; li x28, 8; bne x3, x29, fail;;
  test_9: la x1, tdat4; lh x3, 0(x1);; li x29, 0xfffff00f; li x28, 9; bne x3, x29, fail;;

  # Test with a negative base

  test_10: la x1, tdat; addi x1, x1, -32; lh x3, 32(x1);; li x29, 0x000000ff; li x28, 10; bne x3, x29, fail;





  # Test with unaligned base

  test_11: la x1, tdat; addi x1, x1, -5; lh x3, 7(x1);; li x29, 0xffffff00; li x28, 11; bne x3, x29, fail;





  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_12: li x28, 12; li x4, 0; 1: la x1, tdat2; lh x3, 2(x1); addi x6, x3, 0; li x29, 0x00000ff0; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;
  test_13: li x28, 13; li x4, 0; 1: la x1, tdat3; lh x3, 2(x1); nop; addi x6, x3, 0; li x29, 0xfffff00f; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;
  test_14: li x28, 14; li x4, 0; 1: la x1, tdat1; lh x3, 2(x1); nop; nop; addi x6, x3, 0; li x29, 0xffffff00; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;

  test_15: li x28, 15; li x4, 0; 1: la x1, tdat2; lh x3, 2(x1); li x29, 0x00000ff0; bne x3, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_16: li x28, 16; li x4, 0; 1: la x1, tdat3; nop; lh x3, 2(x1); li x29, 0xfffff00f; bne x3, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_17: li x28, 17; li x4, 0; 1: la x1, tdat1; nop; nop; lh x3, 2(x1); li x29, 0xffffff00; bne x3, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  #-------------------------------------------------------------
  # Test write-after-write hazard
  #-------------------------------------------------------------

  test_18: la x3, tdat; lh x2, 0(x3); li x2, 2;; li x29, 2; li x28, 18; bne x2, x29, fail;





  test_19: la x3, tdat; lh x2, 0(x3); nop; li x2, 2;; li x29, 2; li x28, 19; bne x2, x29, fail;






  bne x0, x28, pass; fail: j fail_print; fail_string: .ascii "FAIL\n\0"; .balign 4, 0; fail_print: la s0,fail_string; fail_print_loop: lb a0,0(s0); beqz a0,fail_print_exit; li a7,11; ecall; addi s0,s0,1; j fail_print_loop; fail_print_exit: li a7,93; li a0,1; ecall;; pass: j pass_print; pass_string: .ascii "PASS!\n\0"; .balign 4, 0; pass_print: la s0,pass_string; pass_print_loop: lb a0,0(s0); beqz a0,pass_print_exit; li a7,11; ecall; addi s0,s0,1; j pass_print_loop; pass_print_exit: jal zero,lh_ret;

lh_ret: li a7,93; li a0,0; ecall;

  .data
.balign 4;

 

tdat:
tdat1: .half 0x00ff
tdat2: .half 0xff00
tdat3: .half 0x0ff0
tdat4: .half 0xf00f


