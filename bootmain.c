//int test_a = 1;
#include <stdio.h>
#define UART_TXFIFO_OFF	0
#define UART_REG_BASE	0x10013000

char dbg_msg[] = "Hello world in c!\r\n";
volatile uint32_t *uart_buf = (uint32_t *) (UART_REG_BASE + UART_TXFIFO_OFF);

void BootMain(void)
{
	uint32_t msg_len = sizeof(dbg_msg);
	uint32_t i = 0;
	for (i = 0;i < msg_len; i++) {
		while(*uart_buf);
		*uart_buf = dbg_msg[i];
	}

	while(1);
	/*
	 * never return
	 */
}
