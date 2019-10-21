
// Verilog stimulus file.
// Please do not create a module in this file.
/*

#VALUE      creates a delay of VALUE ns
a=VALUE;    sets the value of input 'a' to VALUE
$stop;      tells the simulator to stop

*/

initial
begin
#100 select=2'b00; a=4'h0; b=4'h0; c=4'h0; d=4'h0;
// Enter you stimulus below this line

#100 select=2'b00; a=4'hf; b=4'h0; c=4'h0; d=4'h0;
#100 select=2'b01; a=4'h0; b=4'hf; c=4'h0; d=4'h0;
#100 select=2'b10; a=4'h0; b=4'h0; c=4'hf; d=4'h0;
#100 select=2'b11; a=4'h0; b=4'h0; c=4'h0; d=4'hf;
#100 select=2'b00; a=4'h0; b=4'h0; c=4'h0; d=4'h0;
#100 select=2'b00; a=4'h0; b=4'h0; c=4'h0; d=4'h0;
#100 select=2'b00; a=4'h0; b=4'h0; c=4'h0; d=4'h0;
#100 select=0; a=4'h0; b=4'h1; c=4'h2; d=4'h3;
#100 select=1; a=4'h0; b=4'h1; c=4'h2; d=4'h3;
#100 select=2; a=4'h0; b=4'h1; c=4'h2; d=4'h3;
#100 select=3; a=4'h0; b=4'h1; c=4'h2; d=4'h3;
#100 select=0; a=4'h0; b=4'h1; c=4'h2; d=4'h3;

// Please make sure your stimulus is above this line 
$stop;
end 
