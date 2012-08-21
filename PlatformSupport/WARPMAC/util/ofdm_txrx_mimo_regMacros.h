/*! \file ofdm_txrx_mimo_regMacros.h
\brief Header file for PHY register access

@author Patrick Murphy

This header file contains macros using the naming scheme previously used by sysgen2opb. These are the macros warpphy/warpmac call to interact with the PHY.
This file will only be used with EDK 10.1+ designs. For projects built using sysgen2opb and EDK 9.1, these macros will be defined by the ofdm_txrx_mimo.h header
created by sysgen2opb during the EDK export from sysgen.
*/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xio.h"

//PKTDET MACROS

//Shortcuts for register bit masks
// Masks for pktDet_status read-only register XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_STATUS
#define PKTDET_IDLEDIFS	0x1
#define PKTDET_DETANTA	0x2
#define PKTDET_DETANTB	0x4
#define PKTDET_IDLECOUNT 0x3FF0

// Masks for pktDet_controlBits read-write register XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_CONTROLBITS_W
#define PKTDET_RESETSUM		0x01 //1=Reset running averagers
#define PKTDET_IGNOREDET	0x02 //1=disable pktDet output
#define PKTDET_RSSICLKRATIO	0x04 //0=sys_clk/4, 1=sys_clk/8
#define PKTDET_CSMAENIDLE	0x08 //Enable IDLE output & register
#define PKTDET_DETMODE		0x10 //1=OR ANTA/ANTB, 0=AND ANTA/ANTB
#define PKTDET_MASK_ANTA	0x20 //1=listen to AntA for pktDet
#define PKTDET_MASK_ANTB	0x40 //1=listen to AntB for pktDet
#define PKTDET_ANTMASKS		(PKTDET_MASK_ANTA | PKTDET_MASK_ANTB) //1=listen to ANT A for detections, 2=listen to ANT B, 3=listen to both
#define PKTDET_EXTDETEN		0x80
#define PKTDET_RSSIDETEN	0x100
#define PKTDET_CORRDETEN	0x200

// Masks for pktDet_durations read-write register XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_DURATIONS_W
#define PKTDET_MINDURATION_MASK		0x00007FF //UFix11_0, 11 LSB
#define PKTDET_DIFSPERIOD_MASK		0x01FF800 //UFix10_0, ll-bits offset from LSB
#define PKTDET_RSSIAVGLENGTH_MASK	0x3E00000 //UFix5_0, 21-bits offset from LSB

//Masks for pktDet_thresholds read-write register XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_THRESHOLDS_W
#define PKTDET_DETTHRESH_MASK		0xFFFF //UFix16_0, 16LSB
#define PKTDET_CSMATHRESH_MASK		0xFFFF0000 //UFix16_0, 16MSB

//The packet detector captures the output of its running RSSI sums when the incoming packet's payload starts (after the preamble)
#define ofdm_txrx_mimo_ReadReg_Rx_PktDet_midPktRSSI_antA() (XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_MIDPACKETRSSI)&0xFFFF) //16 LSB is antenna A
#define ofdm_txrx_mimo_ReadReg_Rx_PktDet_midPktRSSI_antB() ( (XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_MIDPACKETRSSI)&0xFFFF0000) >> 16) //16 MSB is antenna B

#define ofdm_txrx_mimo_ReadReg_Rx_PktDet_idleForDifs() (XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_STATUS)&PKTDET_IDLEDIFS)

#define ofdm_txrx_mimo_WriteReg_Rx_PktDet_resetSum(Value)	(XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_CONTROLBITS_W,(XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_CONTROLBITS_R)&(~PKTDET_RESETSUM))|((Value<<0)&PKTDET_RESETSUM)))
#define ofdm_txrx_mimo_WriteReg_Rx_PktDet_ignoreDet(Value)	(XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_CONTROLBITS_W,(XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_CONTROLBITS_R)&(~PKTDET_IGNOREDET))|((Value<<1)&PKTDET_IGNOREDET)))
#define ofdm_txrx_mimo_WriteReg_Rx_PktDet_setRSSIclkRatio(Value)	(XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_CONTROLBITS_W,(XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_CONTROLBITS_R)&(~PKTDET_RSSICLKRATIO))|((Value<<2)&PKTDET_RSSICLKRATIO)))
#define ofdm_txrx_mimo_WriteReg_Rx_CSMA_enableIdle(Value)	(XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_CONTROLBITS_W,(XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_CONTROLBITS_R)&(~PKTDET_CSMAENIDLE))|((Value<<3)&PKTDET_CSMAENIDLE)))
#define ofdm_txrx_mimo_WriteReg_Rx_PktDet_setMode(Value)	(XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_CONTROLBITS_W,(XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_CONTROLBITS_R)&(~PKTDET_DETMODE))|((Value<<4)&PKTDET_DETMODE)))
#define ofdm_txrx_mimo_WriteReg_Rx_PktDet_setMask(Value)	(XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_CONTROLBITS_W,(XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_CONTROLBITS_R)&(~PKTDET_ANTMASKS))|((Value)&PKTDET_ANTMASKS)))
#define ofdm_txrx_mimo_WriteReg_Rx_PktDet_extDetEn(Value)	(XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_CONTROLBITS_W,(XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_CONTROLBITS_R)&(~PKTDET_EXTDETEN))|((Value)*PKTDET_EXTDETEN)))

