module SL(
input [15:0] data_in,
output wire [15:0] data_out
);

assign data_out = (data_in << 1);

endmodule