`timescale 1ns / 1ps

// test bench
module tb_mux1b2();

// inputs
reg clk;
reg ctrl;
reg unsigned [15:0] data_A;
reg unsigned [15:0] data_B;

// output
wire unsigned [15:0] data_out;

// module
mux1b2 UUT
(
	.clk(clk) ,	// input  clk
	.ctrl(ctrl) ,	// input  ctrl
	.data_A(data_A) ,	// input  data_A
	.data_B(data_B) ,	// input  data_B
	.data_out(data_out) 	// output  data_out
);

parameter HALF_PERIOD = 50;
integer failures = 0;

initial begin
    clk = 0;
    forever begin
        #(HALF_PERIOD);
        clk = ~clk;
    end
end

// apply stimulus and check output
initial begin
    //set inputs
    data_A = 100;
	 data_B = 200;
    ctrl = 0;
	 clk = 0;
	 
    // wait a lil bit
    #1;
    
	 
    	//-----TEST 1-----
	//Testing Ctrl Bit 0 (Output A) 
	$display("Testing output A. Input A = %d, Input B = %d", data_A, data_B);
	#(2*HALF_PERIOD);
	ctrl = 0;
	$display("Control bit = %d", ctrl);
	#(2*HALF_PERIOD);
	$display("Output = %d", data_out);
	if (data_out != data_A) begin
       			failures = failures + 1;
       			$display("%t (OUT) CTRL 0: Error, output = %d, expecting = %d", $time, data_out, data_A);
		end
	$display("Testing output B.");
	ctrl = 1;
	#(2*HALF_PERIOD);
	$display("Control bit = %d", ctrl);
	$display("Output = %d", data_out);
	if (data_out != data_B) begin
       			failures = failures + 1;
       			$display("%t (OUT) CTRL 0: Error, output = %d, expecting = %d", $time, data_out, data_B);
		end
	
    
end 


endmodule