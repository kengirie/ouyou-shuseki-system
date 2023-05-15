`timescale 1ps / 1ps
module test_fsm();
parameter CLK = 1000000/10; // 10MHz
// for input
reg clk; reg start; reg stop; reg mode;
// for output
wire [1:0] state;
// module
  fsm fsm0(
.clk (clk), .start (start), .stop (stop), .mode (mode), .state (state) );
// clock generation
always begin
clk = 1'b1; #(CLK/2); clk = 1'b0; #(CLK/2);
end

// test senario
initial begin
  $dumpfile("test_fsm.vcd");
  $dumpvars(1, test_fsm);
start = 0; stop = 0;mode = 0;
#(CLK/2); start = 1;
#(CLK); mode = 1;
#(CLK*2); mode = 0;
#(CLK); stop = 1;
#(CLK*3);
$finish;
end
endmodule
