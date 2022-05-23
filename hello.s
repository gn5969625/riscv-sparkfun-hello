.align 2
.equ UART_REG_TXFIFO, 0
.equ UART_BASE, 0x10013000

.section .text
.globl _start

_start:
    csrr  t0, mhartid
    bnez  t0, halt

    la    sp, stack_top
    la    a0, msg
    jal   puts

        la t0, _data_lma
        la t1, _data
        beq t0, t1, 2f
        la t2, _edata
        bgeu t1, t2, 2f
1:
        lw t3, 0(t0)
        sw t3, 0(t1)
        addi t0, t0, 4
        addi t1, t1, 4
        bltu t1, t2, 1b
2:

        /* Clear bss section */
        la t1, _bss_start
        la t2, _bss_end
        bgeu t1, t2, 4f
3:
        sw   x0, 0(t1)
        addi t1, t1, 4
        blt  t1, t2, 3b
4:
    jal main

puts:
    li  t0, UART_BASE

.puts_loop: lbu t1, (a0)
    beqz t1, .puts_leave


.puts_waits: lw t2, UART_REG_TXFIFO(t0)
    bltz t2, .puts_waits

    sw  t1, UART_REG_TXFIFO(t0)

    add a0, a0, 1
    j .puts_loop


.puts_leave:
    ret



halt: j halt



.section .rodata
msg:
  .string "LowLevelKevin.\r\n"
