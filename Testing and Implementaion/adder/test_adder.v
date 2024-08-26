`timescale 1ns / 1ps

// test bench
module test_adder();

// inputs
reg signed [15:0] data_A;
reg signed [15:0] data_B;
reg sub;
// output
wire signed [15:0] data_out;

// module
adder UUT
(
	.data_A(data_A) ,	// input  data_A
	.data_B(data_B) ,	// input  data_B
	.data_out(data_out) 	// output  data_out
);

parameter HALF_PERIOD = 50;
integer failures = 0;
integer clk = 0;
integer sum = 0;

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
    data_A = 0;
	 data_B = 0;
	 clk = 0;
	 sub = 0;
    // wait a lil bit
    #1;
    
	 
    	//-----TEST 1-----
	//Testing adder addition
	#(2*HALF_PERIOD);
	data_A = ($random%1000);
	data_B = ($random%1000);
	$display("Testing adder in addition. Input A = %d, Input B = %d", data_A, data_B);
	sum = data_A + data_B;
	#(2*HALF_PERIOD);
	$display("Sum = %d", sum);
	if (data_out != sum) begin
       			failures = failures + 1;
       			$display("%t (ADD) ADDER: Error, output = %d, expecting = %d", $time, data_out, sum);
		end
	
//-----TEST 2-----
	//Testing adder subtraction
	sub = 1;
	#(2*HALF_PERIOD);
	data_A = ($random%1000);
	data_B = ($random%1000);
	$display("Testing adder in subtraction. Input A = %d, Input B = %d", data_A, data_B);
	sum = data_A - data_B;
	#(2*HALF_PERIOD);
	$display("Sum = %d", sum);
	if (data_out != sum) begin
       			failures = failures + 1;
       			$display("%t (ADD) ADDER: Error, output = %d, expecting = %d", $time, data_out, sum);
		end
    
end 


endmodule