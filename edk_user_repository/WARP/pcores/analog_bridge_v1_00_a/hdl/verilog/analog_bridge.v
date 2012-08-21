//////////////////////////////////////////////////////////
// Copyright (c) 2006 Rice University 			//
// All Rights Reserved 					//
// This code is covered by the Rice-WARP license 	//
// See http://warp.rice.edu/license/ for details 	//
//////////////////////////////////////////////////////////

module analog_bridge
(
	clock_in,
	clock_out,
	
	user_DAC1_A,
	user_DAC1_B,
	user_DAC2_A,
	user_DAC2_B,
	user_DAC1_sleep,
	user_DAC2_sleep,
	user_ADC_A,
	user_ADC_B,
	user_ADC_DFS,
	user_ADC_DCS,
	user_ADC_pdwnA,
	user_ADC_pdwnB,
	user_ADC_otrA,
	user_ADC_otrB,
	user_LED,
		
	analog_DAC1_A,
	analog_DAC1_B,
	analog_DAC2_A,
	analog_DAC2_B,
	analog_DAC1_sleep,
	analog_DAC2_sleep,
	analog_ADC_A,
	analog_ADC_B,
	analog_ADC_DFS,
	analog_ADC_DCS,
	analog_ADC_pdwnA,
	analog_ADC_pdwnB,
	analog_ADC_otrA,
	analog_ADC_otrB,
	analog_LED
);

/**********************/
/* Clock & Data Ports */
/**********************/
input	clock_in;
output	clock_out;

input [0:13] user_DAC1_A;
input [0:13] user_DAC1_B;
input [0:13] user_DAC2_A;
input [0:13] user_DAC2_B;
input user_DAC1_sleep;
input user_DAC2_sleep;

output [0:13] user_ADC_A;
output [0:13] user_ADC_B;
reg [0:13] user_ADC_A;
reg [0:13] user_ADC_B;

input user_ADC_DFS;
input user_ADC_DCS;
input user_ADC_pdwnA;
input user_ADC_pdwnB;
output user_ADC_otrA;
output user_ADC_otrB;
input [0:2] user_LED;


output [0:13] analog_DAC1_A;
output [0:13] analog_DAC1_B;
output [0:13] analog_DAC2_A;
output [0:13] analog_DAC2_B;
reg [0:13] analog_DAC1_A;
reg [0:13] analog_DAC1_B;
reg [0:13] analog_DAC2_A;
reg [0:13] analog_DAC2_B;

output analog_DAC1_sleep;
output analog_DAC2_sleep;
reg analog_DAC1_sleep;
reg analog_DAC2_sleep;

input [0:13] analog_ADC_A;
input [0:13] analog_ADC_B;

output analog_ADC_DFS;
output analog_ADC_DCS;
output analog_ADC_pdwnA;
output analog_ADC_pdwnB;
input analog_ADC_otrA;
input analog_ADC_otrB;
output [0:2] analog_LED;


wire [0:13] temp_analog_DAC1_A;
wire [0:13] temp_analog_DAC1_B;
wire [0:13] temp_analog_DAC2_A;
wire [0:13] temp_analog_DAC2_B;

/**********************************/
/* Clocks and analog data signals */
/**********************************/
assign clock_out = clock_in;


assign temp_analog_DAC1_A = user_DAC1_A[0:13];
assign temp_analog_DAC1_B = user_DAC1_B[0:13];
assign temp_analog_DAC2_A = user_DAC2_A[0:13];
assign temp_analog_DAC2_B = user_DAC2_B[0:13];

assign analog_ADC_DFS = user_ADC_DFS;
assign analog_ADC_DCS = user_ADC_DCS;
assign analog_ADC_pdwnA = user_ADC_pdwnA;
assign analog_ADC_pdwnB = user_ADC_pdwnB;
assign user_ADC_otrA = analog_ADC_otrA;
assign user_ADC_otrB = analog_ADC_otrB;
assign analog_LED = user_LED;


// synthesis attribute iob of analog_DAC1_A is true;
// synthesis attribute iob of analog_DAC1_B is true;
// synthesis attribute iob of analog_DAC2_A is true;
// synthesis attribute iob of analog_DAC2_B is true;
always @(posedge clock_in)
begin
	analog_DAC1_A <= {temp_analog_DAC1_A[0], ~temp_analog_DAC1_A[1:13]};
	analog_DAC1_B <= {temp_analog_DAC1_B[0], ~temp_analog_DAC1_B[1:13]};
	analog_DAC2_A <= {temp_analog_DAC2_A[0], ~temp_analog_DAC2_A[1:13]};
	analog_DAC2_B <= {temp_analog_DAC2_B[0], ~temp_analog_DAC2_B[1:13]};
	analog_DAC1_sleep <= user_DAC1_sleep;
	analog_DAC2_sleep <= user_DAC2_sleep;
	user_ADC_A <= analog_ADC_A;
	user_ADC_B <= analog_ADC_B;
end

endmodule
