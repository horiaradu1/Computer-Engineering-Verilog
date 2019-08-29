// Verilog stimulus file.
// Please do not create a module in this file.
/*

#VALUE      creates a delay of VALUE ns
a=VALUE;    sets the value of input 'a' to VALUE
$stop;      tells the simulator to stop

*/

initial
begin
// Enter you stimulus below this line
// 38 test vectors required for connectivity tests
// Check all adders are connected to something, S=0 cout=0 not Xs
#100 a=16'h0000; b=16'h0000; cin=0;
//Check connections for A[0], B[0], Cin, S[0], S=0001 cout=0
#100 a=16'h0001;
#100 a=16'h0000; b=16'h0001;
#100 a=16'h0000; b=16'h0000; cin=1;
//Check connections for  A[1], B[1], S[1]
#100 a=16'h0002; b=16'h0000; cin=0;
#100 a=16'h0000; b=16'h0002;
//Check connections for  A[2], B[2], S[2]
#100 a=16'h0004; b=16'h0000;
#100 a=16'h0000; b=16'h0004;
//Check connections for  A[3], B[3], S[3]
#100 a=16'h0008; b=16'h0000;
#100 a=16'h0000; b=16'h0008;
//Check connection of carry out of the first 4bit adder in to 2nd 4-bit adder
#100 a=16'h0008; b=16'h0008;
// ADD YOUR TEST VECTORS after this line
// Continue with the same pattern shown above
// 27 test vectors including the carry out
// -------------------------------------------------




// Connectivity tests completed.

// ADD TESTS FOR FINDING MAXIMUM CARRY DELAY HERE
// 2 test vectors required - one to initialise followed by the 2nd to exercise
// the critical path




// -------------------------------------------------
// Please make sure your stimulus is above this line
// delay for end of wave traces to be visible
#100 $stop;
end
