#include <stdio.h>
#define UART_TXFIFO_OFF	0
#define UART_REG_BASE	0x10013000
uint32_t cnt = 0;
uint32_t cnt_max = 10;
void main(void)
{
	char dbg_msg[] = "Hello world in c!\r\n";
	volatile uint32_t *uart_buf = (uint32_t *) (UART_REG_BASE + UART_TXFIFO_OFF);
	uint32_t i = 0;
	char test_msg[] = "Enter loop in c!\r\n";
	for (i = 0;i < sizeof(test_msg); i++) {
		while((int32_t) *uart_buf < 0);
		*uart_buf = test_msg[i];
	}
	while (cnt++ < cnt_max) {
		for (i = 0;i < sizeof(dbg_msg); i++) {
			while((int32_t) *uart_buf < 0);
			*uart_buf = dbg_msg[i];
		}
	}
	while(1); // never return
}
