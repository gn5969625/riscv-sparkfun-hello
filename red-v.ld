OUTPUT_ARCH("riscv")
OUTPUT_FORMAT("elf32-littleriscv")

ENTRY( _start )
SECTIONS
{
	. = 0x20010000;
	.text : { *(.text) }
	.gnu_build_id : { *(.note.gnu.build-id) }
	.rodata : { * (.rodata) }
	. = ALIGN(4);
	PROVIDE(e_align_rodata = .);
	. = 0x80000000;
	.data : AT(e_align_rodata) { *(.data) }
	.sdata : { *(.sdata) }
	.debug : { *(.debug) }
	PROVIDE(_data = ADDR(.data));
	PROVIDE(_data_lma = LOADADDR(.data));
	PROVIDE( _edata = . );
	. = ALIGN(4);
	PROVIDE( _bss_start = . );
	.bss :
	{
	  *(.sbss*)
	  *(.bss .bss.*)
	  . = ALIGN(4);
	  PROVIDE(_ebss = .);
	}
	PROVIDE( _end = . );
	PROVIDE( _bss_end = . );

	. += 0x1000;
        stack_top = .;
}
