// Verilog HDL for "COMP12111", "display_scan" "functional"


module display_scan(clk, disp_enable,
                    digit5, digit4, digit3, digit2, digit1, digit0,
		    Bus_En,
                    Bus_Segments);

input clk;
input [7:0] digit5, digit4, digit3, digit2, digit1, digit0;
input [5:0] disp_enable;
output [7:0] Bus_Segments;
output Bus_En;

reg  [2:0] state;
reg  [5:0] Bus_En;
reg  [7:0] Bus_Segments;

// Display scanner
// Bus_En is active low
// Bus_Segments active high
always @ (posedge clk)				
 case (state)
    0:begin state <= 1; Bus_Segments <= digit1; Bus_En <= {4'b1111, ~disp_enable[1], 1'b1}; end
    1:begin state <= 2; Bus_Segments <= digit2; Bus_En <= {3'b111, ~disp_enable[2], 2'b11}; end
    2:begin state <= 3; Bus_Segments <= digit3; Bus_En <= {2'b11, ~disp_enable[3], 3'b111}; end
    3:begin state <= 4; Bus_Segments <= digit4; Bus_En <= {1'b1, ~disp_enable[4], 4'b1111}; end
    4:begin state <= 5; Bus_Segments <= digit5; Bus_En <= {~disp_enable[5], 5'b11111}; end
    5:begin state <= 0; Bus_Segments <= digit0; Bus_En <= {5'b11111, ~disp_enable[0]}; end
    default : begin state <= 0; Bus_Segments <= digit0; Bus_En <= {5'b11111, ~disp_enable[0]}; end
 endcase 
    


endmodule
