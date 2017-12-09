/******************************************************************************
	Simple Linker File

	.text     program code;
	.rodata   read-only data;
	.data     read-write initialized data;
	.bss      read-write zero initialized data.

******************************************************************************/

/* define entry point */
ENTRY(Reset_Handler)

/* calculate the Last RAM address*/
 _estack = ORIGIN(RAM) + LENGTH(RAM);

/* --- Sections --- */
SECTIONS
{
	/*--------------------------------------------------------------------------*/
  /* interrupt vector goes at the beginning of FLASH */
	.isr_vector : {
			. = ALIGN(4);					/* align */
			_sisr_vector = .;     /* define start symbol */
			KEEP(*(.isr_vector))  /* Interrupt vectors */
			. = ALIGN(4);					/* align */
			_eisr_vector = .;			/* define end symbol */
  } > FLASH
	/*--------------------------------------------------------------------------*/
  /* program data goes into FLASH */
	.text : {
			. = ALIGN(4);					/* align */
			_stext = .;           /* define start symbol */
			*(.text)						  /* insert program code .text */
			*(.text*)             /* .text* sections */

			*(.glue_7)            /* glue arm to thumb code */
			*(.glue_7t)           /* glue thumb to arm code */
			*(.eh_frame)

			. = ALIGN(4);				  /* align */
			_etext = .;           /* define end symbol */
	} > FLASH
	/*--------------------------------------------------------------------------*/
  /* constant data goes into FLASH */
  .rodata : {
			. = ALIGN(4);         /* align */
			*(.rodata)            /* .rodata sections (constants, strings, etc.) */
			*(.rodata*)           /* .rodata* sections (constants, strings, etc.) */
			. = ALIGN(4);         /* align */
  } > FLASH
	/*--------------------------------------------------------------------------*/
  /* ARM stack unwinding section (GDB uses this) */
	.ARM.extab : {
			*(.ARM.extab* .gnu.linkonce.armextab.*)
	} > FLASH

  __exidx_start = .;
	.ARM : {

			*(.ARM.exidx* .gnu.linkonce.armexidx.*)

	} > FLASH
  __exidx_end = .;

	/*--------------------------------------------------------------------------*/
	/* initialized data goes to ram, but must be loaded from flash */
	_sidata = (__exidx_end);	/* calc start adress */
	.data :  AT(_sidata) {
			. = ALIGN(4);
			_sdata = .;           /* create a global symbol at data start */
			*(.data)              /* .data sections */
			*(.data*)             /* .data* sections */

			. = ALIGN(4);         /* align */
			_edata = .;           /* define a global symbol at data end */
	} > RAM
	/*--------------------------------------------------------------------------*/
  /* fast ram data goes into CCRAM */
	_siccmram = ( _sidata + SIZEOF(.data) );

	.ccmram : AT( _siccmram ) {
			. = ALIGN(4);
			_sccmram = .;         /* create a global symbol at ccmram start */
			*(.ccmram)            /* .ccmram sections */
			*(.ccmram*)           /* .ccmram* sections */

			. = ALIGN(4);         /* align */
			_eccmram = .;         /* create a global symbol at ccmram end */
	} > CCMRAM

	/*--------------------------------------------------------------------------*/
  /* zero initialized data goes to RAM and has to be cleared at startup */
	 .bss :
	  {
	    _sbss = .;            /* define a global symbol at bss start */
	    *(.bss)               /* .bss sections */
	    *(.bss*)              /* .bss* sections */
	    *(COMMON)             /* common sections */

	    . = ALIGN(4);         /* align */
	    _ebss = .;            /* define a global symbol at bss end */
	  } > RAM

  /*--------------------------------------------------------------------------*/
  .ARM.attributes 0 : { *(.ARM.attributes) }

}
