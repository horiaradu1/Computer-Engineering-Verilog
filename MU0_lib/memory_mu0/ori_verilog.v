// Verilog HDL for "MU0_lib", "memory_mu0" "functional"

// Author J Pepper
// MAY 2016
// Version 1.0


// Dual port memory/register module
// Address range 0 to 12'hFED is memory/ram
// Uses a Synchronous RAM on a negedge clock, to fool processor into think its just a RAM
// Address range 12'hFEE to 12'hFFF are address decoded registers to give access to the
// 1st year engineering lab board peripherals


  `define RAM_SIZE   12'hEFF // Size of RAM
  `define IO_SIZE    8'hFF    // Size of IO


// Note definitions for use by the buzzer device driver
// Define the lowest octave of notes as number of master colock cycles, uses 8MHz clock

`define   C4	30578
`define   C4_s	29304
`define   D4	28030
`define   D4_s	26756
`define   E4	25482
`define   F4	24208
`define   F4_s	22934
`define   G4	21659
`define   G4_s	20385
`define   A5	19111
`define   A5_s	17837
`define   B5	16563

// Define buzzer duration time step, 1/10 second at 8MHz clock
`define   buzzer_time_step 800_000



module memory_mu0(input  wire        Clk,     		// 8MHz
		  		  input  wire [11:0] address0,		// CPU address bus
		          input  wire [15:0] write_data0,	// Data from cpu to memory 
		  		  output reg  [15:0] read_data0,	// Data from memory to cpu
		  		  input  wire        WEn0,		// cpu memory write enable, active high 
		  		  input  wire [11:0] address1,		// Ackie/perentie address bus
		  		  input  wire [15:0] write_data1,	// Data from ackie/perentie to memory
		  		  output reg  [15:0] read_data1,	// Data from memory to ackie/perentie
		  		  input  wire        WEn1,		// Ackie/perentie memory write enable, active high
                  output reg  [5:0]  traffic_lights,	// Six taffic light leds 
                  output reg  [7:0]  bargraph,		// Bargraph display
                  output reg         buzzer_pulses,	// Piezo buzzer
                  output reg         board_led,		// Red led 
                  output reg  [5:0]  display_enable,	// Enable for the six seven segment displays, active high
                  output reg  [3:0]  digit5,		// BCD data for seven segment display, seven segment decoder required
                  output reg  [3:0]  digit4,		// BCD data for seven segment display, seven segment decoder required
                  output reg  [3:0]  digit3,		// BCD data for seven segment display, seven segment decoder required
                  output reg  [3:0]  digit2,		// BCD data for seven segment display, seven segment decoder required 
                  output reg  [3:0]  digit1,		// BCD data for seven segment display, seven segment decoder required
                  output reg  [3:0]  digit0,		// BCD data for seven segment display, seven segment decoder required
                  output reg  [3:0]  s6_leds,		// 4 leds on S6cmod board
                  input  wire [7:0]  key_row4,		
                  input  wire [7:0]  key_row3,		
                  input  wire [7:0]  key_row2,		
                  input  wire [7:0]  key_row1,		
                  input  wire        board_switch2,	
                  input  wire        board_switch1,
                  input  wire        s6_button1,
                  input  wire        s6_button0       
                 );

reg [15:0] mem [12'h000:12'hFFF];	// memory array 16 x 4096
reg [15:0] mem_read_data0;		// cpu ram read port
reg [15:0] mem_read_data1;		// ackie ram read port

reg [15:0] buzzer;			// memory addresss decoded register for buzzer control
reg        buzzer_busy = 0;		// high when buzzer is running in program mode
reg        buzzer_run = 0;		// Pulse to indicate that buzzer register has been written to
reg [20:0] buzzer_clk_count = 0;	// Counter used to produce the buzzer time step delay
reg [3:0]  buzzer_time_step_count = 0;  // Hold the number of buzzer time steps
reg [15:0] buzzer_note;			// Buzzer note selected in terms of clock cycles
reg [15:0] buzzer_octave_and_note;	// Buzzer note scaled by the octave selected
reg [15:0] buzzer_note_count = 0;	// Counter used to count clock cycles of the determined note/octave


initial
$readmemh("/opt/info/courses/COMP12111/MU0_examples/MU0_test.mem", mem); // load default MU0 test program


// RAM
always @ (negedge Clk) // Done to make SRAM look like asynchronous RAM, makes simulation work
 begin
  if(WEn0) mem[address0] <= write_data0; // Write cpu data to ram
  mem_read_data0 <= mem[address0];	 // CPU reads from ram
  if(WEn1) mem[address1] <= write_data1; // Write ackie data to ram
  mem_read_data1 <= mem[address1];	 // Ackie reads from ram
 end

// Ackie read address decoder for peripherals
// By default read the RAM
always @(*)
 case(address1)
  12'hFFF : read_data1 = traffic_lights;
  12'hFFE : read_data1 = bargraph;
  12'hFFD : read_data1 = buzzer;
  12'hFFC : read_data1 = board_led;
  12'hFFB : read_data1 = display_enable;
  12'hFFA : read_data1 = digit5;
  12'hFF9 : read_data1 = digit4;
  12'hFF8 : read_data1 = digit3;
  12'hFF7 : read_data1 = digit2; 
  12'hFF6 : read_data1 = digit1;
  12'hFF5 : read_data1 = digit0;
  12'hFF4 : read_data1 = s6_leds;
  12'hFF3 : read_data1 = buzzer_busy;
  12'hFF2 : read_data1 = key_row4;
  12'hFF1 : read_data1 = key_row3;
  12'hFF0 : read_data1 = key_row2;
  12'hFEF : read_data1 = key_row1;
  12'hFEE : read_data1 = {s6_button1, s6_button0, board_switch2, board_switch1}; 
  default : read_data1 = mem_read_data1;
 endcase

// CPU read address decoder for peripherals
// By default read the RAM
always @(*)
 case(address0)
  12'hFFF : read_data0 = traffic_lights;
  12'hFFE : read_data0 = bargraph;
  12'hFFD : read_data0 = buzzer;
  12'hFFC : read_data0 = board_led;
  12'hFFB : read_data0 = display_enable;
  12'hFFA : read_data0 = digit5;
  12'hFF9 : read_data0 = digit4;
  12'hFF8 : read_data0 = digit3;
  12'hFF7 : read_data0 = digit2; 
  12'hFF6 : read_data0 = digit1;
  12'hFF5 : read_data0 = digit0;
  12'hFF4 : read_data0 = s6_leds;
  12'hFF3 : read_data0 = buzzer_busy;
  12'hFF2 : read_data0 = key_row4;
  12'hFF1 : read_data0 = key_row3;
  12'hFF0 : read_data0 = key_row2;
  12'hFEF : read_data0 = key_row1;
  12'hFEE : read_data0 = {s6_button1, s6_button0, board_switch2, board_switch1}; 
  default : read_data0 = mem_read_data0;
 endcase

// Write address decoder for peripherals that are just registers
// Ackie(WEn1) takes preference for writes to same address of CPU(WEn0)
// Write enables (WEn1 & WEn2) are active high
always @(posedge Clk)
 begin
  if(WEn1)
   case(address1)
    12'hFFF : traffic_lights <= write_data1[5:0];
    12'hFFE : bargraph <= write_data1[7:0];
    12'hFFC : board_led <= write_data1[0];
    12'hFFB : display_enable <= write_data1[5:0];
    12'hFFA : digit5 <= write_data1[3:0];
    12'hFF9 : digit4 <= write_data1[3:0];
    12'hFF8 : digit3 <= write_data1[3:0];
    12'hFF7 : digit2 <= write_data1[3:0];
    12'hFF6 : digit1 <= write_data1[3:0];
    12'hFF5 : digit0 <= write_data1[3:0];
    12'hFF4 : s6_leds <= write_data1[3:0];
   endcase
  if(WEn0)
   if((WEn1 == 0) | (address0 != address1)) // Just make sure that Ackie(WEn1) is not trying to write to same peripheral
    case(address0)
     12'hFFF : traffic_lights <= write_data0[5:0];
     12'hFFE : bargraph <= write_data0[7:0];
     12'hFFC : board_led <= write_data0[0];
     12'hFFB : display_enable <= write_data0[5:0];
     12'hFFA : digit5 <= write_data0[3:0];
     12'hFF9 : digit4 <= write_data0[3:0];
     12'hFF8 : digit3 <= write_data0[3:0];
     12'hFF7 : digit2 <= write_data0[3:0];
     12'hFF6 : digit1 <= write_data0[3:0];
     12'hFF5 : digit0 <= write_data0[3:0];
     12'hFF4 : s6_leds <= write_data0[3:0];
    endcase    
 end

// Address decoder for buzzer
always @(posedge Clk)
 if((WEn1) & (address1 == 12'hFFD)) //Ackie write to buzzer
  begin
   buzzer <= write_data1; 
   buzzer_run <= 1; // Let the rest of the buzzer system know that the buzzer register has been written to
  end
 else if((WEn0) & (address0 == 12'hFFD)) // CPU write to buzzer
  begin
   buzzer <= write_data0;
   buzzer_run <= 1; // Let the rest of the buzzer system know that the buzzer register has been written to
  end
 else
  buzzer_run <= 0;

// buzzer duration timer
always @(posedge Clk)
 // Check that buzzer should be run in program mode and a valid duration
 if((buzzer_run == 1) & (buzzer[11:8] != 0) & (buzzer[15] == 1))
  begin   
   buzzer_busy <= 1; // Indicate that the buzzer is running
  end
 else if(buzzer_busy)
  begin
   if(buzzer_time_step_count == buzzer[11:8]) // End of buzzer duration
    begin
     // Reset buzzer duration registers
     buzzer_clk_count <= 0;
     buzzer_time_step_count <= 0;
     buzzer_busy <= 0;
    end
   else if(buzzer_clk_count == `buzzer_time_step) // Increment buzzer time step
    begin
     buzzer_time_step_count <= buzzer_time_step_count + 1;
     buzzer_clk_count <= 0;
    end
   else
    buzzer_clk_count <= buzzer_clk_count + 1; // Keep count clock cycles to produce time delay
  end