#define ofdm_txrx_mimo_WriteReg_Rx_PktDet_rssiDetEn(Value)	(XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_CONTROLBITS_W,(XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_CONTROLBITS_R)&(~PKTDET_RSSIDETEN))|((Value)*PKTDET_RSSIDETEN)))
#define ofdm_txrx_mimo_WriteReg_Rx_PktDet_corrDetEn(Value)	(XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_CONTROLBITS_W,(XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_CONTROLBITS_R)&(~PKTDET_CORRDETEN))|((Value)*PKTDET_CORRDETEN)))

#define ofdm_txrx_mimo_WriteReg_Rx_PktDet_setMinDuration(Value)	(XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_DURATIONS_W,(XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_DURATIONS_R)&(~PKTDET_MINDURATION_MASK))|((Value<<0)&PKTDET_MINDURATION_MASK)))
#define ofdm_txrx_mimo_WriteReg_Rx_PktDet_setDIFSPeriod(Value)	(XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_DURATIONS_W,(XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_DURATIONS_R)&(~PKTDET_DIFSPERIOD_MASK))|((Value<<11)&PKTDET_DIFSPERIOD_MASK)))
#define ofdm_txrx_mimo_WriteReg_Rx_PktDet_setAvgLen(Value)	(XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_DURATIONS_W,(XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_DURATIONS_R)&(~PKTDET_RSSIAVGLENGTH_MASK))|((Value<<21)&PKTDET_RSSIAVGLENGTH_MASK)))

#define ofdm_txrx_mimo_WriteReg_Rx_PktDet_setThresh(Value)	(XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_THRESHOLDS_W,(XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_THRESHOLDS_R)&(~PKTDET_DETTHRESH_MASK))|((Value<<0)&PKTDET_DETTHRESH_MASK)))
#define ofdm_txrx_mimo_WriteReg_Rx_CSMA_setThresh(Value)	(XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_THRESHOLDS_W,(XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_THRESHOLDS_R)&(~PKTDET_CSMATHRESH_MASK))|((Value<<16)&PKTDET_CSMATHRESH_MASK)))
#define ofdm_txrx_mimo_WriteReg_Rx_PktDetCorr_params(corrThresh, corrMinPower) (XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_PKTDET_AUTOCORRPARAMS_W, ((corrThresh & 0xFF) | ((corrMinPower&0xFFFF)<<8))))

//Macros to write PHY registers, using naming scheme from sysgen2opb's auto-generated driver header
#define ofdm_txrx_mimo_WriteReg_Rx_ControlBits(BaseAddress, Value)  XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_CONTROLBITS_W, (Xuint32)(Value))
#define ofdm_txrx_mimo_WriteReg_Rx_OFDM_SymbolCounts(BaseAddress, Value)  XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_OFDM_SYMBOLCOUNTS_W, (Xuint32)(Value))
#define ofdm_txrx_mimo_WriteReg_Rx_PktDet_Delay(BaseAddress, Value)  XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_PKTDET_DELAY_W, (Xuint32)(Value))
#define ofdm_txrx_mimo_WriteReg_Rx_PktDet_LongCorr_Params(BaseAddress, Value)  XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_PKTDET_LONGCORR_PARAMS_W, (Xuint32)(Value))
#define ofdm_txrx_mimo_WriteReg_Rx_pktByteNums(BaseAddress, Value)  XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_PKTBYTENUMS_W, (Xuint32)(Value))
#define ofdm_txrx_mimo_WriteReg_Rx_pktDet_Tresholds(BaseAddress, Value)  XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_PKTDET_TRESHOLDS_W, (Xuint32)(Value))
#define ofdm_txrx_mimo_WriteReg_TxRx_FFT_Scaling(BaseAddress, Value)  XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_FFT_SCALING_W, (Xuint32)(Value))
#define ofdm_txrx_mimo_WriteReg_TxRx_Interrupt_PktBuf_Ctrl(BaseAddress, Value)  XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_INTERRUPT_PKTBUF_CTRL_W, (Xuint32)(Value))
#define ofdm_txrx_mimo_WriteReg_Rx_Constellation_Scaling(BaseAddress, Value)  XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_CONSTELLATION_SCALING_W, (Xuint32)(Value))
#define ofdm_txrx_mimo_WriteReg_Tx_Scaling(BaseAddress, Value)  XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TX_SCALING_W, (Xuint32)(Value))

