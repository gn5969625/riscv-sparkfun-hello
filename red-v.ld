OUTPUT_ARCH("riscv")
OUTPUT_FORMAT("elf32-littleriscv")
ENTRY( _start )

MEMORY
{
        flash (rxai!w) : ORIGIN = 0x20010000, LENGTH = 0x6a120
        ram (wxa!ri) : ORIGIN = 0x80000000, LENGTH = 0x4000
}

/*
 * The PHDRS is avaliable for *.elf file
 * */
PHDRS
{
        flash PT_LOAD;
        ram PT_LOAD;
        ram_init PT_LOAD;
}

SECTIONS
{
	__stack_size = DEFINED(__stack_size) ? __stack_size : 0x1000;
        PROVIDE(__stack_size = __stack_size);

	.text : {
		*(.text)
	} > flash AT > flash :flash

	.rodata : {
		*(.rodata)
	} > flash AT > flash :flash

	.data : ALIGN(4) {
		*(.data)
		. = ALIGN(4);
		*(.sdata)
	} > ram AT > flash :ram_init
	PROVIDE(_data = ADDR(.data));
	PROVIDE(_data_lma = LOADADDR(.data));
	PROVIDE(_edata = . );
	.bss : ALIGN(4)
	{
		*(.sbss*)
		*(.bss .bss.*)
		. = ALIGN(4);
		PROVIDE(_ebss = .);
	} > ram AT > ram :ram
	PROVIDE( _bss_start = ADDR(.bss) );
	PROVIDE( _end = . );
	PROVIDE( _bss_end = . );

	.stack : {
		. += __stack_size;
		PROVIDE(stack_top = .);
	} > ram AT > ram :ram
}
