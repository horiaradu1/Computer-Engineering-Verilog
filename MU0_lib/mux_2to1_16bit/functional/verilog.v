//Verilog HDL for "MU0_lib", "mux_2to1_16bit" "functional"
//This is a mux that selects between two variables of 16 bits each

module mux_2to1_16bit ( output reg [15:0] q,
			input [15:0] a,
			input [15:0] b,
			input sel );

always @ (*)			//Always when an input is changed go into this always block
begin
	case(sel)		//Select a case based on the sel variable
		0: q = a;	//If sel is 0 then the output will get the value of a
		1: q = b;	//If sel is 1 then the output will get the value of b
		default: q = 16'hxxxx; //default for testing
	endcase
end

endmodule
