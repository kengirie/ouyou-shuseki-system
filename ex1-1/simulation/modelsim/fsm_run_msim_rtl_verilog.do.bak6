transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/ku-admin/Desktop/ouyou-shuseki-system/ex1-1 {C:/Users/ku-admin/Desktop/ouyou-shuseki-system/ex1-1/fsm.v}

vlog -vlog01compat -work work +incdir+C:/Users/ku-admin/Desktop/ouyou-shuseki-system/ex1-1 {C:/Users/ku-admin/Desktop/ouyou-shuseki-system/ex1-1/test_fsm.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  test_fsm

add wave *
view structure
view signals
run -all
