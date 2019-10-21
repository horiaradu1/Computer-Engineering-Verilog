// Verilog stimulus file.
// Please do not create a module in this file.
/*

#VALUE      creates a delay of VALUE ns
a=VALUE;    sets the value of input 'a' to VALUE
$stop;      tells the simulator to stop

*/

initial
begin
#100 bcd=0;

// Enter you stimulus below this line
// Make sure you test all input combinations with a delay
// -------------------------------------------------------
// the stimulus file below will try all the inputs/outputs of the functional seven segment decoder, going from 0 to F

#100 bcd=4'b0000; //Will try for value 0
#100 bcd=4'b0001; //Will try for value 1
#100 bcd=4'b0010; //Will try for value 2
#100 bcd=4'b0011; //Will try for value 3
#100 bcd=4'b0100; //Will try for value 4
#100 bcd=4'b0101; //Will try for value 5
#100 bcd=4'b0110; //Will try for value 6
#100 bcd=4'b0111; //Will try for value 7
#100 bcd=4'b1000; //Will try for value 8
#100 bcd=4'b1001; //Will try for value 9
#100 bcd=4'b1010; //Will try for value A
#100 bcd=4'b1011; //Will try for value b
#100 bcd=4'b1100; //Will try for value C
#100 bcd=4'b1101; //Will try for value d
#100 bcd=4'b1110; //Will try for value E
#100 bcd=4'b1111; //Will try for value F




// -------------------------------------------------------
// Please make sure your stimulus is above this line
 
#100 $stop;
end
