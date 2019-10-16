// Verilog HDL for "COMP12111_lib", "sevensegmentdecoder" "functional"
// Created P W Nutter, 20/3/19
//
// Add your comments here ...


module sevensegmentdecoder (input [3:0] bcd,
			    output reg 	[7:0] segments);

// create an always block to represent the desired behaviour of the
// combinatorial design
// -----------------------------------------------------------------
// the code below will determine based on the input bcd what segments to light on the board to show specific numbers

always@(*) //as soon as the input is changed go into the block below and run it
case(bcd) //Will determine what value we enter and choose one of the functions below to assign the order of the lights that will appear into segments

4'b0000: segments = 8'b0011_1111; //For nr 0
4'b0001: segments = 8'b0000_0110; //For nr 1
4'b0010: segments = 8'b0101_1011; //For nr 2
4'b0011: segments = 8'b0100_1111; //For nr 3
4'b0100: segments = 8'b0110_0110; //For nr 4
4'b0101: segments = 8'b0110_1101; //For nr 5
4'b0110: segments = 8'b0111_1101; //For nr 6
4'b0111: segments = 8'b0000_0111; //For nr 7
4'b1000: segments = 8'b0111_1111; //For nr 8
4'b1001: segments = 8'b0110_1111; //For nr 9
4'b1010: segments = 8'b0111_0111; //For ch A
4'b1011: segments = 8'b0111_1100; //For ch b
4'b1100: segments = 8'b0011_1001; //For ch C
4'b1101: segments = 8'b0101_1110; //For ch d
4'b1110: segments = 8'b0111_1001; //For ch E
4'b1111: segments = 8'b0111_0001; //For ch F


endcase
endmodule  // end of module sevensegmentdecoder
