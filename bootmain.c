#include <stdio.h>
#define UART_TXFIFO_OFF	0
#define UART_REG_BASE	0x10013000

void main(void)
{
	char dbg_msg[] = "Hello world in c!\r\n";
	volatile uint32_t *uart_buf = (uint32_t *) (UART_REG_BASE + UART_TXFIFO_OFF);
	uint32_t msg_len = sizeof(dbg_msg);
	uint32_t i = 0;
	for (i = 0;i < msg_len; i++) {
		while((int32_t) *uart_buf < 0);
		*uart_buf = dbg_msg[i];
	}
	while(1); // never return
}
