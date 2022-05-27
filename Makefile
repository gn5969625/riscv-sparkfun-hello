default: sparkfun

sparkfun:
	riscv64-unknown-elf-gcc -march=rv32imac -mabi=ilp32 -static -mcmodel=medany -fvisibility=hidden -nostdlib -nostartfiles -Tred-v.ld hello.s bootmain.c -o hello.elf -Wl,-Map,test.map

	riscv64-unknown-elf-objcopy -O ihex hello.elf hello.hex
clean:
	rm *.hex *.elf *.map
