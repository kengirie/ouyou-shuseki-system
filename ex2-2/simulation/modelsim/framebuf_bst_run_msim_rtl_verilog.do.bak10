transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/ku-admin/Desktop/ouyou-shuseki-system/ex2-2 {C:/Users/ku-admin/Desktop/ouyou-shuseki-system/ex2-2/framebuf_bst.v}

vlog -vlog01compat -work work +incdir+C:/Users/ku-admin/Desktop/ouyou-shuseki-system/ex2-2/../../ex2 {C:/Users/ku-admin/Desktop/ouyou-shuseki-system/ex2-2/../../ex2/test_framebuf_bst.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  test_framebuf_bst

add wave *
view structure
view signals
run -all
