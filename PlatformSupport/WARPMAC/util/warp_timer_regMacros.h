#ifndef WARP_TIMER_MACROS_H
#define WARP_TIMER_MACROS_H

#include "xbasic_types.h"
#include "xstatus.h"
#include "xio.h"

#define TIMER_MASK_CALC(id) ((unsigned int)(0xF << (id * 4)))

#define TIMER0_MASK 0x0000000F
#define TIMER1_MASK 0x000000F0
#define TIMER2_MASK 0x00000F00
#define TIMER3_MASK 0x0000F000
#define TIMER4_MASK 0x000F0000
#define TIMER5_MASK 0x00F00000
#define TIMER6_MASK 0x0F000000
#define TIMER7_MASK 0xF0000000

#define TIMER_CONTROL_START_MASK        0x11111111
#define TIMER_CONTROL_PAUSE_MASK        0x22222222
#define TIMER_CONTROL_MODE_MASK         0x44444444
#define TIMER_CONTROL_RESETDONE_MASK    0x88888888

#define TIMER_STATUS_PASUED_MASK    0x11111111
#define TIMER_STATUS_RUNNING_MASK   0x22222222
#define TIMER_STATUS_DONE_MASK      0x44444444

//Register writing macros
#define warp_timer_WriteReg_control(d) XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER_CONTROL, (unsigned int)(d))
#define warp_timer_WriteReg_timer0_slotCount(d) XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER0_SLOTCOUNT, (unsigned int)(d))
#define warp_timer_WriteReg_timer1_slotCount(d) XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER1_SLOTCOUNT, (unsigned int)(d))
#define warp_timer_WriteReg_timer2_slotCount(d) XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER2_SLOTCOUNT, (unsigned int)(d))
#define warp_timer_WriteReg_timer3_slotCount(d) XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER3_SLOTCOUNT, (unsigned int)(d))
#define warp_timer_WriteReg_timer4_slotCount(d) XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER4_SLOTCOUNT, (unsigned int)(d))
#define warp_timer_WriteReg_timer5_slotCount(d) XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER5_SLOTCOUNT, (unsigned int)(d))
#define warp_timer_WriteReg_timer6_slotCount(d) XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER6_SLOTCOUNT, (unsigned int)(d))
#define warp_timer_WriteReg_timer7_slotCount(d) XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER7_SLOTCOUNT, (unsigned int)(d))
#define warp_timer_WriteReg_timers01_slotTime(d) XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS01_SLOTTIME, (unsigned int)(d))
#define warp_timer_WriteReg_timers23_slotTime(d) XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS23_SLOTTIME, (unsigned int)(d))
#define warp_timer_WriteReg_timers45_slotTime(d) XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS45_SLOTTIME, (unsigned int)(d))
#define warp_timer_WriteReg_timers67_slotTime(d) XIo_Out32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS67_SLOTTIME, (unsigned int)(d))

//Register reading macros
//Read-only reg
#define warp_timer_ReadReg_status() XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER_STATUS)

//Read-write regs
#define warp_timer_ReadReg_control() XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER_CONTROL)
#define warp_timer_ReadReg_timer0_slotCount() XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER0_SLOTCOUNT)
#define warp_timer_ReadReg_timer1_slotCount() XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER1_SLOTCOUNT)
#define warp_timer_ReadReg_timer2_slotCount() XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER2_SLOTCOUNT)
#define warp_timer_ReadReg_timer3_slotCount() XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER3_SLOTCOUNT)
#define warp_timer_ReadReg_timer4_slotCount() XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER4_SLOTCOUNT)
#define warp_timer_ReadReg_timer5_slotCount() XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER5_SLOTCOUNT)
#define warp_timer_ReadReg_timer6_slotCount() XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER6_SLOTCOUNT)
#define warp_timer_ReadReg_timer7_slotCount() XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMER7_SLOTCOUNT)
#define warp_timer_ReadReg_timers01_slotTime() XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS01_SLOTTIME)
#define warp_timer_ReadReg_timers23_slotTime() XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS23_SLOTTIME)
#define warp_timer_ReadReg_timers45_slotTime() XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS45_SLOTTIME)
#define warp_timer_ReadReg_timers67_slotTime() XIo_In32(XPAR_WARP_TIMER_PLBW_0_MEMMAP_TIMERS67_SLOTTIME)


#endif
