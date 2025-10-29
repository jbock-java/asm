set debuginfod enabled off
lay asm
define hook-quit
	set confirm off
end
break write_string
display $rsi
