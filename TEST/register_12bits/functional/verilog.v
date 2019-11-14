//Verilog HDL for "TEST", "register_12bits" "functional"


module register_12bits ( input [11:0] D, input R, input CE, input CLK, output reg [11:0] Q );

always @ (posedge CLK, posedge R)
	begin
		if (R==1'b1)
			Q <= 12'b0000_0000_0000;
		if (CE==1'b1)
			Q <= D;
	end

endmodule
