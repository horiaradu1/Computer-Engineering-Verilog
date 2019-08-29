// Verilog HDL for "Board_lib", "key_scan" "functional"

module key_scan(clk, KeyCol, KeyRow, key_row1, key_row2, key_row3, key_row4);

input        clk;
output [5:0] KeyRow;				// Row scanned externally
input  [0:5] KeyCol;				// External column input

output [7:0] key_row1, key_row2, key_row3, key_row4;	// Internal 'rows'

reg   [5:0] KeyRow;
reg  [35:0] KK;					// Internal vector of all keys
wire  [7:0] key_row1, key_row2, key_row3, key_row4; // Key status formatted for user

always @ (posedge clk)				// Keyboard scanner
  begin
  case (KeyRow)
    6'b000001 : begin  KeyRow <= 6'b000010;  KK[35:30] <= KeyCol;  end
    6'b000010 : begin  KeyRow <= 6'b000100;  KK[29:24] <= KeyCol;  end
    6'b000100 : begin  KeyRow <= 6'b001000;  KK[23:18] <= KeyCol;  end
    6'b001000 : begin  KeyRow <= 6'b010000;  KK[17:12] <= KeyCol;  end
    6'b010000 : begin  KeyRow <= 6'b100000;  KK[11:6]  <= KeyCol;  end
    6'b100000 : begin  KeyRow <= 6'b000001;  KK[5:0]   <= KeyCol;  end
    default   :        KeyRow <= 6'b000001;	// Fall into a legal pattern
  endcase
  end


// Translate matrix into physically placed rows

assign key_row1 = {KK[30], KK[24], KK[18], KK[12], KK[ 6], KK[ 0], KK[31], KK[25]};
assign key_row2 = {KK[19], KK[13], KK[ 7], KK[ 1], KK[32], KK[26], KK[20], KK[14]};
assign key_row3 = {KK[ 8], KK[ 2], KK[33], KK[27], KK[21], KK[15], KK[ 9], KK[ 3]};
assign key_row4 = {KK[34], KK[28], KK[22], KK[16], KK[10], KK[ 4], KK[35], KK[29]};

endmodule
