transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/ku-admin/Downloads/ex0/ex0 {C:/Users/ku-admin/Downloads/ex0/ex0/adder8.v}

vlog -vlog01compat -work work +incdir+C:/Users/ku-admin/Desktop/adder8/../../Downloads/ex0/ex0 {C:/Users/ku-admin/Desktop/adder8/../../Downloads/ex0/ex0/testbench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
