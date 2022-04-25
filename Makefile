default: sparkfun

sparkfun:
	riscv64-unknown-elf-gcc -march=rv32g -mabi=ilp32 -static -mcmodel=medany -fvisibility=hidden -nostdlib -nostartfiles -Tred-v.ld hello.s -o hello.elf

	riscv64-unknown-elf-objcopy -O ihex hello.elf hello.hex
clean:
	rm *.hex *.elf
