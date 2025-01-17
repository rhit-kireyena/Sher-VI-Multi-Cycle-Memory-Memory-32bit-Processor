`timescale 1ns/1ps

module test_reg_ALU_ALUOUT();

  parameter HALF_PERIOD = 50;

  reg signed [15:0] regA_data, regB_data; //3 Registers
  reg CLK;
  reg regA_reset, regB_reset, ALUOUT_reset;
  wire signed [15:0] regA_out, regB_out, ALUOUT_out, ALU_out;
  reg[2:0] funct3;
  reg regA_ctrl, regB_ctrl, ALUOUT_ctrl;
  wire unsigned cmp;

  // Assuming you have separate modules for register and ALU, include them here
  
  // Register module declaration
  register regA (
    .data_in(regA_data),
    .clk(CLK),
    .data_out(regA_out),
    .ctrl(regA_ctrl),
    .reset(regA_reset)
  );

  register regB (
    .data_in(regB_data),
    .clk(CLK),
    .data_out(regB_out),
    .ctrl(regB_ctrl),
    .reset(regB_reset)
  );

  // ALU module declaration
  ALU alu(
    .A(regA_out),
    .B(regB_out),
    .funct3(funct3),
    .cmp(cmp),
    .ALUOUT(ALU_out)
  );

  // Another register for ALU output
  register ALUOUT (
    .data_in(ALU_out),
    .clk(CLK),
    .data_out(ALUOUT_out),
    .ctrl(ALUOUT_ctrl),
    .reset(ALUOUT_reset)
  );

  initial begin
    CLK = 0;
    forever begin
      #(HALF_PERIOD);
      CLK = ~CLK;
    end
  end

  initial begin
    // Reset signals
    regA_reset = 1;
    regB_reset = 1;
    ALUOUT_reset = 1;
    
    #(2*HALF_PERIOD);
    
    regA_reset = 0;
    regB_reset = 0;
    ALUOUT_reset = 0;
	 regA_ctrl = 0;
	 regB_ctrl = 0;
	 ALUOUT_ctrl = 0;
	 $display("All register values reset, all control values set to 0");
	 
	 //Set inputs
	 regA_data = ($random%16384);
	 regB_data = ($random%16384);
	 
	 //Set ctrl bits
	 $display("Testing control bits for input registers, Register A input = %d, Register B input = %d", regA_data, regB_data);
	 $display("Control bits off, Register A output = %d, Register B output = %d", regA_out, regB_out);
	 regA_ctrl = 1;
	 regB_ctrl = 1;
	 #(2*HALF_PERIOD);
	 $display("Control bits on, Register A output = %d, Register B output = %d", regA_out, regB_out);
	 regA_ctrl = 0;
	 regB_ctrl = 0;

	//Test reset
	$display("Testing reset bits for input registers, Register A input = %d, Register B input = %d", regA_data, regB_data);
	 $display("Reset bits off, Register A output = %d, Register B output = %d", regA_out, regB_out);
	 regA_reset = 1;
	 #(2*HALF_PERIOD);
	$display("Reset bit A on, Register A output = %d, Register B output = %d", regA_out, regB_out);
	regB_reset = 1;
	 #(2*HALF_PERIOD);
	$display("Reset bits both on, Register A output = %d, Register B output = %d", regA_out, regB_out);
	regA_reset = 0;
  	  regB_reset = 0;
	regA_ctrl = 1;
	 regB_ctrl = 1;

	//Test ALU
	$display("Testing ALU functions, Register A input = %d, Register B input = %d", regA_data, regB_data);
	funct3 = 0;
	#(2*HALF_PERIOD);
	$display("Testing addition, Register A input = %d, Register B input = %d, ALU output = %d", regA_data, regB_data, ALU_out);
	funct3 = 2;
	#(2*HALF_PERIOD);
	$display("Testing or, Register A input = %d, Register B input = %d, ALU output = %d", regA_data, regB_data, ALU_out);
	//Test ALUOUT register
	
	$display("Testing ALUOUT register, ALUOUT register ctrl bit off");
	$display("ALUOUT input = %d, ALUOUT output = %d", ALU_out, ALUOUT_out);
	 ALUOUT_ctrl = 1;
	#(2*HALF_PERIOD);
	$display("Testing ALUOUT register, ALUOUT register ctrl bit on");
	$display("ALUOUT input = %d, ALUOUT output = %d", ALU_out, ALUOUT_out);
	

  end
  
endmodule