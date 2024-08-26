module ALU(
input [2:0] funct3,
input signed [15:0] A,
input signed [15:0] B,
output reg signed [15:0] ALUOUT,
output reg unsigned cmp
);


always @(funct3, A, B)
begin
	cmp = 0;
	case(funct3)
		0: ALUOUT <= A + B;
		1: ALUOUT <= A - B;
		2: ALUOUT <= A ^ B;
		3: ALUOUT <= A | B;
		4: ALUOUT <= A & B;
		5: ALUOUT <= A << B;
		6: ALUOUT <= A >> B;
		7: ALUOUT <= A >>> B;
		default:
			begin
				ALUOUT <= 0;
			end
	endcase
	
	case(funct3[1:0])
	0: 
		begin
			if(A == B)
				cmp = 1;
			else
				cmp = 0;
		end
	1:
		begin
			if(A != B)
				cmp = 1;
			else
				cmp = 0;
		end
	2:
		begin
			if(A < B)
				cmp = 1;
			else
				cmp = 0;
		end
	3: 
		begin
			if(A >= B)
				cmp = 1;
			else
				cmp = 0;
		end 
	default:
		begin
			cmp = 0;
		end
	endcase
end


endmodule