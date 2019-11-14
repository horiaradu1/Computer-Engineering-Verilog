//Verilog HDL for "TEST", "FSM" "functional"


module FSM ( input 	 CLK, R, a,
	     output reg	 s);

reg [1:0] next_st, current_st;

always @ (*)
	case(current_st)
		2'b00:  if(a=0) next_st = 2'b00;
			else	next_st = 2'b01;
		2'b01:  next_st = 2'b10;
		2'b10:  next_st = 2'b11;
		default: next_st = 2'hx;
	endcase

always @ (*)
	if(R)
		current_st <= 2'b00;
	else
		current_st <= next_st;

always @ (*)
	case(current_st)
		2'b00, 2'b10: s <= 0;
		default: s <= 1;
	endcase

endmodule
