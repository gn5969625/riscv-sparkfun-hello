#include <stdio.h>
#define UART_TXFIFO_OFF	0
#define UART_REG_BASE	0x10013000
#define DBG_GV 1
#ifdef DBG_GV
uint32_t cnt = 2;
#endif
void main(void)
{
	char dbg_msg[] = "Hello world in c!\r\n";
	volatile uint32_t *uart_buf = (uint32_t *) (UART_REG_BASE + UART_TXFIFO_OFF);
	uint32_t msg_len = sizeof(dbg_msg);
	uint32_t i = 0;
#ifndef DBG_GV
	uint32_t cnt = 0;
#endif
#ifdef DBG_GV
	char test_msg[] = "Enter loop in c!\r\n";
	for (i = 0;i < sizeof(test_msg); i++) {
		while((int32_t) *uart_buf < 0);
		*uart_buf = test_msg[i];
	}
#endif
	while (cnt++ < 5) {
		for (i = 0;i < msg_len; i++) {
			while((int32_t) *uart_buf < 0);
			*uart_buf = dbg_msg[i];
		}
	}
	while(1); // never return
}
