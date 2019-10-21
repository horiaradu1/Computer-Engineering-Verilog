//Verilog HDL for "TEST", "mux4to1_4bit" "functional"


module mux4to1_4bit (input      [1:0]  select,
                     input       [3:0]  a, b, c, d,
                     output      [3:0]  q);



assign q = (select == 0) ?
		a : (select == 1) ?
		b : (select == 2) ?
		c : d;

endmodule
