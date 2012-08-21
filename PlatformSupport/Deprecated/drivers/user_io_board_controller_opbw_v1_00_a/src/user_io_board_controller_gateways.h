#include "xbasic_types.h"
#include "xstatus.h"
#include "xio.h"


#define USER_IO_BOARD_CONTROLLER_OFFSET (0x00000000)
//Gateways In

#define user_io_board_controller_LCD_FirstStart_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x0)
//tag name: in_0
//arith_type = Unsigned
//num_bits = 9
//bin_pt = 0
#define user_io_board_controller_LCD_FirstEnd_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x4)
//tag name: in_1
//arith_type = Unsigned
//num_bits = 9
//bin_pt = 0
#define user_io_board_controller_LCD_BackgroundColor_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x8)
//tag name: in_2
//arith_type = Unsigned
//num_bits = 9
//bin_pt = 0
#define user_io_board_controller_LCD_SecondStart_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0xC)
//tag name: in_3
//arith_type = Unsigned
//num_bits = 9
//bin_pt = 0
#define user_io_board_controller_LCD_SecondEnd_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x10)
//tag name: in_4
//arith_type = Unsigned
//num_bits = 9
//bin_pt = 0
#define user_io_board_controller_LCD_ColSet_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x14)
//tag name: in_5
//arith_type = Unsigned
//num_bits = 9
//bin_pt = 0
#define user_io_board_controller_LCD_RamWrite_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x18)
//tag name: in_6
//arith_type = Unsigned
//num_bits = 9
//bin_pt = 0
#define user_io_board_controller_LCD_RowSet_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x1C)
//tag name: in_7
//arith_type = Unsigned
//num_bits = 9
//bin_pt = 0
#define user_io_board_controller_LCD_CharactersSelect_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x20)
//tag name: in_8
//arith_type = Unsigned
//num_bits = 3
//bin_pt = 0
#define user_io_board_controller_LCD_Reset_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x24)
//tag name: in_9
//arith_type = Unsigned
//num_bits = 1
//bin_pt = 0
#define user_io_board_controller_LCD_ConfigLocation_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x28)
//tag name: in_10
//arith_type = Unsigned
//num_bits = 2
//bin_pt = 0
#define user_io_board_controller_LCD_InvertRAMAddrCmd_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x2C)
//tag name: in_11
//arith_type = Unsigned
//num_bits = 1
//bin_pt = 0
#define user_io_board_controller_LCD_TotalCmdTransfer_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x30)
//tag name: in_12
//arith_type = Unsigned
//num_bits = 8
//bin_pt = 0
#define user_io_board_controller_LCD_DividerSelect_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x34)
//tag name: in_13
//arith_type = Unsigned
//num_bits = 1
//bin_pt = 0
#define user_io_board_controller_LCD_Send_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x38)
//tag name: in_14
//arith_type = Unsigned
//num_bits = 1
//bin_pt = 0
#define user_io_board_controller_LCD_ResetLCD_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x3C)
//tag name: in_15
//arith_type = Unsigned
//num_bits = 1
//bin_pt = 0
#define user_io_board_controller_LCD_InvertRAMAddrData_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x40)
//tag name: in_16
//arith_type = Unsigned
//num_bits = 1
//bin_pt = 0

//Gateways Out

#define user_io_board_controller_LCD_Bar_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x44)
//tag name: out_17

//Shared Memory Address

#define user_io_board_controller_SMWO_LCD_Commands_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x10000)
#define user_io_board_controller_SMWO_LCD_CharacterMap_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x20000)
#define user_io_board_controller_SMWO_LCD_Characters_OFFSET (USER_IO_BOARD_CONTROLLER_OFFSET+0x30000)


#define user_io_board_controller_WriteReg(BaseAddress, RegOffset, Data) \
	XIo_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

#define user_io_board_controller_ReadReg(BaseAddress, RegOffset) \
	XIo_In32((BaseAddress) + (RegOffset))

//Write Reg Macro

