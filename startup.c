#include <stdio.h>

extern uint32_t _sidata;
extern uint32_t _sdata;
extern uint32_t _edata;
extern uint32_t _sbss;
extern uint32_t _ebss;

void startup(void);

void startup(void) {

  uint32_t *ptr_flash = &_sidata;
  uint32_t *ptr_rom   = &_sdata;

  while(ptr_rom <= &_edata){
      *ptr_rom = *ptr_flash;
      ptr_rom++;
      ptr_flash++;
  }

  *ptr_rom   = &_sbss;

  while(ptr_rom <= &_ebss){
      *ptr_rom = (uint32_t) 0;
      ptr_rom++;
  }

}
