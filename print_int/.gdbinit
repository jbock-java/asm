set debuginfod enabled off
lay asm
define hook-quit
	set confirm off
end
break print_int_pop_loop