#define user_io_board_controller_WriteReg_LCD_FirstStart(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_LCD_FirstStart_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_LCD_FirstEnd(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_LCD_FirstEnd_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_LCD_BackgroundColor(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_LCD_BackgroundColor_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_LCD_SecondStart(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_LCD_SecondStart_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_LCD_SecondEnd(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_LCD_SecondEnd_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_LCD_ColSet(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_LCD_ColSet_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_LCD_RamWrite(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_LCD_RamWrite_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_LCD_RowSet(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_LCD_RowSet_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_LCD_CharactersSelect(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_LCD_CharactersSelect_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_LCD_Reset(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_LCD_Reset_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_LCD_ConfigLocation(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_LCD_ConfigLocation_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_LCD_InvertRAMAddrCmd(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_LCD_InvertRAMAddrCmd_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_LCD_TotalCmdTransfer(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_LCD_TotalCmdTransfer_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_LCD_DividerSelect(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_LCD_DividerSelect_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_LCD_Send(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_LCD_Send_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_LCD_ResetLCD(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_LCD_ResetLCD_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_LCD_InvertRAMAddrData(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_LCD_InvertRAMAddrData_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_LCD_Bar(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_LCD_Bar_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_SMWO_LCD_Commands(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_SMWO_LCD_Commands_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_SMWO_LCD_CharacterMap(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_SMWO_LCD_CharacterMap_OFFSET), (Xuint32)(Value))
#define user_io_board_controller_WriteReg_SMWO_LCD_Characters(BaseAddress, Value) \
	XIo_Out32((BaseAddress) + (user_io_board_controller_SMWO_LCD_Characters_OFFSET), (Xuint32)(Value))


//Read Reg Macro

#define user_io_board_controller_ReadReg_LCD_FirstStart(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_LCD_FirstStart_OFFSET))
#define user_io_board_controller_ReadReg_LCD_FirstEnd(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_LCD_FirstEnd_OFFSET))
#define user_io_board_controller_ReadReg_LCD_BackgroundColor(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_LCD_BackgroundColor_OFFSET))
#define user_io_board_controller_ReadReg_LCD_SecondStart(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_LCD_SecondStart_OFFSET))
#define user_io_board_controller_ReadReg_LCD_SecondEnd(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_LCD_SecondEnd_OFFSET))
#define user_io_board_controller_ReadReg_LCD_ColSet(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_LCD_ColSet_OFFSET))
#define user_io_board_controller_ReadReg_LCD_RamWrite(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_LCD_RamWrite_OFFSET))
#define user_io_board_controller_ReadReg_LCD_RowSet(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_LCD_RowSet_OFFSET))
#define user_io_board_controller_ReadReg_LCD_CharactersSelect(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_LCD_CharactersSelect_OFFSET))
#define user_io_board_controller_ReadReg_LCD_Reset(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_LCD_Reset_OFFSET))
#define user_io_board_controller_ReadReg_LCD_ConfigLocation(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_LCD_ConfigLocation_OFFSET))
#define user_io_board_controller_ReadReg_LCD_InvertRAMAddrCmd(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_LCD_InvertRAMAddrCmd_OFFSET))
#define user_io_board_controller_ReadReg_LCD_TotalCmdTransfer(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_LCD_TotalCmdTransfer_OFFSET))
#define user_io_board_controller_ReadReg_LCD_DividerSelect(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_LCD_DividerSelect_OFFSET))
#define user_io_board_controller_ReadReg_LCD_Send(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_LCD_Send_OFFSET))
#define user_io_board_controller_ReadReg_LCD_ResetLCD(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_LCD_ResetLCD_OFFSET))
#define user_io_board_controller_ReadReg_LCD_InvertRAMAddrData(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_LCD_InvertRAMAddrData_OFFSET))
#define user_io_board_controller_ReadReg_LCD_Bar(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_LCD_Bar_OFFSET))
#define user_io_board_controller_ReadReg_SMWO_LCD_Commands(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_SMWO_LCD_Commands_OFFSET))
#define user_io_board_controller_ReadReg_SMWO_LCD_CharacterMap(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_SMWO_LCD_CharacterMap_OFFSET))
#define user_io_board_controller_ReadReg_SMWO_LCD_Characters(BaseAddress) \
	XIo_In32((BaseAddress) + (user_io_board_controller_SMWO_LCD_Characters_OFFSET))
