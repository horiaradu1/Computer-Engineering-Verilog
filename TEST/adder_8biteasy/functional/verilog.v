//Verilog HDL for "TEST", "adder_8biteasy" "functional"


module adder_8biteasy ( input [7:0] a,
            input [7:0] b,
            input cin,
            output [7:0] sum,
            output carry);


assign {carry, sum} = cin + a + b;

endmodule
