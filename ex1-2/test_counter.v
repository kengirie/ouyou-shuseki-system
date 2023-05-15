`timescale 1ps / 1ps
module test_counter();
parameter CLK = 1000000/10; // 10MHz
// for input
reg clk; reg rst;
// for output
wire [6:0] count;
// module
  counter counter0(
.clk (clk), .rst (rst), .count(count));
// clock generation
always begin
clk = 1'b1;
#(CLK/2); clk = 1'b0;
#(CLK/2);
end

// test senario
initial begin
  $dumpfile("test_counter.vcd");
  $dumpvars(1, test_counter);
rst = 1;
#(CLK); rst = 0;
#(CLK*120); rst = 1;
#(CLK*10);rst = 0;
#(CLK*120);
$finish;
end
endmodule
