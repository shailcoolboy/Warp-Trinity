//Register write macros
#define warplab_mimo_4x4_WriteReg_TxDelay(addr, data) XIo_Out32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_TXDELAY, data)
#define warplab_mimo_4x4_WriteReg_RADIO1RXBUFF_RXEN(addr, data) XIo_Out32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_RADIO1RXBUFF_RXEN, data)
#define warplab_mimo_4x4_WriteReg_RADIO1TXBUFF_TXEN(addr, data) XIo_Out32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_RADIO1TXBUFF_TXEN, data)
#define warplab_mimo_4x4_WriteReg_RADIO2RXBUFF_RXEN(addr, data) XIo_Out32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_RADIO2RXBUFF_RXEN, data)
#define warplab_mimo_4x4_WriteReg_RADIO2TXBUFF_TXEN(addr, data) XIo_Out32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_RADIO2TXBUFF_TXEN, data)
#define warplab_mimo_4x4_WriteReg_RADIO3RXBUFF_RXEN(addr, data) XIo_Out32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_RADIO3RXBUFF_RXEN, data)
#define warplab_mimo_4x4_WriteReg_RADIO3TXBUFF_TXEN(addr, data) XIo_Out32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_RADIO3TXBUFF_TXEN, data)
#define warplab_mimo_4x4_WriteReg_RADIO4RXBUFF_RXEN(addr, data) XIo_Out32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_RADIO4RXBUFF_RXEN, data)
#define warplab_mimo_4x4_WriteReg_RADIO4TXBUFF_TXEN(addr, data) XIo_Out32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_RADIO4TXBUFF_TXEN, data)
#define warplab_mimo_4x4_WriteReg_StartCapture(addr, data) XIo_Out32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_STARTCAPTURE, data)
#define warplab_mimo_4x4_WriteReg_StartTx(addr, data) XIo_Out32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_STARTTX, data)
#define warplab_mimo_4x4_WriteReg_StopTx(addr, data) XIo_Out32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_STOPTX, data)
#define warplab_mimo_4x4_WriteReg_TransMode(addr, data) XIo_Out32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_TRANSMODE, data)
#define warplab_mimo_4x4_WriteReg_TxLength(addr, data) XIo_Out32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_TXLENGTH, data)
#define warplab_mimo_4x4_WriteReg_DebugRx1Buffers(addr, data) XIo_Out32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_DEBUGRX1BUFFERS, data)
#define warplab_mimo_4x4_WriteReg_DebugRx2Buffers(addr, data) XIo_Out32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_DEBUGRX2BUFFERS, data)
#define warplab_mimo_4x4_WriteReg_DebugRx3Buffers(addr, data) XIo_Out32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_DEBUGRX3BUFFERS, data)
#define warplab_mimo_4x4_WriteReg_DebugRx4Buffers(addr, data) XIo_Out32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_DEBUGRX4BUFFERS, data)



//Register read macros
#define warplab_mimo_4x4_ReadReg_TxDelay(addr) XIo_In32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_TXDELAY)
#define warplab_mimo_4x4_ReadReg_CaptOffset(addr) XIo_In32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_CAPTOFFSET)
#define warplab_mimo_4x4_ReadReg_CaptureDone(addr) XIo_In32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_CAPTUREDONE)
#define warplab_mimo_4x4_ReadReg_TransMode(addr) XIo_In32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_TRANSMODE)
#define warplab_mimo_4x4_ReadReg_TxLength(addr) XIo_In32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_TXLENGTH)
#define warplab_mimo_4x4_ReadReg_DebugRx1Buffers(addr) XIo_In32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_DEBUGRX1BUFFERS)
#define warplab_mimo_4x4_ReadReg_DebugRx2Buffers(addr) XIo_In32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_DEBUGRX2BUFFERS)
#define warplab_mimo_4x4_ReadReg_DebugRx3Buffers(addr) XIo_In32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_DEBUGRX3BUFFERS)
#define warplab_mimo_4x4_ReadReg_DebugRx4Buffers(addr) XIo_In32(XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_DEBUGRX4BUFFERS)



/* xparameters.h #defines
#define XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_TXDELAY
#define XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_CAPTOFFSET
#define XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_RADIO2RXBUFF_RXEN
#define XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_RADIO2TXBUFF_TXEN
#define XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_RADIO3RXBUFF_RXEN
#define XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_RADIO3TXBUFF_TXEN
#define XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_STARTCAPTURE
#define XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_STARTTX
#define XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_STOPTX
#define XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_TRANSMODE
#define XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_TXLENGTH

#define XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_RSSIBUFF_RADIO2
#define XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_RSSIBUFF_RADIO3

#define XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_RXBUFF_RADIO2
#define XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_RXBUFF_RADIO3
#define XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_TXBUFF_RADIO2
#define XPAR_WARPLAB_MIMO_4X4_PLBW_0_MEMMAP_TXBUFF_RADIO3
*/
