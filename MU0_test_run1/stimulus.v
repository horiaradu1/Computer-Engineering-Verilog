
// Verilog stimulus file.
// Please do not create a module in this file.
/*

#VALUE      creates a delay of VALUE ns
a=VALUE;    sets the value of input 'a' to VALUE
$stop;      tells the simulator to stop

*/

initial Clk=0;

always
	begin
	#50
	Clk = ~Clk;
	end

initial
begin

Reset=1;
#125 Reset=0;
#5000


#100 $stop;
end 
