module counter(clk, rst, count);

 input clk;
 input rst;
 output [6:0] count;

 reg [6:0] count_reg;

 always @(posedge clk or posedge rst) begin
  if (rst)
  count_reg <= 7'b0000000;
  else begin
    if (count_reg == 7'd100)
      count_reg <= 7'b0000000;
    else
      count_reg <= count_reg +1;

  end
 end
 assign count = count_reg;

 endmodule
