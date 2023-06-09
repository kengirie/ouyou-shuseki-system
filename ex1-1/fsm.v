module fsm(clk, start, stop, mode, state);

input clk;
input start;
input stop;
input mode;
output [1:0] state;

reg [1:0] st_reg = 2'd0;

// state name
parameter INIT = 2'd0;
parameter RUN = 2'd1;
parameter WAIT = 2'd2;

always @(posedge clk) begin
if (st_reg == INIT && start == 1)
 st_reg <= RUN;

if (st_reg == RUN && mode == 1)
 st_reg <= INIT;
 else if (st_reg == RUN && mode == 0)
 st_reg <= WAIT;

if (st_reg == WAIT && stop == 1)
st_reg <= INIT;

end

assign state = st_reg;

endmodule
