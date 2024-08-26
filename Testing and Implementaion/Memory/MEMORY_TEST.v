`timescale 1 ns / 1 ps
module MEMORY_TEST();
	parameter HALF_PERIOD = 50;
	parameter DATA_WIDTH = 16;
	parameter TEST_1 = 5;
	parameter TEST_2 = 10;
	parameter TEST_3 = 13;
	parameter TEST_4 = 27;
	parameter TEST_5 = 56;
	
	reg CLK;
	reg unsigned MEMWRITE;
	reg unsigned WRITEZERO;
	reg signed [DATA_WIDTH - 1:0] data;
	reg unsigned [DATA_WIDTH - 1:0] sr1;
	reg unsigned [DATA_WIDTH - 1:0] sr2;
	reg unsigned [DATA_WIDTH - 1:0] sr3;
	reg unsigned [DATA_WIDTH - 1:0] rd;
	reg unsigned [DATA_WIDTH - 1:0] pc;
	reg unsigned [DATA_WIDTH - 1:0] two;
	wire	signed [DATA_WIDTH - 1:0] IRO;
	wire	signed	[DATA_WIDTH - 1:0] IRT;
	wire	signed	[DATA_WIDTH - 1:0] out1;
	wire	signed	[DATA_WIDTH - 1:0] out2;
	wire	signed	[DATA_WIDTH - 1:0] out3;
	
	Memory UUT
(
	.data(data) ,	// input [DATA_WIDTH-1:0] data
	.sr1(sr1) ,	// input [DATA_WIDTH-1:0] sr1
	.sr2(sr2) ,	// input [DATA_WIDTH-1:0] sr2
	.sr3(sr3) ,	// input [DATA_WIDTH-1:0] sr3
	.rd(rd) ,	// input [DATA_WIDTH-1:0] rd
	.pc(pc) ,	// input [DATA_WIDTH-1:0] pc
	.two(two) ,	// input [DATA_WIDTH-1:0] two
	.MEMWRITE(MEMWRITE) ,	// input  MEMWRITE
	.WRITEZERO(WRITEZERO) ,	// input  WRITEZERO
	.clk(CLK) ,	// input  clk
	.IRO(IRO) ,	// output [DATA_WIDTH-1:0] IRO
	.IRT(IRT) ,	// output [DATA_WIDTH-1:0] IRT
	.out1(out1) ,	// output [DATA_WIDTH-1:0] out1
	.out2(out2) ,	// output [DATA_WIDTH-1:0] out2
	.out3(out3) 	// output [DATA_WIDTH-1:0] out3
);

initial begin
	CLK = 0;
	forever begin
		#(HALF_PERIOD);
		CLK = ~CLK;
	end
end

initial begin
CLK = 0;
MEMWRITE = 0;
WRITEZERO = 0;
data = 0;
sr1 = 0;
sr2 = 0;
sr3 = 0;
rd = 0;
pc = 0;
two = 2;
#(10 * HALF_PERIOD);
//Writing some values
$display("Testing Make. rd = 0, data = %d, rd = 2, data = %d", TEST_1, TEST_2);
rd = 0;
data = TEST_1;
MEMWRITE = 1;
#(2 * HALF_PERIOD);
data = TEST_2;
rd = 2;
#(2 * HALF_PERIOD);
MEMWRITE = 0;

//Testing Fetch Instruction
$display("Testing Fetch. pc = 0, two = 2");
pc = 0;
two = 2;
#(2 * HALF_PERIOD);
$display("IRO: %d, IRT: %d", IRO, IRT);
if(IRO == TEST_1)
	$display("IRO Correct!");
else
	$display("IRO WRONG!");
if(IRT == TEST_2)
	$display("IRT Correct!");
else
	$display("IRT WRONG!");
//Testing sources
$display("Writing Values. rd = 4, data = %d rd = 6, data = %d", TEST_3, TEST_4);
rd = 4;
data = TEST_3;
MEMWRITE = 1;
#(2 * HALF_PERIOD);
rd = 6;
data = TEST_4;
#(2 * HALF_PERIOD);
MEMWRITE = 0;
$display("Reading sources. sr1 = 2, sr2 = 4, sr3 = 6.");
sr1 = 2;
sr2 = 4;
sr3 = 6;
#(2 * HALF_PERIOD);
$display("A = %d, B = %d, C = %d", out1, out2, out3);
if(out1 == TEST_2)
	$display("out1 correct");
if(out2 == TEST_3)
	$display("out2 correct");
if(out3 == TEST_4)
	$display("out3 correct");
//Testing Write0
$display("Testing Writing for Branches. Data = %d, rd = 0, two = 2", TEST_5);
data = TEST_5;
rd = 0;
two = 2;
MEMWRITE = 1;
WRITEZERO = 1;
#(2 * HALF_PERIOD);
MEMWRITE = 0;
WRITEZERO = 0;
sr1 = 0;
sr2 = 2;
#(2 * HALF_PERIOD);
$display("sr1 = 0, sr2 = 2, out1 = %d, out2 = %d", out1, out2);
if(out1 == TEST_5)
	$display("out1 Correct!");
if(out2 == 0)
	$display("ou2 Correct!");

$stop;
end
endmodule


