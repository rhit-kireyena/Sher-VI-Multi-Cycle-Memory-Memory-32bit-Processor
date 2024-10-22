`timescale 1ns / 1ps

// test bench
module test_register();

// inputs
reg clk;
reg ctrl;
reg reset;
reg unsigned [15:0] data_in;

// output
wire unsigned [15:0] data_out;

// module
register UUT
(
	.clk(clk) ,	// input  clk
	.ctrl(ctrl) ,	// input  ctrl
	.data_in(data_in) ,	// input  data_in
	.reset(reset),			// input reset
	.data_out(data_out) 	// output  R_sig
);

parameter HALF_PERIOD = 50;
integer previous_value = 0;
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
    data_in = 0;
    ctrl = 0;
	 clk = 0;
    reset = 0;
	 
    // wait a lil bit
    #1;
    
	 
    	//-----TEST 1-----
	//Testing Ctrl Bit 
	$display("Testing control bit.");
	reset = 1;
	#(2*HALF_PERIOD);
	data_in = 0;
	ctrl = 0;
	reset = 0;
	data_in = ($urandom%65534+1);
	$display("Data in = %d, Control bit = %d", data_in, ctrl);
	previous_value = data_in;
	#(2*HALF_PERIOD);
	$display("Data out = %d", data_out);
	if (data_out == data_in) begin
       			failures = failures + 1;
       			$display("%t (CTRL) PRE CTRL: Error, output = %d, expecting = 0", $time, data_out);
		end
		
	ctrl = 1;
	#(2*HALF_PERIOD);
	$display("Data in = %d, Control bit = %d", data_in, ctrl);
	$display("Data out = %d", data_out);
	if (data_out != data_in) begin
       			failures = failures + 1;
       			$display("%t (CTRL) POST CTRL: Error, output = %d, expecting = %d", $time, data_out, data_in);
	end
	ctrl = 0;
	data_in = ($urandom%65534+1);
	#(2*HALF_PERIOD);
	$display("Data in = %d, Control bit = %d", data_in, ctrl);
	$display("Data out = %d", data_out);
	if (data_out != data_in) begin
       			failures = failures + 1;
       			$display("%t (CTRL) POST INPUT CHANGE: Error, output = %d, expecting = %d", $time, data_out, previous_value);
	end
	

	//-----TEST 2-----
	//Testing Reset Bit 
	$display("Testing reset bit.");
	reset = 1;
	#(2*HALF_PERIOD);
	data_in = 0;
	ctrl = 1;
	reset = 0;
	data_in = ($urandom%65534+1);
	previous_value = data_in;
	#(2*HALF_PERIOD);
	$display("Data in = %d, Control bit = %d, Reset = %d", data_in, ctrl, reset);
	$display("Data out = %d", data_out);
	ctrl = 0;
	reset = 1;
	#(2*HALF_PERIOD);
	$display("Data in = %d, Control bit = %d, Reset = %d", data_in, ctrl, reset);
	$display("Data out = %d", data_out);
	if (data_out != 0) begin
       			failures = failures + 1;
       			$display("%t (RESET) POST RESET: Error, output = %d, expecting = 0", $time, data_out);
		end
	ctrl = 1;
	reset = 1;
	#(2*HALF_PERIOD);
	$display("Data in = %d, Control bit = %d, Reset = %d", data_in, ctrl, reset);
	$display("Data out = %d", data_out);
	if (data_out != 0) begin
       			failures = failures + 1;
       			$display("%t (RESET) POST RESET CTRL ON: Error, output = %d, expecting = 0", $time, data_out);
	end
    
end 


endmodule