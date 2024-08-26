`timescale 1ns / 1ps

// test bench
module test_SL();

// inputs
reg unsigned [15:0] data_in;

// output
wire unsigned [15:0] data_out;

// module
SL UUT
(
	.data_in(data_in) ,	// input  data_in
	.data_out(data_out) 	// output  data_out
);

parameter HALF_PERIOD = 50;
integer failures = 0;
integer clk = 0;

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
    data_in = 0;
	 clk = 0;
	 
    // wait a lil bit
    #1;
    
	 
    	//-----TEST 1-----
	//Testing Ctrl Bit 
	$display("Testing left shift.");
	#(2*HALF_PERIOD);
	data_in = 1000;
	$display("Data in = %d", data_in);
	#(2*HALF_PERIOD);
	$display("Data out = %d", data_out);
	if (data_out != (2*data_in)) begin
       			failures = failures + 1;
       			$display("%t (CTRL) LEFT SHIFT: Error, output = %d, expecting = 2000", $time, data_out);
		end
	
    
end 


endmodule