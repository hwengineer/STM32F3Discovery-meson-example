/******************************************************************************
	Simple Linker File

	.text     program code;
	.rodata   read-only data;
	.data     read-write initialized data;
	.bss      read-write zero initialized data.

******************************************************************************/

/* STM32F303VC6 */
/* Flash  256kB*/
/* RAM    40kB*/


MEMORY{               /* Specify the memory areas*/
	RAM (xrw)           : ORIGIN = 0x20000000, LENGTH = 40K
	CCMRAM (xrw)        : ORIGIN = 0x10000000, LENGTH = 8K
	FLASH (rx)          : ORIGIN = 0x08000000, LENGTH = 256K
}

ENTRY(Reset_Handler)    /* Entry Point */

/* calculate the Last RAM address*/
/* _estack = ORIGIN(RAM) + LENGTH(RAM) - 1; */
_estack = ORIGIN(RAM) + LENGTH(RAM) - 4;

/* --- */

/* Highest address of the user mode stack */
/* Generate a link error if heap and stack don't fit into RAM */
/* --- needed? ---*/
_Min_Heap_Size  = 0x200; /* required amount of heap  */
_Min_Stack_Size = 0x400; /* required amount of stack */

/* --- Sections --- */
SECTIONS
{
	/*--------------------------------------------------------------------------*/

	.text : {
	  . = ALIGN(4);				 	/* align */
		KEEP(*(.isr_vector))	/* insert ISR Vector*/
		. = ALIGN(4);         /* align */

		. = ALIGN(4);					/* align */
		_stext = .;           /* define a global symbol at start of code */
		*(.text)						  /* insert program code .text */
		*(.text*)             /* .text* sections */

		*(.glue_7)            /* glue arm to thumb code */
    *(.glue_7t)           /* glue thumb to arm code */
		*(.eh_frame)

		/* KEEP (*(.init)) */
    /* KEEP (*(.fini)) */

		. = ALIGN(4);				  /* align */
    _etext = .;           /* define a global symbols at end of code */
	} > FLASH

	/*--------------------------------------------------------------------------*/

  .rodata : {             /* constant data goes into FLASH */
    . = ALIGN(4);         /* align */
    *(.rodata)            /* .rodata sections (constants, strings, etc.) */
		*(.rodata*)           /* .rodata* sections (constants, strings, etc.) */
		. = ALIGN(4);         /* align */
  } > FLASH

	/*--------------------------------------------------------------------------*/

	.ARM.extab : {         /* section for stack unwinding (GDB uses this) */
		*(.ARM.extab* .gnu.linkonce.armextab.*)
	} > FLASH

	.ARM : {
		__exidx_start = .;
		*(.ARM.exidx* .gnu.linkonce.armexidx.*)
		__exidx_end = .;
	} > FLASH

	/*--------------------------------------------------------------------------*/
	.preinit_array : {
    PROVIDE_HIDDEN (__preinit_array_start = .);
    KEEP (*(.preinit_array*))
    PROVIDE_HIDDEN (__preinit_array_end = .);
  } > FLASH

  .init_array : {
    PROVIDE_HIDDEN (__init_array_start = .);
    KEEP (*(SORT(.init_array.*)))
    KEEP (*(.init_array*))
    PROVIDE_HIDDEN (__init_array_end = .);
  } > FLASH

	.fini_array : {
    PROVIDE_HIDDEN (__fini_array_start = .);
    KEEP (*(SORT(.fini_array.*)))
    KEEP (*(.fini_array*))
    PROVIDE_HIDDEN (__fini_array_end = .);
  } > FLASH

	/*--------------------------------------------------------------------------*/

  _sidata = LOADADDR(.data);	/* used by the startup to initialize data */

  .data :  {           /* Initialized data sections goes into RAM, but must be loaded from flash */
    . = ALIGN(4);
    _sdata = .;        /* create a global symbol at data start */
    *(.data)           /* .data sections */
    *(.data*)          /* .data* sections */

    . = ALIGN(4);
    _edata = .;        /* define a global symbol at data end */
  } > RAM /*AT> FLASH*/

	/*--------------------------------------------------------------------------*/

/*	 _siccmram = LOADADDR(.ccmram); */

	  /* CCM-RAM section
	  *
	  * IMPORTANT NOTE!
	  * If initialized variables will be placed in this section,
	  * the startup code needs to be modified to copy the init-values.
	  */
/*	  .ccmram : AT(_siccmram){ */

/*	    . = ALIGN(4); */
/*	    _sccmram = .;  */      /* create a global symbol at ccmram start */
/*	    *(.ccmram) */
/*	    *(.ccmram*) */

/*	    . = ALIGN(4); */
/*	    _eccmram = .; */      /* create a global symbol at ccmram end */
	/*  } > CCMRAM *//*AT> FLASH*/

		/*--------------------------------------------------------------------------*/

	  /* Uninitialized data section */
	  /* . = ALIGN(4); */
	  .bss :
	  {
	    /* This is used by the startup in order to initialize the .bss secion */
	    _sbss = .;         /* define a global symbol at bss start */
	    __bss_start__ = _sbss;
	    *(.bss)
	    *(.bss*)
	    *(COMMON)

	    . = ALIGN(4);
	    _ebss = .;         /* define a global symbol at bss end */
	    __bss_end__ = _ebss;
	  } > RAM

		/*--------------------------------------------------------------------------*/

	  /* User_heap_stack section, used to check that there is enough RAM left */
	  ._user_heap_stack :
	  {
	    . = ALIGN(4);
	    PROVIDE ( end = . );
	    PROVIDE ( _end = . );
	    . = . + _Min_Heap_Size;
	    . = . + _Min_Stack_Size;
	    . = ALIGN(4);
	  } > RAM

		/*--------------------------------------------------------------------------*/

	  /* Remove information from the standard libraries */
	  /DISCARD/ :
	  {
	    libc.a ( * )
	    libm.a ( * )
	    libgcc.a ( * )
	  }

	  .ARM.attributes 0 : { *(.ARM.attributes) }
	}