#define ofdm_txrx_mimo_WriteReg_TxRx_Pilots_Index(BaseAddress, Value) XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_PILOTS_INDEX_W, (Xuint32)(Value))
#define ofdm_txrx_mimo_WriteReg_TxRx_Pilots_Values(BaseAddress, Value) XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_PILOTS_VALUES_W, (Xuint32)(Value))
#define ofdm_rx_mimo_WriteReg_Rx_AFScaling(BaseAddress, Value) XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_AF_TXSCALING_W, (Xuint32)(Value))
#define ofdm_rx_mimo_WriteReg_Rx_PilotCalcParams(BaseAddress, Value) XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_PILOTCALCPARAMS_W,  (Xuint32)(Value))

#define ofdm_txrx_mimo_Readreg_Rx_CFOest_Coarse(BaseAddress, Value) XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_COARSECFOEST)
#define ofdm_txrx_mimo_Readreg_Rx_CFOest_Pilots(BaseAddress, Value) XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_PILOTCFOEST)

#define ofdm_txrx_mimo_WriteReg_Tx_OFDM_SymCounts(BaseAddress, Value)  XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TX_OFDM_SYMCOUNTS_W, (Xuint32)(Value))
#define ofdm_txrx_mimo_WriteReg_Tx_PreambleMasking(BaseAddress, Value)  XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TX_PREAMBLEMASKING_W, (Xuint32)(Value))
#define ofdm_txrx_mimo_WriteReg_Tx_Start_Reset_Control(BaseAddress, Value)  XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TX_START_RESET_CONTROL_W, (Xuint32)(Value))
#define ofdm_txrx_mimo_WriteReg_Tx_ControlBits(BaseAddress, Value)  XIo_Out32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TX_CONTROLBITS_W, (Xuint32)(Value))

//Macros to read PHY registers, using naming scheme from sysgen2opb's auto-generated driver header
#define ofdm_txrx_mimo_ReadReg_Rx_ControlBits(BaseAddress)  XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_CONTROLBITS_R)
#define ofdm_txrx_mimo_ReadReg_Rx_OFDM_SymbolCounts(BaseAddress)  XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_OFDM_SYMBOLCOUNTS_R)
#define ofdm_txrx_mimo_ReadReg_Rx_PktDet_Delay(BaseAddress)  XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_PKTDET_DELAY_R)
#define ofdm_txrx_mimo_ReadReg_Rx_PktDet_LongCorr_Params(BaseAddress)  XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_PKTDET_LONGCORR_PARAMS_R)
#define ofdm_txrx_mimo_ReadReg_Rx_pktByteNums(BaseAddress)  XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_PKTBYTENUMS_R)
#define ofdm_txrx_mimo_ReadReg_TxRx_Interrupt_PktBuf_Ctrl(BaseAddress)  XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TXRX_INTERRUPT_PKTBUF_CTRL_R)
#define ofdm_txrx_mimo_ReadReg_Tx_OFDM_SymCounts(BaseAddress)  XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TX_OFDM_SYMCOUNTS_R)
#define ofdm_txrx_mimo_ReadReg_Tx_Start_Reset_Control(BaseAddress)  XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TX_START_RESET_CONTROL_R)
#define ofdm_txrx_mimo_ReadReg_Tx_ControlBits(BaseAddress)  XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TX_CONTROLBITS_R)
#define ofdm_txrx_mimo_ReadReg_Rx_Gains(BaseAddress)  XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_GAINS)
#define ofdm_txrx_mimo_ReadReg_Rx_BER_Errors(BaseAddress)  XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_BER_ERRORS)
#define ofdm_txrx_mimo_ReadReg_Rx_BER_TotalBits(BaseAddress)  XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_BER_TOTALBITS)
#define ofdm_txrx_mimo_ReadReg_Rx_packet_done(BaseAddress)  XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_RX_PKTDONE_INTERRUPTSTATUS)
#define ofdm_txrx_mimo_ReadReg_Tx_PktRunning(BaseAddress) XIo_In32(XPAR_OFDM_TXRX_MIMO_PLBW_0_MEMMAP_TX_PKTRUNNING)
