# instructions: save as ~/.gdbinit

## description: a cracker-friendly gdb configuration file.
## revision : 6.1
## contributors: mammon_, elaine, pusillus, mong
## feedback: http://board.anticrack.de/viewforum.php?f=35
## notes: 'help user' in gdb will list the commands/descriptions in this file
#'context on' now enables auto-display of context screen
## changelog:
#version 6.1
#fixed filename in step_to_call so it points to /dev/null
#changed location of logfiles from /tmp to ~
#version 6
#added print_insn_type, get_insn_type, context-on, context-off commands
#added trace_calls, trace_run, step_to_call commands
#changed hook-stop so it checks $show_context variable
#version 5
#added bpm, dump_bin, dump_hex, bp_alloc commands
#added 'assemble' by elaine, 'gas_asm' by mong
#added tip topics for aspiring crackers ;)
#version 4
#added eflags-changing insns by pusillus
#added bp, nop, null, and int3 patch commands, also hook-stop
#version 3
#incorporated elaine's if/else goodness into the hex/ascii dump
#version 2
#radix bugfix by elaine
# todo:
#* add global vars to allow user to control stack,data,code win sizes
#* add dump, append, set write, etc commands
#* more tips!

#______________breakpoint aliases_____________
define bpl
  info breakpoints
end
document bpl
list breakpoints
end

define bp
  set $show_context = 1
  break * $arg0
end
document bp
set a breakpoint on address
usage: bp addr
end


define bpc
  clear $arg0
end
document bpc
clear breakpoint at function/address
usage: bpc addr
end

define bpe
  enable $arg0
end
document bpe
enable breakpoint #
usage: bpe num
end

define bpd
  disable $arg0
end
document bpd
disable breakpoint #
usage: bpd num
end

define bpt
  set $show_context = 1
  tbreak $arg0
end
document bpt
set a temporary breakpoint on address
usage: bpt addr
end

define bpm
  set $show_context = 1
  awatch $arg0
end
document bpm
set a read/write breakpoint on address
usage: bpm addr
end

define bhb
  set $show_context = 1

  break * $arg0
end
document bhb
set hardware assisted breakpoint on address
usage: bhb addr
end


#______________process information____________
define argv
  show args
end
document argv
print program arguments
end


define stack
  info stack
end
document stack
print call stack
end


define flags
  if (($eflags >> 0xb) & 1 )
    printf "o "
  else
    printf "o "
  end
  if (($eflags >> 0xa) & 1 )
    printf "d "
  else
    printf "d "
  end
  if (($eflags >> 9) & 1 )
    printf "i "
  else
    printf "i "
  end
  if (($eflags >> 8) & 1 )
    printf "t "
  else
    printf "t "
  end
  if (($eflags >> 7) & 1 )
    printf "s "
  else
    printf "s "
  end
  if (($eflags >> 6) & 1 )
    printf "z "
  else
    printf "z "
  end
  if (($eflags >> 4) & 1 )
    printf "a "
  else
    printf "a "
  end
  if (($eflags >> 2) & 1 )
    printf "p "
  else
    printf "p "
  end
  if ($eflags & 1)
    printf "c "
  else
    printf "c "
  end
  printf "\n"
end
document flags
print flags register
end

define eflags
  printf " of <%d> df <%d> if <%d> tf <%d>\n",\
  (($eflags >> 0xb) & 1 ), (($eflags >> 0xa) & 1 ), \
  (($eflags >> 9) & 1 ), (($eflags >> 8) & 1 )
  printf " sf <%d> zf <%d> af <%d> pf <%d> cf <%d>\n",\
  (($eflags >> 7) & 1 ), (($eflags >> 6) & 1 ),\
  (($eflags >> 4) & 1 ), (($eflags >> 2) & 1 ), ($eflags & 1)
  printf " id <%d> vip <%d> vif <%d> ac <%d>\n",\
  (($eflags >> 0x15) & 1 ), (($eflags >> 0x14) & 1 ), \
  (($eflags >> 0x13) & 1 ), (($eflags >> 0x12) & 1 )
  printf " vm <%d> rf <%d> nt <%d> iopl <%d>\n",\
  (($eflags >> 0x11) & 1 ), (($eflags >> 0x10) & 1 ),\
  (($eflags >> 0xe) & 1 ), (($eflags >> 0xc) & 3 )
