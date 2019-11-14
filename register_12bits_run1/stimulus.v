
// Verilog stimulus file.
// Please do not create a module in this file.
/*

#VALUE      creates a delay of VALUE ns
a=VALUE;    sets the value of input 'a' to VALUE
$stop;      tells the simulator to stop

*/

initial
begin
#100 
// Enter you stimulus below this line
#100 D=12'b0000_1111_0000; R=0; CLK=1; CE=1;
#100 R=1; CLK=0; CE=0;
#100 R=1; CLK=0; CE=0;


// Please make sure your stimulus is above this line 
$stop;
end 
