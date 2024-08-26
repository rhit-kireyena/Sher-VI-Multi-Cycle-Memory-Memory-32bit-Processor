module register(
	input clk,
	input signed [15:0] data_in,
	input ctrl,
	input reset,
	output reg signed [15:0] data_out
	

);

always@(posedge clk)
begin
	if(ctrl && !reset)
		data_out <= data_in;
		else if (reset)
		data_out = 0;
end

endmodule