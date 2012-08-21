module radio_controller_TxTiming
(
	clk,
	reset,
	
	Tx_swEnable,
	
	TxGain_target,
	TxGain_rampGainStep,
	TxGain_rampTimeStep,
	
	dly_hwTxEn,
	dly_TxStart,
	dly_PowerAmpEn,
	dly_RampGain,
	
	hw_TxEn,
	hw_TxGain,
	hw_PAEn,
	hw_TxStart
);

	input			clk;
	input			reset;
	
	input			Tx_swEnable;
	input	[0:5]	TxGain_target;
	input	[0:3]	TxGain_rampGainStep;
	input	[0:3]	TxGain_rampTimeStep;
	
	input	[0:7]	dly_hwTxEn;
	input	[0:7]	dly_TxStart;
	input	[0:7]	dly_PowerAmpEn;
	input	[0:7]	dly_RampGain;

	output			hw_TxEn;
	output			hw_TxStart;
	output			hw_PAEn;
	output	[0:5]	hw_TxGain;

	reg		[0:7]	GainRamp_clockEn_counter;
	reg		[0:7]	timing_counter;

	wire 	[0:6]	NewTxGain;
	reg  	[0:6]	TxGainBig;
	
	wire AutoGainRampEn;


	//The output gain signal is the output of an accumulator, enabled after dly_RampGain clock cycles
	//This signal is the input to the accumulator register. TxGainBig has one extra MSB to ease overflow detection
	assign NewTxGain = ( (TxGainBig + TxGain_rampGainStep) > TxGain_target) ? TxGain_target : (TxGainBig + TxGain_rampGainStep);

	//The hw_TxGain output, which eventually connects to the radio's parallel gain control bus,
	//	gets the 6 LSB of the internal accumulator value
	assign hw_TxGain = TxGainBig[1:6];

	//Enable the outputs when the timing counter has excedded the various control thresholds given by the dly_* inputs
	//	A delay value of 254 will hold the corresponding output high forever
	//	A delay value of 255 will hold the corresponding output low forever (the counter below never reaches 255)
	assign hw_TxEn = (timing_counter > dly_hwTxEn) || dly_hwTxEn == 8'd254;
	assign hw_PAEn = (timing_counter > dly_PowerAmpEn) || dly_PowerAmpEn == 8'd254;
	assign hw_TxStart = (timing_counter > dly_TxStart) || dly_TxStart == 8'd254;

	//Enable the gain ramp accumulator after the given delay
	//	A delay value of 254 or 255 will disable the gain ramp, regardless of the ramp parameters
	assign AutoGainRampEn = timing_counter > dly_RampGain;

	//Instiantiates a counter which runs once the timing counter exceeds the threshold
	//	for starting the ramping of Tx gains; the counter increments every TxGain_rampTimeStep cycles
	always @( posedge clk )
	begin
		if(reset | ~Tx_swEnable)
			TxGainBig <= 0;
		else if( AutoGainRampEn & (GainRamp_clockEn_counter==1))
			TxGainBig <= NewTxGain;
	end

	//Instantiate a counter that starts when the software enables Tx mode
	// This counter intentionally stops at 253, allowing delay values of 254 and 255 to have other uses
	always @( posedge clk )
	begin
		if(reset | ~Tx_swEnable)
			timing_counter <= 0;
		else if(Tx_swEnable & timing_counter < 254)
			timing_counter <= timing_counter + 1;
	end

	//Instantiate a counter used to drive the clock enable of the gain ramp counter above
	always @( posedge clk )
	begin
		if(reset | GainRamp_clockEn_counter == TxGain_rampTimeStep)
			GainRamp_clockEn_counter <= 0;
		else
			GainRamp_clockEn_counter <= GainRamp_clockEn_counter + 1;
	end
endmodule
