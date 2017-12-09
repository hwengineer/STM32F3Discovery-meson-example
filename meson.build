project('blink', 'c',
          default_options : ['b_lto=false',
                             'b_asneeded=false'])



# Initialize some globals
srcs          = []
incdirs       = []
# compilerArgs  = ['-DSTM32F3','-DSTM32F303xC','-DUSE_HAL_DRIVER','-DUSE_LEGACY'] #['-std=c11', '-O2']
compilerArgs  = []
linkArgs      = []
linkDeps      = []

# import options from cross_file
c_args      = meson.get_cross_property('c_args')
c_link_args = meson.get_cross_property('c_link_args')

compilerArgs += c_args
linkArgs     += c_link_args

add_global_arguments('-DSTM32F3',        language : 'c')
add_global_arguments('-DSTM32F303xC',    language : 'c')
add_global_arguments('-DUSE_HAL_DRIVER', language : 'c')
add_global_arguments('-DUSE_LEGACY',     language : 'c')

#==============================================================================#

# Add source files
srcs += ['startup_stm32f303xc.s','main.c','startup.c']
# srcs += ['STM32Cube-f3-meson/Drivers/CMSIS/Device/ST/STM32F3xx/Source/Templates/gcc/startup_stm32f303xc.s','main.c']

#==============================================================================#

# Add linker files
# linkfiles = ['ldscripts/mem.ld','ldscripts/libs.ld','ldscripts/sections.ld']
# linkfiles = ['ldscripts/STM32F303VC6.ld']
linkfiles = ['ldscripts/mem_STM32F303VC6.ld', 'ldscripts/simple.ld']

foreach linkfile : linkfiles
 linkArgs += ['-Wl,-T,@0@/@1@'.format(meson.current_source_dir(), linkfile)]
 linkDeps += [linkfile]
endforeach

#==============================================================================#

# add cpu specific compiler args (without hard fpu support  options)
if host_machine.cpu() == 'cortex-m0'
  if meson.get_compiler('c').get_id() == 'clang'
    add_global_arguments('--target=thumbv6m-none-eabi',language : 'c')
  endif
    add_global_arguments('-mcpu=cortex-m0',    language : 'c')
    add_global_arguments('-mthumb',            language : 'c')
    # compilerArgs += ['-mcpu=cortex-m0',     '-mthumb']
elif host_machine.cpu() == 'cortex-m0+'
  if meson.get_compiler('c').get_id() == 'clang'
    add_global_arguments('--target=thumbv6m-none-eabi',language : 'c')
  endif
    add_global_arguments('-mcpu=cortex-m0plus',language : 'c')
    add_global_arguments('-mthumb',            language : 'c')
    # compilerArgs += ['-mcpu=cortex-m0plus', '-mthumb']
elif host_machine.cpu() == 'cortex-m1'
  if meson.get_compiler('c').get_id() == 'clang'
    add_global_arguments('--target=thumbv6m-none-eabi',language : 'c')
  endif
    add_global_arguments('-mcpu=cortex-m1',    language : 'c')
    add_global_arguments('-mthumb',            language : 'c')
    # compilerArgs += ['-mcpu=cortex-m1',     '-mthumb']
elif host_machine.cpu() == 'cortex-m3'
  if meson.get_compiler('c').get_id() == 'clang'
    add_global_arguments('--target=thumbv7m-none-eabi',language : 'c')
  endif
    add_global_arguments('-mcpu=cortex-m3',    language : 'c')
    add_global_arguments('-mthumb',            language : 'c')
    # compilerArgs += ['-mcpu=cortex-m3',     '-mthumb']
elif host_machine.cpu() == 'cortex-m4'

    if meson.get_compiler('c').get_id() == 'clang'
      add_global_arguments('--target=arm-none-eabi',language : 'c')

      #add_global_arguments('--target=armv7em-none-eabi',language : 'c')
      # add_global_arguments('--target=thumbv7em-none-eabi',language : 'c')
      #add_global_arguments('--target=thumbv7em-none-eabihf',language : 'c') # hardfloat
      add_global_arguments('-mcpu=cortex-m4',      language : 'c')
      # add_global_arguments('-mthumb',              language : 'c')
    else
      add_global_arguments('-mcpu=cortex-m4',    language : 'c')
      add_global_arguments('-mthumb',            language : 'c')
    endif
    # compilerArgs += ['-mcpu=cortex-m4',     '-mthumb']
