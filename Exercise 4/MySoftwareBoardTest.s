;Created by Horia Gabriel Radu
;This programme is a ticking/timer type of device, that, when is set by pressing the switch button, it has to be defused (by a key button) before the time passes otherwise it will trigger a continuous sound
;The continuous sound can be  stopped by pressing reset and the whole programme can be stopped by pressing the top right key

progbar	EQU	&FFE		;output for progress bar
buzzin	EQU	&FFD		;output for buzzer input
switch	EQU	&FEE		;switch input
traffic	EQU	&FFF		;output for traffic lights
keyr1	EQU	&FEF		;input for keyrows 1 to 4
keyr2	EQU	&FF0
keyr3	EQU	&FF1
keyr4	EQU	&FF2
displayen	EQU	&FFB	;output for the display enabler
digit0	EQU	&FF5		;output for each digit of the display
digit1	EQU	&FF6
digit2	EQU	&FF7
digit3	EQU	&FF8
digit4	EQU	&FF9
digit5	EQU	&FFA

	ORG     0



loop					;loop where it checks if the main loop should start

	LDA	green			;loading and storing all the basics while waiting to start
	STA	traffic
	LDA	proge
	STA	progbar
	LDA	den
	STA	displayen
	LDA	zero
	STA	digit5
	STA	digit4
	STA	digit3
	STA	digit2
	STA	digit1
	STA	digit0

	LDA	keyr1			;checking if the stop button was pressed
	SUB	stopbutton
	JNE	continue
	JMP	stop

continue
	LDA	switch			;checking if the switch was pressed and if so, it should go in the main_loop and stop repeating loop
	SUB	one
	JNE	loop

	LDA	d
	STA	digit5
	LDA	e
	STA	digit4
	LDA	f
	STA	digit3
	LDA	u
	STA	digit2
	LDA	s
	STA	digit1
	LDA	e
	STA	digit0


main_loop				;main loop where it cycles through the progress bar and it speeds up in every iteration
	LDA	amber
	STA	traffic

	LDA	tone1			;outputs a sound then the loop begins
	STA	buzzin

	LDA	prog1			;output a light on the prog bar
	STA	progbar			;but also wait a specific delay each time
	LDA	delay
delayloop1
	SUB	one
	JNE	delayloop1		;the same for the rest below

	LDA	prog2
	STA	progbar
	LDA	delay
delayloop2
	SUB	one
	JNE	delayloop2

	LDA	prog3
	STA	progbar
	LDA	delay
delayloop3
	SUB	one
	JNE	delayloop3

	LDA	prog4
	STA	progbar
	LDA	delay
delayloop4
	SUB	one
	JNE	delayloop4

	LDA	prog5
	STA	progbar
	LDA	delay
delayloop5
	SUB	one
	JNE	delayloop5

	LDA	prog6
	STA	progbar
	LDA	delay
delayloop6
	SUB	one
	JNE	delayloop6

	LDA	prog7
	STA	progbar
	LDA	delay
delayloop7
	SUB	one
	JNE	delayloop7

	LDA	tone2			;outputs another sound when the prog bar hits the other part
	STA	buzzin

	LDA	prog8
	STA	progbar
	LDA	delay
delayloop8
	SUB	one
	JNE	delayloop8

	LDA	prog7
	STA	progbar
	LDA	delay
delayloop9
	SUB	one
	JNE	delayloop9

	LDA	prog6
	STA	progbar
	LDA	delay
delayloop10
	SUB	one
	JNE	delayloop10

	LDA	prog5
	STA	progbar
	LDA	delay
delayloop11
	SUB	one
	JNE	delayloop11

	LDA	prog4
	STA	progbar
	LDA	delay
delayloop12
	SUB	one
	JNE	delayloop12

	LDA	prog3
	STA	progbar
	LDA	delay
delayloop13
	SUB	one
	JNE	delayloop13

	LDA	prog2
	STA	progbar
	LDA	delay
delayloop14
	SUB	one
	JNE	delayloop14

	
	LDA	keyr2			;checks if the defuse key has been pressed, and if so, resets the programme
	SUB	Dbutton			;this is the defuse key
	JNE	progfaster
	JMP	reset

progfaster				;makes the progress bar run faster each time
	LDA	delay
	SUB	counter			;substracts an amount (counter) from the delay
	STA	delay
	JGE	main_loop		;if it is still not maximum speed, repeat the loop

					;from here down executes the last part of the programme, if the defuse button is not pressed
	LDA	progfull
	STA	progbar
	LDA	red
	STA	traffic
bdelay					;keeps on buzzing and flashing until the reset button is pressed
	LDA	dboom
	STA	digit5
	STA	digit4
	STA	digit3
	STA	digit2
	STA	digit1
	STA	digit0
	ADD	one
	STA	dboom
	LDA	boom			;stores the boom sound
	STA	buzzin
	LDA	keyr4
	SUB	resetbutton		;checks for the reset button
	JNE	bdelay			;if it is not pressed repeat
	JMP	reset			;if it is pressed, reset
	

reset				;for when you want to reset and go back to initial state and reassign all variables back to their initial value
	LDA	delayinitial
	STA	delay
	LDA	timesI
	STA	times
	JMP	loop

stop				;for when you want to stop the whole program
	LDA	zero
	STA	progbar
	STA	traffic
	LDA	delayinitial
	STA	delay
	STP


delayinitial	DEFW	&8000		;initial delay
delay	DEFW	&6000			;current delay
one	DEFW	&0001			;substration variable for the delays
counter DEFW	&0500			;counter to make it go faster
times	DEFW	&14
timesI	DEFW	&14

;every progress bar light, one by one
prog1	DEFW	&01
prog2	DEFW	&02
prog3	DEFW	&04
prog4	DEFW	&08
prog5	DEFW	&10
prog6	DEFW	&20
prog7	DEFW	&40
prog8	DEFW	&80
progfull	DEFW	&FF		;the whole progress bar lit up
proge	DEFW	&AA			;the beginning progress bar

;music tones for each sound
tone1	DEFW	&8172
tone2	DEFW	&817F
boom	DEFW	&818F

;traffic lights
green	DEFW	&9
amber	DEFW	&12
red	DEFW	&24

;display enable and digits to display
den	DEFW	&03F
zero	DEFW	&0
d	DEFW	&D
e	DEFW	&E
f	DEFW	&F
u	DEFW	&0
s	DEFW	&5
dboom	DEFW	&0

;buttons to check specific actions
Dbutton	DEFW	&40
resetbutton	DEFW	&80
stopbutton	DEFW	&1
