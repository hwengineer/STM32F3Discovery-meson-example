/******************************************************************************
	Memory Layout Linker File

	Device : STM32F303VC6
	- Flash  256kB
	- RAM     40kB
	- CCRAM    8kB
******************************************************************************/

MEMORY{
	RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 40K
	CCMRAM (xrw)  : ORIGIN = 0x10000000, LENGTH = 8K
	FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 256K
}
