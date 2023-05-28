module framebuf_bst(
   // Outputs
   rcv_req, pixel_a_out, pixel_b_out, pixel_c_out, snd_ack,
   // Inputs
   clk, xrst, pixel_a_in, pixel_b_in, pixel_c_in, rcv_ack, snd_req
   );
   // parameter
   parameter PIXEL_NUM = 128 * 128;

   // clock, reset
   input 	clk;
   input 	xrst;

   // receive port (MASTER)
   input [7:0] pixel_a_in;
   input [7:0] pixel_b_in;
   input [7:0] pixel_c_in;
   output      rcv_req;
   input       rcv_ack;

   // send port (SLAVE)
   output [7:0] pixel_a_out;
   output [7:0] pixel_b_out;
   output [7:0] pixel_c_out;
   input 	snd_req;
   output 	snd_ack;

   // state machine
   reg [2:0]   state_reg;
   parameter   ST_WAIT_RCV_ACK_UP     = 3'd0;
	parameter   ST_BURST_RCV_FIRST = 3'd1;
   parameter   ST_BURST_RCV = 3'd2;
   parameter   ST_WAIT_SND_REQ      = 3'd3;
   parameter   ST_BURST_SND     = 3'd4;
	
   // memory
   reg [23:0] 	mem[0:PIXEL_NUM-1];
   reg [13:0] 	mem_addr;
   wire		mem_we;
   wire [23:0] 	mem_din;
   reg [23:0] 	mem_dout;
	
   // state machine
   always @(negedge clk or negedge xrst) begin
      if (xrst == 1'b0)
	state_reg <= ST_WAIT_RCV_ACK_UP;
      else
        case (state_reg)
          ST_WAIT_RCV_ACK_UP:
            if (rcv_ack == 1'b1)
	      state_reg <= ST_BURST_RCV;
          ST_BURST_RCV:
            if (rcv_ack == 1'b0)
	      if (mem_addr == PIXEL_NUM-1)
		state_reg <= ST_WAIT_SND_REQ;
          ST_WAIT_SND_REQ:
            if (snd_req == 1'b1)
	      state_reg <= ST_BURST_SND;
	  ST_BURST_SND:
            if (snd_req == 1'b0)
	      if (mem_addr == PIXEL_NUM-1)
		 state_reg <= ST_WAIT_RCV_ACK_UP;
	endcase
   end
	
	assign mem_din = {pixel_a_in,pixel_b_in,pixel_c_in};
   assign mem_we = (state_reg == ST_BURST_RCV || state_reg == ST_BURST_RCV_FIRST) ? 1'b1 : 1'b0;
	  
   // memory
   always @(negedge clk or negedge xrst) begin
      if (xrst == 1'b0)
	mem_addr <= 14'd0;
      else
	if (state_reg == ST_BURST_RCV || state_reg == ST_BURST_SND)
	  if (mem_addr == PIXEL_NUM-1)
	    mem_addr <= 14'd0;
	  else
	    mem_addr <= mem_addr + 14'd1;
   end
	  
   always @(posedge clk) begin
      mem_dout <= mem[mem_addr];
      if (mem_we == 1'b1)
        mem[mem_addr] <= mem_din;
   end
	
   // output
   assign rcv_req = (xrst == 1'b1 && state_reg == ST_WAIT_RCV_ACK_UP) ? 1'b1 : 1'b0;
   assign snd_ack = (state_reg == ST_BURST_SND) ? 1'b1 : 1'b0;

   assign pixel_a_out = mem_dout[23:16];
   assign pixel_b_out = mem_dout[15:8];
   assign pixel_c_out = mem_dout[7:0];

endmodule