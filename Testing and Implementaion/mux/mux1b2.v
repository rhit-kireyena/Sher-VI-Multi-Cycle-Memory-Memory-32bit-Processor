module mux1b2(
	input [15:0] data_A,
	input [15:0] data_B,
	input ctrl,
	output reg [15:0] data_out
	

);

always@(data_A or data_B or ctrl)
begin
	if(!ctrl)
		data_out <= data_A;
	else
		data_out <= data_B;
end
	


endmodule