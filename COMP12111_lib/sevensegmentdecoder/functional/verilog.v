// Verilog HDL for "COMP12111_lib", "sevensegmentdecoder" "functional"
// Created P W Nutter, 20/3/19
// Modified by Horia Gabriel Radu
// Add your comments here ...

// The code below will determine based on the input bcd what segments to light on the board to show specific values

module sevensegmentdecoder (input [3:0] bcd,
			    output reg 	[7:0] segments);

// create an always block to represent the desired behaviour of the
// combinatorial design
// -----------------------------------------------------------------

always@(*) // As soon as the input is changed go into the block below and execute it
 case(bcd) // This case function will get the value of bcd and choose one of the appropiate instructions below to assign to the segments output (depending on what bcd is) and determine which lights and in what order will appear on the display on the board. It basically has a case for every possible input in bcd, and depending on the bcd, the segments output will get an appropriate value to translate it from binary to hex.

  4'b0000: segments = 8'b0011_1111; // For value 0
  4'b0001: segments = 8'b0000_0110; // For value 1
  4'b0010: segments = 8'b0101_1011; // For value 2
  4'b0011: segments = 8'b0100_1111; // For value 3
  4'b0100: segments = 8'b0110_0110; // For value 4
  4'b0101: segments = 8'b0110_1101; // For value 5
  4'b0110: segments = 8'b0111_1101; // For value 6
  4'b0111: segments = 8'b0000_0111; // For value 7
  4'b1000: segments = 8'b0111_1111; // For value 8
  4'b1001: segments = 8'b0110_1111; // For value 9
  4'b1010: segments = 8'b0111_0111; // For value A
  4'b1011: segments = 8'b0111_1100; // For value b
  4'b1100: segments = 8'b0011_1001; // For value C
  4'b1101: segments = 8'b0101_1110; // For value d
  4'b1110: segments = 8'b0111_1001; // For value E
  4'b1111: segments = 8'b0111_0001; // For value F
  default: segments = 8'b0000_0000; // If another faulty value is entered

 endcase // End of the case function
endmodule  // End of module seven segment decoder
