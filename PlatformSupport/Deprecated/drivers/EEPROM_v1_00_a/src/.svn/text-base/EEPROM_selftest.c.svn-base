//////////////////////////////////////////////////////////////////////////////
// Filename:          C:\EDK_User_Repository\WARP\drivers\EEPROM_v1_00_a\src\EEPROM_selftest.c
// Version:           1.00.a
// Description:       Contains a diagnostic self-test function for the EEPROM driver
// Date:              Fri Jul 28 13:08:23 2006 (by Create and Import Peripheral Wizard)
//////////////////////////////////////////////////////////////////////////////


/***************************** Include Files *******************************/

#include "EEPROM_l.h"
#include "EEPROM.h"

/************************** Constant Definitions ***************************/


/************************** Variable Definitions ****************************/


/************************** Function Definitions ***************************/

/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the EEPROM instance to be worked on.
 *
 * @return
 *
 *    - XST_SUCCESS   if all self-test code passed
 *    - XST_FAILURE   if any self-test code failed
 *
 * @note    Caching must be turned off for this function to work.
 * @note    Self test may fail if data memory and device are not on the same bus.
 *
 */
XStatus EEPROM_SelfTest(void * baseaddr_p)
{
   int     Index;
   Xuint32 baseaddr;
   Xuint8  Reg8Value;
   Xuint16 Reg16Value;
   Xuint32 Reg32Value;
   Xuint64 Reg64Value;

   /*
    * Assert the argument
    */
   XASSERT_NONVOID(baseaddr_p != XNULL);
   baseaddr = (Xuint32) baseaddr_p;

   xil_printf("******************************\n\r");
   xil_printf("* User Peripheral Self Test\n\r");
   xil_printf("******************************\n\n\r");

   /*
    * Reset the device to get it back to its default state and get module identification value
    */
   xil_printf("RST/MIR test...\n\r");
   EEPROM_mReset(baseaddr);
   xil_printf("   - write 0x%08x to software reset register \n\r", IPIF_RESET);
   Reg32Value = EEPROM_mReadMIR(baseaddr);
   if ( Reg32Value == 0x30220301 )
   {
      xil_printf("   - read 0x%08x (expected) from module identification register \n\r", Reg32Value);
      xil_printf("   - RST/MIR write/read passed\n\n\r");
   }
   else
   {
      xil_printf("   - read 0x%08x (unexpected) from module identification register, expect 0x30220301 \n\r", Reg32Value);
      xil_printf("   - RST/MIR write/read failed\n\n\r");
      return XST_FAILURE;
   }

   return XST_SUCCESS;
}
