//Control unit for S.H.E.R. VI 

module SHER_VI_CONTROL(
	 input [4:0]       code,
    input             CLK,
    input             Reset,
    output        reg COMMON,
	 output        reg SPWRITE,
	 output        reg TSPWRITE,
	 output        reg WRITEZERO,
	 output        reg MEMWRITE,
	 output        reg SKIPCMP,
	 output        reg GENERIC,
//testing
	output		reg [3:0] current_state,
    output 			reg [1:0] DATAIN
	 );

	//state flip-flops
   //reg [3:0]    current_state;
   reg [3:0]    next_state;
	
	//state definitions
   parameter    Fetch       = 0;  // Instruction fetch
   parameter    Make        = 1;  // Makes completion
   parameter    AddSP       = 2;  // SubSP completion
   parameter    SubSP       = 3;  // AddSP completion
   parameter    Load        = 4;  // Load values from memory
   parameter    Logic       = 5;  // Let ALU work
   parameter    Ari	    = 6;  // Arithmetic completion
   parameter    Branch      = 7;  // Branch completion
   parameter    Jump        = 8;  // Jump completion
	
	//register calculation
   always @ (negedge CLK, posedge Reset)
	
     begin
        if (Reset)
          current_state = Fetch;
        else 
          current_state = next_state;
     end
	
	always @ (negedge Reset)

	begin
		current_state = Fetch;
	end
   //OUTPUT signals for each state (depends on current state)
   always @ (current_state)
     begin
	
        //Reset all signals that cannot be don't cares
        COMMON = 0;
		  SPWRITE = 0;
		  TSPWRITE = 0;
		  WRITEZERO = 0;
		  MEMWRITE = 0;
		  SKIPCMP = 0;
		  GENERIC = 0;
		  DATAIN = 0;
		  
       case (current_state)
		  
		Fetch:
			begin
				COMMON = 1;
				SKIPCMP = 1;
				GENERIC = 1;
//write("fetch");
         end
		Make:
			begin
				MEMWRITE = 1;
				SKIPCMP = 1;
				GENERIC = 1;
//write("make");
			end
		SubSP:
			begin
				SPWRITE = 1;
				SKIPCMP = 1;
				GENERIC = 1;
//write("subsp");
			end
		AddSP:
			begin
				TSPWRITE = 1;
				GENERIC = 1;
//write("addsp");
			end
		Load:
			begin
				GENERIC = 1;
//write("load");
			end
		Logic:
			begin
//write("logic");
			end
		Ari:
			begin
				DATAIN = 1;
				MEMWRITE = 1;
				SKIPCMP = 1;
//write("ari");
			end
		Branch:
			begin
				COMMON = 1;
				DATAIN = 2;
				SPWRITE = 1;
				WRITEZERO = 1;
				MEMWRITE = 1;
//write("branch");
			end
		Jump:
			begin
				COMMON = 1;
//write("jump");
			end
      default:
			begin
				//display ("not implemented"); 
			end
          
		endcase
//display(//time);
     end
	  
	  always @ (current_state, next_state, code)
     begin         

        ////display("The current state is %d", current_state);
        
        case (current_state)
          
          Fetch:
            begin
					case (code[1:0])
						0:
							begin
								next_state = Make;
							end
						1:
							begin
								case (code[2:2])
									0:
										begin
											next_state = AddSP;
										end
									1:
										begin
											next_state = SubSP;
										end
									default:
										begin
										//display("Wrong OP");
										next_state = Fetch;
										end
								endcase
							end
						2:
							begin
								next_state = Load;
							end
						3: 
							begin
								next_state = Load;
							end
						default:
							begin
								//display("Wrong OP");
								next_state = Fetch;
							end
					endcase
            end
			Make:
				begin
					next_state = Fetch;
				end
			AddSP:
				begin
					next_state = Fetch;
				end
			SubSP:
				begin
					next_state = Fetch;
				end
			Load:
				begin
					next_state = Logic;
				end
			Logic:
				begin
					case (code[1:0])
						2:
							begin
								next_state = Ari;
							end
						3:
							begin
								case (code[4:4])
									0:
										begin
											next_state = Branch;
										end
									1:
										begin
											next_state = Jump;
										end
									default:
										begin
											//display("Wrong OP");
											next_state = Fetch;
										end
								endcase
							end
						default:
							begin
								//display("Wrong OP");
								next_state = Fetch;
							end
					endcase
				end
         Ari:
				begin
					next_state = Fetch;
				end
			Branch:
				begin
					next_state = Fetch;
				end
			Jump:
				begin
					next_state = Fetch;
				end

          default:
            begin
               //display(" Not implemented!");
               next_state = Fetch;
            end
          
        endcase
        
        ////display("After the tests, the next_state is %d", next_state);
                
     end

	 
endmodule