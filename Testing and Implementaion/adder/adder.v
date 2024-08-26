module adder(
input [15:0] data_A,
input [15:0] data_B,
input sub,
output wire [15:0] data_out
);

assign data_out = (sub == 0) ? (data_A + data_B) : (data_A - data_B);

endmodule