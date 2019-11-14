//Verilog HDL for "MU0_lib", "mux_2to1_12bit" "functional"


module mux_2to1_12bit ( output reg [11:0] q,
			input [11:0] a,
			input [11:0] b,
			input sel );

always @ (*)
begin
	case(sel)
		0: q = a;
		1: q = b;
		default: q = 12'hx; //default for testing
	endcase
end

endmodule