elif host_machine.cpu() == 'cortex-m7'
    add_global_arguments('-mcpu=cortex-m7',    language : 'c')
    add_global_arguments('-mthumb',            language : 'c')
    # compilerArgs += ['-mcpu=cortex-m7',     '-mthumb']
else
  error('host_machine.cpu no suitable option found')
endif

#==============================================================================#
if meson.get_compiler('c').get_id() == 'clang'

  # compilerArgs += ['-Og']
  compilerArgs += ['-O3']

  # compilerArgs += ['-isysroot', '/usr/lib/arm-none-eabi/']
  incdirs += include_directories('/usr/include/newlib/')
  # incdirs += include_directories('/usr/lib/arm-none-eabi/lib/')


  # incdirs += include_directories('/usr/lib/arm-none-eabi/newlib/armv7e-m/')

  compilerArgs += ['-ffreestanding']
  # compilerArgs += ['-nostartfiles']

  # compilerArgs += ['-Weverything']

  # for debugging meson / ninja:
  add_global_arguments('-v',    language : 'c')


  # linkArgs += ['--target=arm-none-eabi']
  # linkArgs += ['-specs=nosys.specs'] # define newlib spec [nano.specs / nosys.specs]
  # linkArgs += ['-specs=rdimon.specs'] # define newlib spec [nano.specs / nosys.specs]


  # linkArgs += ['-Wl,--as-needed']
  else

# Add compiler options
# compilerArgs += ['-Og']                       # optimization [0,1,2,3,s,g]
compilerArgs += ['-fmessage-length=0']        # all error warnings in a single line (default 72)
compilerArgs += ['-fsigned-char']             # char is per default unsigned
compilerArgs += ['-ffunction-sections']       # each function to a seperate section ==> Code-optimization / deletion
compilerArgs += ['-fdata-sections']           # each variable to a seperate section ==> Code-optimization / deletion
# compilerArgs += ['-fno-move-loop-invariants'] # optimizes loops, moves out stuff, that is not loop dependend
compilerArgs += ['-Wall']                     # creates Warnings (but not every warning)
compilerArgs += ['-Wextra']                   # creates extra Warnings
# compilerArgs += ['-g3']                       # debug level
# compilerArgs += ['-ffreestanding']            # no std lib ==> free standing application
# compilerArgs += ['-nostartfiles']            # no std lib ==> free standing application

# compilerArgs += ['-T,@0@/@1@'.format(meson.current_source_dir(), 'ldscripts/STM32F303VC6.ld')] # does nothing?


# compilerArgs += ['-symbolic'] # does nothing?
# linkArgs     += ['-symbolic'] # does nothing?

# compilerArgs += ['-flto']
# arm-none-eabi-g++ -mcpu=cortex-m4
                  # -mthumb
                  # -Og
                  # -fmessage-length=0
                  # -fsigned-char
                  # -ffunction-sections
                  # -fdata-sections
                  # -ffreestanding
                  # -fno-move-loop-invariants
                  # -Wall
                  # -Wextra
                  # -g3
                  # -T mem.ld
                  # -T libs.ld
                  # -T sections.ld
                  # -nostartfiles
                  # -Xlinker --gc-sections
                  # -L"../ldscripts"
                  # -Wl,-Map,"STM32F3Discovery_Blink.map"
                  # --specs=nano.specs
                  # -o "STM32F3Discovery_Blink.elf" $(
                  # OBJS) $(USER_OBJS) $(LIBS)

# Add Linker Arguments
linkArgs += ['-gc-sections']
linkArgs += ['-specs=nosys.specs']
linkArgs += ['-Wl,-Map,output.map']

endif

#==============================================================================#

# subdir
subdir('STM32Cube-f3-meson')

