
// Verilog stimulus file.
// Please do not create a module in this file.
/*

#VALUE      creates a delay of VALUE ns
a=VALUE;    sets the value of input 'a' to VALUE
$stop;      tells the simulator to stop

*/

initial
begin
#100 a=0; b=0; cin=0;
// Enter you stimulus below this line
#100 a=8'h01; b=8'h01; cin=1;
#100 a=8'hff; b=8'h00; cin=1;
#100 a=8'h00; b=8'hff; cin=1;
#100 a=8'hff; b=8'hff; cin=1;
#100 a=8'hff; b=8'hff; cin=1;


// Please make sure your stimulus is above this line 
$stop;
end 
