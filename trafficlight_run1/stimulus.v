// Verilog stimulus file.
// Please do not create a module in this file.
//
// Testing of a sequential design requires you to implement
// a clock - see the advice in Blackboard on how to do this
//
// Modified by Horia Gabriel Radu

/*

#VALUE      creates a delay of VALUE ns
a=VALUE;    sets the value of input 'a' to VALUE
$stop;      tells the simulator to stop

*/

// Implement your clock here
// -----------------------------------------------------

initial clock = 0;			//Initialise clock to be 0

always					//Always go in this block
	begin
		#50			//Set a delay of 50 nanoseconds
		clock = ~clock;		//Invert clock, from 0 to 1 and from 1 to 0
	end

// -----------------------------------------------------


initial
begin

//In the stimulus we test all the possible connections and state shifts from every possible way

// Set input signals here, using delays where appropriate
// -----------------------------------------------------
#100  reset=1; start=0;
#100  reset=0; start=1;		//This will go from 0-1-2-3-4-5-6-7-0, testing the first possible path
#50   start=0;

#800  reset=1;			//This will reset the sequential design, getting ready to test the next path

#25   reset=0; start=1;		//This will go from 0-1-2-3-4-5-8-9-10-1, testing the second possible path

#925  reset=1; start=0;		//This will reset the sequential design, getting ready to test the next path

#100  reset=0; start=1;		//This will go from 0-1-2-3-4-5-6-9-10-1, testing the third possible path
#50   start=0;
#550  start=1;

#200  reset=1; start=0;		//This will reset the sequential design, getting ready to test the next path

#100  reset=0; start=1;		//This will go from 0-1-2-3-4-5-6-7-10-1, testing the fourth possible path
#50   start=0;
#650  start=1;

#200  reset=1; start=0;
#50   reset=0; start='hx;
#500

#100 $stop;
end
