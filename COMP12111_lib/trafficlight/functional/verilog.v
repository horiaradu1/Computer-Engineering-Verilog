// Verilog HDL for "COMP12111", "trafficlight" "functional"
//
// COMP12111 - Exercise 3 Sequential Design
//
// Version 1. Feb 2019. P W Nutter
//
// This is the Verilog module for the pedestrian/cyclist crossing Controller
//
// The aim of this exercise is complete the finite state machine using the
// state transition diagram given in the laboratory notes. 
//
// DO NOT change the interface to this design or it may not be marked completely
// when submitted.
//
// Make sure you document your code and marks may be awarded/lost for the 
// quality of the comments given.
//
// Add your comments:
// Modified by Horia Gabriel Radu
//
// The code below is for a FSM that will act as a traffic light
// It is a sequential, time-dependent, design in Verilog that will control a traffic light
// At every beat of the clock the current state will shift to its proper assigned value
// The output for the light will be always green if there is no input
// If the start button is pressed, simmilar to a pedestrian crossing button, the current_state will start to shift to next_state and so on
// Turning the lights red for the vechicles and green for pedestrians (for a defined period), allowing them to cross
// And then going back to its original state (green for the vechicles and red for pedestrians), waiting for the next start to be pressed
// I also implemented a reset button that returns the current state of the FSM to its original state, asynchronously, anytime its pressed

module trafficlight ( output reg [5:0] 	lightseq,	//the 6-bit light sequence
		      input             clock,		//clock that drives the fsm
		      input             reset,		//reset signal 
		      input             start);		//input from pedestrian


// declare internal variables here (how many bits required?)

//There will be 11 states, so we will need 4 bits to represent all of them, and to variables, one for the current state and one for the next state
reg [3:0] current_state;	 //Declaring the current state for the sequential design
reg [3:0] next_state;		 //Declaring the next state for the sequential design

//We define each traffic light output state for readability
`define G_R  6'b001100		 //Defining the green vechicle and red pedestrian light
`define A_R  6'b010100		 //Defining the amber vechicle and red pedestrian light
`define R_G  6'b100001		 //Defining the red vechicle and green pedestrian light
`define RA_R 6'b110100		 //Defining the red and amber vechicle and red pedestrian light

// implement your next state combinatorial logic block here

always@(*)
	case(current_state)				//The next state will depend on the current state
		4'b0000: if(start==0) next_state = 4'b0000; //For current state 0, if start is 0 (False) stay in state 0
			 else next_state = 4'b0001;         //Else go to state 1

		4'b0001: next_state = 4'b0010;		    //For current state 1, next-state will be 2
		4'b0010: next_state = 4'b0011; 		    //For current state 2, next-state will be 3
		4'b0011: next_state = 4'b0100;		    //For current state 3, next-state will be 4
		4'b0100: next_state = 4'b0101; 		    //For current state 4, next-state will be 5

		4'b0101: if(start==0) next_state = 4'b0110; //For current state 5, if start is 0 (False), go to state 6
			 else next_state = 4'b1000;         //Else go to state 8

		4'b0110: if(start==0) next_state = 4'b0111; //For current state 6, if start is 0 (False), go to state 7
			 else next_state = 4'b1001;         //Else go to state 9

		4'b0111: if(start==0) next_state = 4'b0000; //For current state 7, if start is 0 (False), go to state 0
			 else next_state = 4'b1010;         //Else go to state 10

		4'b1000: next_state = 4'b1001;		    //For current state 8, next-state will be 9
		4'b1001: next_state = 4'b1010;		    //For current state 9, next-state will be 10
		4'b1010: next_state = 4'b0001;		    //For current state 10, next-state will be 1

		default: next_state = 'hx;		    //To Catch anything missed for testing
	endcase

// implement your current state assignment, register, here

// Below is a sequential circuit that uses non-blocking assignments that every time the clock rises or the reset rises, it goes into the always block
always@(posedge clock, posedge reset)		//This always block takes care of the shifting of the current_state with the clock or the reset
	if(reset==1)				//If the reset is pressed anytime, asynchronously, then the current_state will remain in 0
		current_state <= 4'b0000;
	else					//Else if the posedge clock passes without the reset being pressed, the current_state will be assigned the next_state
		current_state <= next_state;	

// implement your output logic here

always@(*)			//This always block will take care of the output and the way in which the lights on the board light up, based on the current case
	case(current_state)				//The color of the traffic lights will depend on the current state
		4'b0000, 4'b0110, 4'b0111, 4'b1000, 4'b1001, 4'b1010: lightseq = `G_R;	//For current_state 0,6,7,8,9,10, car light will be green and pedestrians will not be allowed to pass
		4'b0001: lightseq = `A_R;							//For current_state 1 car light will be amber and pedestrians will not be allowed to pass
		4'b0010, 4'b0011, 4'b0100: lightseq = `R_G;				//For current_state 2,3,4 car light will be red and pedestrians will be allowed to pass
		4'b0101: lightseq = `RA_R;							//For current_state 5 car light will be red and amber and pedestrians will not be allowed to pass
		default: lightseq = 'hx;							//To Catch anything missed for testing
	endcase

endmodule
