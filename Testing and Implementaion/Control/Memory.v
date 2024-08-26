module Memory 
#(parameter DATA_WIDTH=16)
(
	input [(DATA_WIDTH - 1):0] data,
	input [(DATA_WIDTH - 1):0] sr1,
	input [(DATA_WIDTH - 1):0] sr2,
	input [(DATA_WIDTH - 1):0] sr3,
	input [(DATA_WIDTH - 1):0] rd,
	input [(DATA_WIDTH - 1):0] pc,
	input [(DATA_WIDTH - 1):0] two,
	input MEMWRITE, WRITEZERO, clk,
	output [(DATA_WIDTH - 1):0] IRO,
	output [(DATA_WIDTH - 1):0] IRT,
	output [(DATA_WIDTH - 1):0] out1,
	output [(DATA_WIDTH - 1):0] out2,
	output [(DATA_WIDTH - 1):0] out3
);

	// Declare the RAM variable
	reg [(DATA_WIDTH - 1):0] ram[2**(DATA_WIDTH - 1):0];

	// Variable to hold the registered read address
	reg [(DATA_WIDTH - 1):0] addr_regPC;
	reg [(DATA_WIDTH - 1):0] addr_regPC2;
	reg [(DATA_WIDTH - 1):0] addr_reg1;
	reg [(DATA_WIDTH - 1):0] addr_reg2;
	reg [(DATA_WIDTH - 1):0] addr_reg3;

	always @ (posedge clk)
	begin
		// Write
		if (MEMWRITE)
			ram[rd] <= data;
		if (WRITEZERO)
			ram[two] <= 0;
	
		addr_regPC <= pc;
		addr_regPC2 <= two;
		addr_reg1 <= sr1;
		addr_reg2 <= sr2;
		addr_reg3 <= sr3;
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign IRO = ram[addr_regPC];
	assign IRT = ram[addr_regPC2];
	assign out1 = ram[addr_reg1];
	assign out2 = ram[addr_reg2];
	assign out3 = ram[addr_reg3];

endmodule
