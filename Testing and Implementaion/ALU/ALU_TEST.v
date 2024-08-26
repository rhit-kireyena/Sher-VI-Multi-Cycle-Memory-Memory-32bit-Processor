`timescale 1 ns / 1 ps
module ALU_TEST();

parameter HALF_PERIOD = 50;

reg CLK;
reg reset;
reg [2:0] funct3;
reg signed [15:0] A;
reg signed [15:0] B;
wire signed [15:0] ALUOUT;
wire unsigned cmp;

ALU ALU_inst
(
	.funct3(funct3) ,	// input [2:0] funct3_sig
	.A(A) ,	// input [15:0] A_sig
	.B(B) ,	// input [15:0] B_sig
	.ALUOUT(ALUOUT) ,	// output [15:0] ALUOUT_sig
	.cmp(cmp) 	// output  cmp_sig
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
reset = 1;
funct3 = 0;
#(10 * HALF_PERIOD);
reset = 0;
#(10 * HALF_PERIOD);

//Add
reset = 1;
#(2 * HALF_PERIOD);
reset = 0;
funct3 = 0;
A = 4;
B = 5;
#(10 * HALF_PERIOD);
$display("Add : A + B = ALUOUT : %d + %d = %d", A, B, ALUOUT);
if(ALUOUT == A + B)
$display("Correct!");
else
$display("Wrong!");

//Sub
reset = 1;
#(2 * HALF_PERIOD);
reset = 0;
funct3 = 1;
A = 10;
B = 4;
#(10 * HALF_PERIOD);
$display("Sub : A - B = ALUOUT : %d - %d = %d", A, B, ALUOUT);
if(ALUOUT == A - B)
$display("Correct!");
else
$display("Wrong!");

//Xor
reset = 1;
#(2 * HALF_PERIOD);
reset = 0;
funct3 = 2;
A = 14;
B = 7;
#(10 * HALF_PERIOD);
$display("Xor : A ^ B = ALUOUT : %d ^ %d = %d", A, B, ALUOUT);
if(ALUOUT == A ^ B)
$display("Correct!");
else
$display("Wrong!");

//Or
reset = 1;
#(2 * HALF_PERIOD);
reset = 0;
funct3 = 3;
A = 5;
B = 6;
#(10 * HALF_PERIOD);
$display("Or : A | B = ALUOUT : %d | %d = %d", A, B, ALUOUT);
if(ALUOUT == A | B)
$display("Correct!");
else
$display("Wrong!");

//And
reset = 1;
#(2 * HALF_PERIOD);
reset = 0;
funct3 = 4;
A = 11;
B = 5;
#(10 * HALF_PERIOD);
$display("And : A & B = ALUOUT : %d & %d = %d", A, B, ALUOUT);
if(ALUOUT == (A & B))
$display("Correct!");
else
$display("Wrong!");

//Sll
reset = 1;
#(2 * HALF_PERIOD);
reset = 0;
funct3 = 5;
A = 3;
B = 2;
#(10 * HALF_PERIOD);
$display("Sll : A << B = ALUOUT : %d << %d = %d", A, B, ALUOUT);
if(ALUOUT == (A << B))
$display("Correct!");
else
$display("Wrong!");

//Srl
reset = 1;
#(2 * HALF_PERIOD);
reset = 0;
funct3 = 6;
A = 7;
B = 2;
#(10 * HALF_PERIOD);
$display("Srl : A >> B = ALUOUT : %d >> %d = %d", A, B, ALUOUT);
if(ALUOUT == (A >> B))
$display("Correct!");
else
$display("Wrong!");

//Sra
reset = 1;
#(2 * HALF_PERIOD);
reset = 0;
funct3 = 7;
A = -2000;
B = 1;
#(10 * HALF_PERIOD);
$display("Sra : A >>> B = ALUOUT : %d >>> %d = %d", A, B, ALUOUT);
if(ALUOUT == (A >>> B))
$display("Correct!");
else
$display("Wrong!, A = %d, B = %d, ALUOUT = %d, A >>> B = %d", A, B, ALUOUT, A >>> B);

//eq
reset = 1;
#(2 * HALF_PERIOD);
reset = 0;
funct3 = 0;
A = 1;
B = 1;
#(10 * HALF_PERIOD);
$display("Comparing: Equals. A = %d, B = %d, cmp = %d", A, B, cmp);
if(cmp == 1)
$display("Correct!");
else
$display("Wrong! cmp should be 1.");

//eq
reset = 1;
#(2 * HALF_PERIOD);
reset = 0;
funct3 = 4;
A = 2;
B = 1;
#(10 * HALF_PERIOD);
$display("Comparing: Equals. A = %d, B = %d, cmp = %d", A, B, cmp);
if(cmp == 0)
$display("Correct!");
else
$display("Wrong! cmp should be 0.");

//ne
reset = 1;
#(2 * HALF_PERIOD);
reset = 0;
funct3 = 1;
A = 2;
B = 1;
#(10 * HALF_PERIOD);
$display("Comparing: Not Equals. A = %d, B = %d, cmp = %d", A, B, cmp);
if(cmp == 1)
$display("Correct!");
else
$display("Wrong! cmp should be 1.");

//ne
reset = 1;
#(2 * HALF_PERIOD);
reset = 0;
funct3 = 5;
A = 1;
B = 1;
#(10 * HALF_PERIOD);
$display("Comparing: Not Equals. A = %d, B = %d, cmp = %d", A, B, cmp);
if(cmp == 0)
$display("Correct!");
else
$display("Wrong! cmp should be 0.");

//lt
reset = 1;
#(2 * HALF_PERIOD);
reset = 0;
funct3 = 2;
A = 0;
B = 1;
#(10 * HALF_PERIOD);
$display("Comparing: Less Than. A = %d, B = %d, cmp = %d", A, B, cmp);
if(cmp == 1)
$display("Correct!");
else
$display("Wrong! cmp should be 1.");

//lt
reset = 1;
#(2 * HALF_PERIOD);
reset = 0;
funct3 = 6;
A = 3;
B = 1;
#(10 * HALF_PERIOD);
$display("Comparing: Less Than. A = %d, B = %d, cmp = %d", A, B, cmp);
if(cmp == 0)
$display("Correct!");
else
$display("Wrong! cmp should be 0.");

//lt
reset = 1;
#(2 * HALF_PERIOD);
reset = 0;
funct3 = 6;
A = 1;
B = 1;
#(10 * HALF_PERIOD);
$display("Comparing: Less Than. A = %d, B = %d, cmp = %d", A, B, cmp);
if(cmp == 0)
$display("Correct!");
else
$display("Wrong! cmp should be 0.");

//ge
reset = 1;
#(2 * HALF_PERIOD);
reset = 0;
funct3 = 3;
A = 1;
B = 1;
#(10 * HALF_PERIOD);
$display("Comparing: Greater Than Equals. A = %d, B = %d, cmp = %d", A, B, cmp);
if(cmp == 1)
$display("Correct!");
else
$display("Wrong! cmp should be 1.");

//ge
reset = 1;
#(2 * HALF_PERIOD);
reset = 0;
funct3 = 7;
A = 3;
B = 1;
#(10 * HALF_PERIOD);
$display("Comparing: Greater Than Equals. A = %d, B = %d, cmp = %d", A, B, cmp);
if(cmp == 1)
$display("Correct!");
else
$display("Wrong! cmp should be 1.");

//ge
reset = 1;
#(2 * HALF_PERIOD);
reset = 0;
funct3 = 7;
A = 0;
B = 1;
#(10 * HALF_PERIOD);
$display("Comparing: Greater Than Equals. A = %d, B = %d, cmp = %d", A, B, cmp);
if(cmp == 0)
$display("Correct!");
else
$display("Wrong! cmp should be 0.");

$stop;
end

endmodule