// buzzer pulse generator
always @(posedge Clk)
 if(buzzer[15] == 0)          // Check for bypass mode
  buzzer_pulses <= buzzer[0]; // LSB drive buzzer directly in bypass mode
 else if(buzzer_busy == 0)    // Finished note, turn off buzzer 
  begin
   buzzer_pulses <= 0;
   buzzer_note_count <= 0;
  end
 else if(buzzer_busy == 1)   				// If buzzer is running in program mode
  if(buzzer_note_count == buzzer_octave_and_note)    	// Finined a cycle of note - start repeating
   begin
    buzzer_pulses <= 0;
    buzzer_note_count <= 0; 
   end
  else if(buzzer_note_count == buzzer_octave_and_note[15:1]) // Half cycle of buzzer note - toggle buzzer line
   begin
    buzzer_pulses <= 1;
    buzzer_note_count <= buzzer_note_count + 1;
   end
  else
   begin
    buzzer_note_count <= buzzer_note_count + 1; // Keep counting clock cycles for buzzer note calculation
   end
 else
  buzzer_pulses <= 0; // Buzzer not in bypass and finished in program mode - stop sending pulses to buzzer device

// buzzer note selector, uses [3:0] bits of buzzer register located at 'hFFD
always @(*)
 case(buzzer[3:0])
  0  : buzzer_note = `C4;
  1  : buzzer_note = `C4_s;
  2  : buzzer_note = `D4;
  3  : buzzer_note = `D4_s;
  4  : buzzer_note = `E4;
  5  : buzzer_note = `F4;
  6  : buzzer_note = `F4_s;
  7  : buzzer_note = `G4;
  8  : buzzer_note = `G4_s;
  9  : buzzer_note = `A5;
  10 : buzzer_note = `A5_s;
  11 : buzzer_note = `B5;
  default : buzzer_note = `C4;
 endcase

// buzzer octave selector, uses [7:4] bits of buzzer register located at 'hFFD
always @(*)
 case(buzzer[7:4])
  0,1,2,3,4 : buzzer_octave_and_note = buzzer_note; 			// Lowest octave select, no need to divide "note" delay down and change octave
  5         : buzzer_octave_and_note = {1'b0, buzzer_note[15:1]};	// divide by 2 to select octave 5
  6         : buzzer_octave_and_note = {2'b00,buzzer_note[15:2]};	// divide by 4 to select octave 6
  7         : buzzer_octave_and_note = {3'b000,buzzer_note[15:3]};	// divide by 8 to select octave 7
  8         : buzzer_octave_and_note = {4'b0000,buzzer_note[15:4]};	// divide by 16 to select octave 8
  9         : buzzer_octave_and_note = {5'b00000,buzzer_note[15:5]};	// divide by 32 to select octave 9 
  default   : buzzer_octave_and_note = 0;
 endcase

		     
   
endmodule