if meson.get_cross_property('stm32cube_as_static') == true
    #--------------------------------------------------------------------------#
    main = executable(
              'main.elf',
              srcs,
              c_args              : compilerArgs,
              link_args           : [linkArgs,'-Wl,--gc-sections','-Wl,--as-needed'],
              link_depends        : linkDeps,
              link_whole          : stm32cube, # important link_whole! https://stackoverflow.com/questions/30355013/linking-with-static-library-not-equivalent-to-linking-with-its-objects
              include_directories : [incdirs, stm32cube_incdirs] )

    #--------------------------------------------------------------------------#
else
    #--------------------------------------------------------------------------#
    foreach srcfile : stm32cube_srcs
     srcs += ['@0@/@1@'.format('STM32Cube-f3-meson', srcfile)]
    endforeach

    main = executable(
                'main.elf',
                srcs ,
                c_args              : compilerArgs,
                link_args           : linkArgs,
                include_directories : [incdirs, stm32cube_incdirs] )
endif
    #--------------------------------------------------------------------------#

# https://bugs.launchpad.net/ubuntu/+source/llvm-defaults/+bug/1242300
# https://scienceprog.com/topic/using-clangllvm-for-arm-bare-metal-development/


#==============================================================================#

objcopy = '@0@'.format(find_program('objcopy').path())
objdump = '@0@'.format(find_program('objdump').path())
size    = '@0@'.format(find_program('size').path())
gdb     = '@0@'.format(find_program('gdb').path())

mainbin = custom_target(
                        'main.bin',
    output           : ['main.bin'],
    build_by_default : true,
    command          : [objcopy, '-O', 'binary', 'main.elf', 'main.bin'],
    depends          : [main])

mainhex = custom_target(
                            'main.hex',
        output           : ['main.hex'],
        build_by_default : true,
        command          : [objcopy, '-O', 'ihex', 'main.elf', 'main.hex'],
        depends          : [main])

mainsize = custom_target(
                          'size',
        capture          : true,
        output           : ['main.size'],
        build_by_default : true,
        command          : [size, '--format=berkeley', 'main.elf'],
        depends          : [main])

maindump = custom_target(
                        'dump',
      capture          : true,
      output           : ['main.dump'],
      command          : [objdump, '-D', 'main.elf', '>', 'main.dump'],
      depends          : [main])

# run_target('gdb',
#         command : [gdb , '-q' , '@0@/main.elf'.format(meson.current_build_dir())])

#==============================================================================#

# Debug commands
# message(host_machine.system())
# message(host_machine.cpu_family())
# message(host_machine.cpu())
# message(host_machine.endian())

# ninja reconfigure
# arm-none-eabi-objdump -d main.elf

# https://www.mikrocontroller.net/articles/ARM_GCC
# https://github.com/libopencm3/libopencm3-examples/pull/30/files
# https://launchpadlibrarian.net/170926122/readme.txt
# https://github.com/winksaville/baremetal-hi
# cgi.cs.indiana.edu/~geobrown/stm32/Main/Simulation
# https://stackoverflow.com/questions/34602912/with-meson-build-can-i-define-intra-project-dependencies

# links for use with llvm
# https://github.com/dwelch67/mbed_samples/
# https://github.com/dwelch67/stm32f4d
# https://github.com/martinribelotta/cortex-m-llvm

# http://sushihangover.github.io/arm-bare-metal-comparing-llvm-to-arm-gcc/

# semihosting : --specs=rdimon.specs
# https://codedump.io/share/g8WrDQEWOR4S/1/programming-stm32f4x-without-ide-on-debian
# https://stackoverflow.com/questions/18157773/gcc-for-arm-move-code-and-stack


# https://stackoverflow.com/questions/30355013/linking-with-static-library-not-equivalent-to-linking-with-its-objects


# -DCHIP_LPC11UXX -DCORE_M0 -DNO_BOARD_LIB -D__CORTEX_M0 -D__USE_CMSIS -target arm-none-eabi -std=gnu99 -fno-common -fmessage-length=0 -Wall -fno-exceptions -ffunction-sections -fdata-sections -fomit-frame-pointer -fshort-enums -Wno-unknown-attributes -mcpu=cortex-m0 -mthumb -O3 -DNDEBUG -Wno-unused-but-set-variable -Wno-unused-variable
