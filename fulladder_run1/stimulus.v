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







// Please make sure your stimulus is above this line
  #100 $stop;
end
