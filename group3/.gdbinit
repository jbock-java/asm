set debuginfod enabled off
lay asm
define hook-quit
	set confirm off
end
break string_compare
