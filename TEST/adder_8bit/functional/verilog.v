//Verilog HDL for "TEST", "adder_8biy" "functional"



module adder_8bit (     input [7:0] a,
			input [7:0] b,
			input cin,
			output [7:0] sum,
			output carry);

fulladder f1(.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .carry(r0));
fulladder f2(.a(a[1]), .b(b[1]), .cin(r0), .sum(sum[1]), .carry(r1));
fulladder f3(.a(a[2]), .b(b[2]), .cin(r1), .sum(sum[2]), .carry(r2));
fulladder f4(.a(a[3]), .b(b[3]), .cin(r2), .sum(sum[3]), .carry(r3));
fulladder f5(.a(a[4]), .b(b[4]), .cin(r3), .sum(sum[4]), .carry(r4));
fulladder f6(.a(a[5]), .b(b[5]), .cin(r4), .sum(sum[5]), .carry(r5));
fulladder f7(.a(a[6]), .b(b[6]), .cin(r5), .sum(sum[6]), .carry(r6));
fulladder f8(.a(a[7]), .b(b[7]), .cin(r6), .sum(sum[7]), .carry(carry));

endmodule


module fulladder (      input a,
			input b,
			input cin,
			output sum,
			output carry);
begin
assign sum = a ^ b ^ cin;
assign carry = (a & b) | (a & cin) | (b & cin);
end
endmodule