end
document eflags
print entire eflags register
end

define reg
  printf " eax:%08x ebx:%08x ecx:%08x\n", $eax, $ebx, $ecx
  printf " edx:%08x eflags:%08x\n", $edx, $eflags
  printf " esi:%08x edi:%08x esp:%08x\n", $esi, $edi, $esp
  printf " ebp:%08x eip:%08x\n", $ebp, $eip
  printf " cs:%04x ds:%04x es:%04x\n", $cs, $ds, $es
  printf " fs:%04x gs:%04x ss:%04x\n", $fs, $gs, $ss
  echo \033[31m
  flags
  echo \033[0m
end
document reg
print cpu registers
end

define func
  info functions
end
document func
print functions in target
end

define var
  info variables
end
document var
print variables (symbols) in target
end

define lib
  info sharedlibrary
end
document lib
print shared libraries linked to target
end

define sig
  info signals
end
document sig
print signal actions for target
end

define u
  info udot
end
document u
print kernel 'user' struct for target
end

define dis
  disassemble $arg0
end
document dis
disassemble address
usage: dis addr
end


#________________hex/ascii dump an address______________
define ascii_char
  # thanks elaine :)
  set $_c=*(unsigned char *)($arg0)
  if ( $_c < 0x20 || $_c > 0x7e )
    printf "."
  else
    printf "%c", $_c
  end
end
document ascii_char
print the ascii value of arg0 or '.' if value is unprintable
end

define hex_quad
  printf "%02x %02x %02x %02x %02x %02x %02x %02x",
  \
  *(unsigned char*)($arg0), *(unsigned char*)($arg0 + 1),

  \ *(unsigned char*)($arg0 + 2), *(unsigned char*)($arg0 + 3), \ *(unsigned char*)($arg0 + 4), *(unsigned char*)($arg0 + 5), \

  *(unsigned char*)($arg0 + 6), *(unsigned char*)($arg0 + 7)
end
document hex_quad
print eight hexadecimal bytes starting at arg0
end

define hexdump
  printf "%08x : ", $arg0
  hex_quad $arg0
  printf " - "
  hex_quad ($arg0+8)
  printf " "

  ascii_char ($arg0)
  ascii_char ($arg0+1)
  ascii_char ($arg0+2)
  ascii_char ($arg0+3)
  ascii_char ($arg0+4)
  ascii_char ($arg0+5)
  ascii_char ($arg0+6)
  ascii_char ($arg0+7)
  ascii_char ($arg0+8)
  ascii_char ($arg0+9)
  ascii_char ($arg0+0xa)
  ascii_char ($arg0+0xb)
  ascii_char ($arg0+0xc)
  ascii_char ($arg0+0xd)
  ascii_char ($arg0+0xe)
  ascii_char ($arg0+0xf)

  printf "\n"
end
document hexdump
display a 16-byte hex/ascii dump of arg0
end


#________________data window__________________
define ddump
  echo \033[36m
  printf "[%04x:%08x]------------------------", $ds, $data_addr
  printf "---------------------------------[ data]\n"
  echo \033[34m
  set $_count=0
  while ( $_count < $arg0 )
    set $_i=($_count*0x10)
    hexdump ($data_addr+$_i)
    set $_count++
  end
end
document ddump
display $arg0 lines of hexdump for address $data_addr
end

define dd
  if ( ($arg0 & 0x40000000) || ($arg0 & 0x08000000) || ($arg0 & 0xbf000000) )
    set $data_addr=$arg0
    ddump 0x10
  else
    printf "invalid address: %08x\n", $arg0
  end
end
document dd
display 16 lines of a hex dump for $arg0
end

define datawin
  if ( ($esi & 0x40000000) || ($esi & 0x08000000) || ($esi & 0xbf000000) )
    set $data_addr=$esi
  else
    if ( ($edi & 0x40000000) || ($edi & 0x08000000) || ($edi & 0xbf000000) )
      set $data_addr=$edi
    else
      if ( ($eax & 0x40000000) || ($eax & 0x08000000) || \
	($eax & 0xbf000000) )
	set $data_addr=$eax
      else
	set $data_addr=$esp
      end
    end
  end
  ddump 2
end
document datawin
display esi, edi, eax, or esp in data window
end

#________________process context______________

define context
  echo \033[\033[36m\033]
  printf "----------------------------------------"
  printf "---------------------------------[ regs]\n"
  echo \033[32m
  reg
  echo \033[36m
  printf "[%04x:%08x]------------------------", $ss, $esp
  printf "---------------------------------[stack]\n"
  echo \033[34m
  hexdump $sp+0x30
  hexdump $sp+0x20
  hexdump $sp+0x10
  hexdump $sp
  datawin
  echo \033[36m
  printf "[%04x:%08x]------------------------", $cs, $eip
  printf "---------------------------------[ code]\n"
  echo \033[37m
  x /6i $pc
  echo \033[36m
  printf "---------------------------------------"
  printf "----------------------------------------\n"
  echo \033[0m
end
document context
print regs, stack, ds:esi, and disassemble cs:eip
end

define context-on
  set $show_context = 1
end
document context-on
enable display of context on every program stop
end

define context-off
  set $show_context = 1
end
document context-on
disable display of context on every program stop
end

#________________process control______________
define go
  stepi $arg0
end
document go
step # instructions
end

define pret
  finish
end
document pret
step out of current call
end

define init
  set $show_context = 1
  set $show_nest_insn=0
  tbreak _init
  r
end
document init
run program; break on _init()
end

define sstart
  set $show_context = 1
  set $show_nest_insn=0
  tbreak __libc_start_main
  r
end
document sstart
run program; break on __libc_start_main(). useful for stripped executables.
end

define main
  set $show_context = 1
  set $show_nest_insn=0
  tbreak main
  r
end
document main
run program; break on main()
end


#________________eflags commands_______________
define cfc
  if ($eflags & 1)
    set $eflags = $eflags&~1
  else
    set $eflags = $eflags|1
  end
end
document cfc
change carry flag
end


define cfp
  if (($eflags >> 2) & 1 )
    set $eflags = $eflags&~0x4
  else
    set $eflags = $eflags|0x4
  end
end
document cfp
change carry flag
end

define cfa
  if (($eflags >> 4) & 1 )
    set $eflags = $eflags&~0x10
  else
    set $eflags = $eflags|0x10
  end
end
document cfa
change auxiliary carry flag
end

define cfz
  if (($eflags >> 6) & 1 )
    set $eflags = $eflags&~0x40
  else
    set $eflags = $eflags|0x40
  end
end
document cfz
change zero flag
end

define cfs
  if (($eflags >> 7) & 1 )
    set $eflags = $eflags&~0x80
  else
    set $eflags = $eflags|0x80
  end
end
document cfs
change sign flag
end

define cft
  if (($eflags >>8) & 1 )
    set $eflags = $eflags&100
  else
    set $eflags = $eflags|100
  end
end
document cft
change trap flag
end

define cfi
  if (($eflags >> 9) & 1 )
    set $eflags = $eflags&~0x200
  else
    set $eflags = $eflags|0x200
  end
end
document cfi
change interrupt flag
end

define cfd
  if (($eflags >>0xa ) & 1 )
    set $eflags = $eflags&~0x400
  else
    set $eflags = $eflags|0x400
  end
end
document cfd
change direction flag
end

define cfo
  if (($eflags >> 0xb) & 1 )
    set $eflags = $eflags&~0x800
  else
    set $eflags = $eflags|0x800
  end
end
document cfo
change overflow flag
end

#--------------------patch---------------------
define nop
  set * (unsigned char *) $arg0 = 0x90
end
document nop
patch byte at address arg0 to a nop insn
usage: nop addr
end

define null
  set * (unsigned char *) $arg0 = 0
end
document null
patch byte at address arg0 to null
usage: null addr
end

define int3
  set * (unsigned char *) $arg0 = 0xcc
end
document int3
patch byte at address arg0 to an int3 insn
usage: int3 addr
end


#--------------------cflow---------------------
define print_insn_type
  if ($arg0 == 0)
    printf "unknown";
  end
  if ($arg0 == 1)
    printf "jmp";
  end
  if ($arg0 == 2)
    printf "jcc";
  end
  if ($arg0 == 3)
    printf "call";
  end
  if ($arg0 == 4)
    printf "ret";
  end
  if ($arg0 == 5)
    printf "int";
  end
end
document print_insn_type
this prints the human-readable mnemonic for the instruction typed passed as
a parameter (usually $insn_type).
end

define get_insn_type
  set $insn_type = 0
  set $_byte1=*(unsigned char *)$arg0
  if ($_byte1 == 0x9a || $_byte1 == 0xe8 )
    # "call"
    set $insn_type=3
  end
  if ($_byte1 >= 0xe9 && $_byte1 <= 0xeb)
    # "jmp"
    set $insn_type=1
  end
  if ($_byte1 >= 0x70 && $_byte1 <= 0x7f)
    # "jcc"
    set $insn_type=2
  end
  if ($_byte1 >= 0xe0 && $_byte1 <= 0xe3 )
    # "jcc"
    set $insn_type=2
  end
  if ($_byte1 == 0xc2 || $_byte1 == 0xc3 || $_byte1 == 0xca || $_byte1 == 0xcb ||
    $_byte1 == 0xcf)
    # "ret"
    set $insn_type=4
  end
  if ($_byte1 >= 0xcc && $_byte1 <= 0xce)
    # "int"
    set $insn_type=5
  end
  if ($_byte1 == 0x0f )
    # two-byte opcode
    set $_byte2=*(unsigned char *)($arg0 +1)
    if ($_byte2 >= 0x80 && $_byte2 <= 0x8f)
      # "jcc"
      set $insn_type=2
    end
  end
  if ($_byte1 == 0xff )
    # opcode extension
    set $_byte2=*(unsigned char *)($arg0 +1)
    set $_opext=($_byte2 & 0x38)
    if ($_opext == 0x10 || $_opext == 0x18)
      # "call"
      set $insn_type=3
    end
    if ($_opext == 0x20 || $_opext == 0x28)
      # "jmp"
      set $insn_type=1
    end
  end
end
document get_insn_type
this takes an address as a parameter and sets the global $insn_type variable
to 0, 1, 2, 3, 4, 5 if the instruction at the address is unknown, a jump,
a conditional jump, a call, a return, or an interrupt.
end

define step_to_call
  set $_saved_ctx = $show_context
  set $show_context = 0
  set $show_nest_insn=0
  set logging file /dev/null
  set logging on
  set logging redirect on
  set $_cont = 1
  while ( $_cont > 0 )
    stepi
    get_insn_type $pc
    if ($insn_type == 3)
      set $_cont = 0
    end
  end
  if ( $_saved_ctx > 0 )
    context
  else
    x /i $pc
  end
  set $show_context = 1
  set $show_nest_insn=0
  set logging redirect off
  set logging off
  set logging file gdb.txt
end
document step_to_call
this single steps until it encounters a call instruction; it stops before
the call is taken.
end

define trace_calls
  set $show_context = 0
  set $show_nest_insn=0
  set $_nest = 1
  set listsize 0
  set logging overwrite on
  set logging file ~/gdb_trace_calls.txt
  set logging on
  set logging redirect on
  while ( $_nest > 0 )
    get_insn_type $pc
    # handle nesting
    if ($insn_type == 3)
      set $_nest = $_nest + 1
    else
      if ($insn_type == 4)
	set $_nest = $_nest - 1
      end
    end
    # if a call, print it
    if ($insn_type == 3)
      set $x = $_nest
      while ( $x > 0 )
	printf "\t"
	set $x = $x - 1
      end
      x /i $pc
    end
    #set logging file /dev/null
    stepi
    #set logging file ~/gdb_trace_calls.txt
  end
  set $show_context = 1
  set $show_nest_insn=0
  set logging redirect off
  set logging off
  set logging file gdb.txt
  # clean up trace file
  shell grep -v ' at ' ~/gdb_trace_calls.txt > ~/gdb_trace_calls.1
  shell grep -v ' in ' ~/gdb_trace_calls.1 > ~/gdb_trace_calls.txt
end
document trace_calls
creates a runtime trace of the calls made target in ~/gdb_trace_calls.txt.
note that this is very slow because gdb "set redirect on" does not work!
end

define trace_run
  set $show_context = 0
  set $show_nest_insn=1
  set logging overwrite on
  set logging file ~/gdb_trace_run.txt
  set logging on
  set logging redirect on
  set $_nest = 1
  while ( $_nest > 0 )
    get_insn_type $pc
    # jmp, jcc, or cll
    if ($insn_type == 3)
      set $_nest = $_nest + 1
    else
      # ret
      if ($insn_type == 4)
	set $_nest = $_nest - 1
      end
    end
    stepi
  end
  set $show_context = 1
  set $show_nest_insn=0
  set logging file gdb.txt
  set logging redirect off
  set logging off
  # clean up trace file
  shell grep -v ' at ' ~/gdb_trace_run.txt > ~/gdb_trace_run.1
  shell grep -v ' in ' ~/gdb_trace_run.1 > ~/gdb_trace_run.txt
end
document trace_run
creates a runtime trace of the target in ~/gdb_trace_run.txt. note
that this is very slow because gdb "set redirect on" does not work!
end


#_____________________misc_____________________
# this makes 'context' be called at every bp/step
#define hook-stop
#  if ($show_context > 0)
#    context
#  end
#  if ($show_nest_insn > 0)
#    set $x = $_nest
#    while ($x > 0)
#      printf "\t"
#      set $x = $x - 1
#    end
#  end
#end

define assemble
  printf "hit ctrl-d to start, type code to assemble, hit ctrl-d when done.\n"
  printf "it is recommended to start with\n"
  printf "\tbits 32\n"
  printf "note that this command uses nasm (intel syntax) to assemble.\n"
  shell nasm -f bin -o /dev/stdout /dev/stdin | od -v -t x1 -w16 -a n
end
document assemble
assemble intel x86 instructions to binary opcodes. uses nasm.
usage: assemble
end

define gas_asm
  printf "type code to assemble, hit ctrl-d until results appear :)\n"
  printf "note that this command uses gas (at&t syntax) to assemble.\n"
  shell as -o ~/__gdb_tmp.bin
  shell objdump -d -j .text --adjust-vma=$arg0 ~/__gdb_tmp.bin
  shell rm ~/__gdb_tmp.bin
end
document gas_asm
assemble intel x86 instructions to binary opcodes using gas and objdump
usage: gas_asm address
end

# !scary bp_alloc macro!
# the idea behind this macro is to break on the following code:
#0x4008e0aa <malloc+6>: sub $0xc,%esp
# 0x4008e0ad <malloc+9>: call 0x4008e0b2 <malloc+14>
# 0x4008e0b2 <malloc+14>: pop %ebx
# 0x4008e0b3 <malloc+15>: add $0xa3f6e,%ebx
# at 0x4008e0b3, %ebx contains the address that has just been allocated
# the bp_alloc macro generates this breakpoint and *should* work for
# the forseeable future ... but if it breaks, set a breakpoint on
# __libc_malloc and look for where where the return value gets popped.
define bp_alloc
  tbreak *(*__libc_malloc + f) if $ebx == $arg0
end
document bp_alloc
this sets a temporary breakpoint on the allocation of $arg0.
it works by setting a breakpoint on a specific address in __libc_malloc().
use with caution -- it is extremely platform dependent.
 usage: bp_alloc addr
end

define dump_hexfile

  dump ihex memory $arg0 $arg1 $arg2
end
document dump_hexfile
write a range of memory to a file in intel ihex (hexdump) format.
usage:
dump_hexfile filename start_addr end_addr
end

define dump_binfile
  dump memory $arg0 $arg1 $arg2
end
document dump_binfile
write a range of memory to a binary file.
usage:
dump_binfile filename start_addr end_addr
end

#_________________cracker tips_________________
# the 'tips' command is used to provide tutorial-like info to the user

define tips
  printf "tip topic commands:\n"
  printf "\ttip_display : automatically display values on each break\n"
  printf "\ttip_patch : patching binaries\n"
  printf "\ttip_strip : dealing with stripped binaries\n"
  printf "\ttip_syntax : att vs intel syntax\n"
end
document tips
provide a list of tips from crackers on various topics.
end

define tip_patch
  printf "\n"
  printf "patching memory\n"
  printf "any address can be patched using the 'set' command:\n"
  printf "\t`set addr = value` \te.g. `set *0x8049d6e = 0x90`\n"
  printf "\n"
  printf "patching binary files\n"
  printf "use `set write` in order to patch the target executable\n"
  printf "directly, instead of just patching memory.\n"
  printf "\t`set write on` \t`set write off`\n"
  printf "note that this means any patches to the code or data segments\n"
  printf "will be written to the executable file. when either of these\n"
  printf "commands has been issued, the file must be reloaded.\n"
  printf "\n"
end
document tip_patch
tips on patching memory and binary files
end

define tip_strip
  printf "\n"
  printf "stopping binaries at entry point\n"
  printf "stripped binaries have no symbols, and are therefore tough to\n"
  printf "start automatically. to debug a stripped binary, use\n"
  printf "\tinfo file\n"
  printf "to get the entry point of the file. the first few lines of\n"
  printf "output will look like this:\n"
  printf "\tsymbols from '/tmp/a.out'\n"
  printf "\tlocal exec file:\n"
  printf "\t`/tmp/a.out', file type elf32-i386.\n"
  printf "\tentry point: 0x80482e0\n"
  printf "use this entry point to set an entry point:\n"
  printf "\t`tbreak *0x80482e0`\n"
  printf "the breakpoint will delete itself after the program stops as\n"
  printf "the entry point.\n"
  printf "\n"
end
document tip_strip
tips on dealing with stripped binaries
end

define tip_syntax
  printf "\n"
  printf "\tintel syntax at&t syntax\n"
  printf "\tmnemonic dest, src, imm mnemonic src, dest, imm\n"
  printf "\t[base+index*scale+disp] disp(base, index, scale)\n"
  printf "\tregister: eax register: %%eax\n"
  printf "\timmediate: 0xff immediate: $0xff\n"
  printf "\tdereference: [addr] dereference: addr(,1)\n"
  printf "\tabsolute addr: addr absolute addr: *addr\n"
  printf "\tbyte insn: mov byte ptr byte insn: movb\n"
  printf "\tword insn: mov word ptr word insn: movw\n"
  printf "\tdword insn: mov dword ptr dword insn: movd\n"
  printf "\tfar call: call far far call: lcall\n"
  printf "\tfar jump: jmp far far jump: ljmp\n"
  printf "\n"
  printf "note that order of operands in reversed, and that at&t syntax\n"
  printf "requires that all instructions referencing memory operands \n"
  printf "use an operand size suffix (b, w, d, q).\n"
  printf "\n"
end
document tip_syntax
summary of intel and at&t syntax differences
end

define tip_display
  printf "\n"
  printf "any expression can be set to automatically be displayed every time\n"
  printf "the target stops. the commands for this are:\n"
  printf "\t`display expr' : automatically display expression 'expr'\n"
  printf "\t`display' : show all displayed expressions\n"
  printf "\t`undisplay num' : turn off autodisplay for expression # 'num'\n"
  printf "examples:\n"
  printf "\t`display/x *(int *)$esp` : print top of stack\n"
  printf "\t`display/x *(int *)($ebp+8)` : print first parameter\n"
  printf "\t`display (char *)$esi` : print source string\n"
  printf "\t`display (char *)$edi` : print destination string\n"
  printf "\n"
end
document tip_display
tips on automatically displaying values when a program stops.
end


#__________________gdb options_________________
set confirm off
set verbose off
set history save on
set print pretty
set prompt \033[1;32mgdb\033[1;30m$ \033[0;0m
#\033[\033[31;m\033] gdb $ \033[0m

set output-radix 0x10
set input-radix 0x10
# these make gdb never pause in its output
set height 0
set width 0
# why do these not work???
set $show_context = 1
set $show_nest_insn=0
set disassembly-flavor intel
#eof
