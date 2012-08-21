/*! \file ofdm_txrx_mimo_regMacros.h
\brief Header file for PHY register access

@author Patrick Murphy

This header file contains macros using the naming scheme previously used by sysgen2opb. These are the macros warpphy/warpmac call to interact with the PHY.
This file will only be used with EDK 10.1+ designs. For projects built using sysgen2opb and EDK 9.1, these macros will be defined by the ofdm_txrx_mimo.h header
created by sysgen2opb during the EDK export from sysgen.
*/

//"XPAR_OFDM_TXRX_MIMO_PLBW_0_XC_VERSION" only defined if PLB46 version of the PHY is being used
#ifdef XPAR_OFDM_TXRX_MIMO_PLBW_0_XC_VERSION
#include "xbasic_types.h"
#include "xstatus.h"
#include "xio.h"

//Macros to write PHY registers, using naming scheme from sysgen2opb's auto-generated driver header
#define OFDM_AGC_MIMO_WriteReg_SRESET_IN(BaseAddress, Value) 	XIo_Out32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_SRESET_IN, (Xuint32)(Value))
#define OFDM_AGC_MIMO_WriteReg_MRESET_IN(BaseAddress, Value) 	XIo_Out32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_MRESET_IN, (Xuint32)(Value))
#define OFDM_AGC_MIMO_WriteReg_T_dB(BaseAddress, Value) 	XIo_Out32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_T_DB, (Xuint32)(Value))
#define OFDM_AGC_MIMO_WriteReg_DCO_Timing(BaseAddress, Value) 	XIo_Out32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_DCO_TIMING, (Xuint32)(Value))
#define OFDM_AGC_MIMO_WriteReg_AGC_EN(BaseAddress, Value) 	XIo_Out32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_AGC_EN, (Xuint32)(Value))
#define OFDM_AGC_MIMO_WriteReg_AVG_LEN(BaseAddress, Value) 	XIo_Out32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_AVG_LEN, (Xuint32)(Value))
#define OFDM_AGC_MIMO_WriteReg_Timing(BaseAddress, Value) 	XIo_Out32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_TIMING, (Xuint32)(Value))
#define OFDM_AGC_MIMO_WriteReg_Thresholds(BaseAddress, Value) 	XIo_Out32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_THRESHOLDS, (Xuint32)(Value))
#define OFDM_AGC_MIMO_WriteReg_ADJ(BaseAddress, Value) 	XIo_Out32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_ADJ, (Xuint32)(Value))
#define OFDM_AGC_MIMO_WriteReg_GBB_init(BaseAddress, Value) 	XIo_Out32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_GBB_INIT, (Xuint32)(Value))
#define OFDM_AGC_MIMO_WriteReg_Bits(BaseAddress, Value) 	XIo_Out32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_BITS_W, (Xuint32)(Value))

//Macros to read PHY registers, using naming scheme from sysgen2opb's auto-generated driver header
#define OFDM_AGC_MIMO_ReadReg_GBB_A(BaseAddress) 	XIo_In32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_GBB_A)
#define OFDM_AGC_MIMO_ReadReg_GBB_B(BaseAddress) 	XIo_In32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_GBB_B)
#define OFDM_AGC_MIMO_ReadReg_GRF_A(BaseAddress) 	XIo_In32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_GRF_A)
#define OFDM_AGC_MIMO_ReadReg_GRF_B(BaseAddress) 	XIo_In32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_GRF_B)
#define OFDM_AGC_MIMO_ReadReg_Bits(BaseAddress) 	XIo_In32(XPAR_OFDM_AGC_MIMO_PLBW_0_MEMMAP_BITS_R)

//Macros that were defined in the sysgen2opb driver, but were never used; these are not defined for the PLB46 version of the core
//#define OFDM_AGC_MIMO_WriteReg_GBB_A(BaseAddress, Value) 	XIo_Out32((BaseAddress) + (OFDM_AGC_MIMO_GBB_A_OFFSET), (Xuint32)(Value))
//#define OFDM_AGC_MIMO_WriteReg_GBB_B(BaseAddress, Value) 	XIo_Out32((BaseAddress) + (OFDM_AGC_MIMO_GBB_B_OFFSET), (Xuint32)(Value))
//#define OFDM_AGC_MIMO_WriteReg_GRF_B(BaseAddress, Value) 	XIo_Out32((BaseAddress) + (OFDM_AGC_MIMO_GRF_B_OFFSET), (Xuint32)(Value))
//#define OFDM_AGC_MIMO_WriteReg_GRF_A(BaseAddress, Value) 	XIo_Out32((BaseAddress) + (OFDM_AGC_MIMO_GRF_A_OFFSET), (Xuint32)(Value))
//#define OFDM_AGC_MIMO_ReadReg_SRESET_IN(BaseAddress) 	XIo_In32((BaseAddress) + (OFDM_AGC_MIMO_SRESET_IN_OFFSET))
//#define OFDM_AGC_MIMO_ReadReg_MRESET_IN(BaseAddress) 	XIo_In32((BaseAddress) + (OFDM_AGC_MIMO_MRESET_IN_OFFSET))
//#define OFDM_AGC_MIMO_ReadReg_T_dB(BaseAddress) 	XIo_In32((BaseAddress) + (OFDM_AGC_MIMO_T_dB_OFFSET))
//#define OFDM_AGC_MIMO_ReadReg_DCO_Timing(BaseAddress) 	XIo_In32((BaseAddress) + (OFDM_AGC_MIMO_DCO_Timing_OFFSET))
//#define OFDM_AGC_MIMO_ReadReg_AGC_EN(BaseAddress) 	XIo_In32((BaseAddress) + (OFDM_AGC_MIMO_AGC_EN_OFFSET))
//#define OFDM_AGC_MIMO_ReadReg_AVG_LEN(BaseAddress) 	XIo_In32((BaseAddress) + (OFDM_AGC_MIMO_AVG_LEN_OFFSET))
//#define OFDM_AGC_MIMO_ReadReg_Bits(BaseAddress) 	XIo_In32((BaseAddress) + (OFDM_AGC_MIMO_Bits_OFFSET))
//#define OFDM_AGC_MIMO_ReadReg_Timing(BaseAddress) 	XIo_In32((BaseAddress) + (OFDM_AGC_MIMO_Timing_OFFSET))
//#define OFDM_AGC_MIMO_ReadReg_Thresholds(BaseAddress) 	XIo_In32((BaseAddress) + (OFDM_AGC_MIMO_Thresholds_OFFSET))
//#define OFDM_AGC_MIMO_ReadReg_ADJ(BaseAddress) 	XIo_In32((BaseAddress) + (OFDM_AGC_MIMO_ADJ_OFFSET))
//#define OFDM_AGC_MIMO_ReadReg_GBB_init(BaseAddress) 	XIo_In32((BaseAddress) + (OFDM_AGC_MIMO_GBB_init_OFFSET))

#endif
