///////////////////////////////////////////////////////////////-*-C-*-
//
// Copyright (c) 2007 Xilinx, Inc.  All rights reserved.
//
// Xilinx, Inc.  XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION
// "AS IS" AS  A COURTESY TO YOU.  BY PROVIDING  THIS DESIGN, CODE, OR
// INFORMATION  AS  ONE   POSSIBLE  IMPLEMENTATION  OF  THIS  FEATURE,
// APPLICATION OR  STANDARD, XILINX  IS MAKING NO  REPRESENTATION THAT
// THIS IMPLEMENTATION  IS FREE FROM  ANY CLAIMS OF  INFRINGEMENT, AND
// YOU ARE  RESPONSIBLE FOR OBTAINING  ANY RIGHTS YOU MAY  REQUIRE FOR
// YOUR  IMPLEMENTATION.   XILINX  EXPRESSLY  DISCLAIMS  ANY  WARRANTY
// WHATSOEVER  WITH RESPECT  TO  THE ADEQUACY  OF THE  IMPLEMENTATION,
// INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR REPRESENTATIONS THAT
// THIS IMPLEMENTATION  IS FREE  FROM CLAIMS OF  INFRINGEMENT, IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
// 
//////////////////////////////////////////////////////////////////////

#include "user_io_board_controller_plbw.h"
#include "xparameters.h"
#include "xcope.h"

inline xc_status_t xc_user_io_board_controller_plbw_create(xc_iface_t **iface, void *config_table)
{
    // set up iface
    *iface = (xc_iface_t *) config_table;

#ifdef XC_DEBUG
    USER_IO_BOARD_CONTROLLER_PLBW_Config *_config_table = config_table;

    if (_config_table->xc_create == NULL) {
        print("config_table.xc_create == NULL\r\n");
        exit(1);
    }
#endif

    // does nothing
    return XC_SUCCESS;
}

inline xc_status_t xc_user_io_board_controller_plbw_release(xc_iface_t **iface) 
{
    // does nothing
    return XC_SUCCESS;
}

inline xc_status_t xc_user_io_board_controller_plbw_open(xc_iface_t *iface)
{
    // does nothing
    return XC_SUCCESS;
}

inline xc_status_t xc_user_io_board_controller_plbw_close(xc_iface_t *iface)
{
    // does nothing
    return XC_SUCCESS;
}

inline xc_status_t xc_user_io_board_controller_plbw_read(xc_iface_t *iface, xc_r_addr_t addr, uint32_t *value)
{
    *value = *((uint32_t *) addr);
    return XC_SUCCESS;
}

inline xc_status_t xc_user_io_board_controller_plbw_write(xc_iface_t *iface, xc_w_addr_t addr, const uint32_t value)
{
    *((uint32_t *) addr) = value;
    return XC_SUCCESS;
}

xc_status_t xc_user_io_board_controller_plbw_getshmem(xc_iface_t *iface, const char *name, void **shmem)
{
    USER_IO_BOARD_CONTROLLER_PLBW_Config *_config_table = (USER_IO_BOARD_CONTROLLER_PLBW_Config *) iface;

    if (strcmp("Buttons_Big", name) == 0) {
        *shmem = (void *) & _config_table->Buttons_Big;
    }
    else if (strcmp("Buttons_Small", name) == 0) {
        *shmem = (void *) & _config_table->Buttons_Small;
    }
    else if (strcmp("DIP_Switch", name) == 0) {
        *shmem = (void *) & _config_table->DIP_Switch;
    }
    else if (strcmp("Trackball", name) == 0) {
        *shmem = (void *) & _config_table->Trackball;
    }
    else if (strcmp("Buzzer_DutyCycle", name) == 0) {
        *shmem = (void *) & _config_table->Buzzer_DutyCycle;
    }
    else if (strcmp("Buzzer_Enable", name) == 0) {
        *shmem = (void *) & _config_table->Buzzer_Enable;
    }
    else if (strcmp("Buzzer_Period", name) == 0) {
        *shmem = (void *) & _config_table->Buzzer_Period;
    }
    else if (strcmp("LCD_BackgroundColor", name) == 0) {
        *shmem = (void *) & _config_table->LCD_BackgroundColor;
    }
    else if (strcmp("LCD_CharacterOffset", name) == 0) {
        *shmem = (void *) & _config_table->LCD_CharacterOffset;
    }
    else if (strcmp("LCD_CharactersSelect", name) == 0) {
        *shmem = (void *) & _config_table->LCD_CharactersSelect;
    }
    else if (strcmp("LCD_ColSet", name) == 0) {
        *shmem = (void *) & _config_table->LCD_ColSet;
    }
    else if (strcmp("LCD_ConfigLocation", name) == 0) {
        *shmem = (void *) & _config_table->LCD_ConfigLocation;
    }
    else if (strcmp("LCD_DividerSelect", name) == 0) {
        *shmem = (void *) & _config_table->LCD_DividerSelect;
    }
    else if (strcmp("LCD_FirstEnd", name) == 0) {
        *shmem = (void *) & _config_table->LCD_FirstEnd;
    }
    else if (strcmp("LCD_FirstStart", name) == 0) {
        *shmem = (void *) & _config_table->LCD_FirstStart;
    }
    else if (strcmp("LCD_LineOffset", name) == 0) {
        *shmem = (void *) & _config_table->LCD_LineOffset;
    }
    else if (strcmp("LCD_RamWrite", name) == 0) {
        *shmem = (void *) & _config_table->LCD_RamWrite;
    }
    else if (strcmp("LCD_Reset", name) == 0) {
        *shmem = (void *) & _config_table->LCD_Reset;
    }
    else if (strcmp("LCD_ResetLCD", name) == 0) {
        *shmem = (void *) & _config_table->LCD_ResetLCD;
    }
    else if (strcmp("LCD_RowSet", name) == 0) {
        *shmem = (void *) & _config_table->LCD_RowSet;
    }
    else if (strcmp("LCD_SecondEnd", name) == 0) {
        *shmem = (void *) & _config_table->LCD_SecondEnd;
    }
    else if (strcmp("LCD_SecondStart", name) == 0) {
        *shmem = (void *) & _config_table->LCD_SecondStart;
    }
    else if (strcmp("LCD_Send", name) == 0) {
        *shmem = (void *) & _config_table->LCD_Send;
    }
    else if (strcmp("LCD_TotalCmdTransfer", name) == 0) {
        *shmem = (void *) & _config_table->LCD_TotalCmdTransfer;
    }
    else if (strcmp("LEDs", name) == 0) {
        *shmem = (void *) & _config_table->LEDs;
    }
    else if (strcmp("LCD_CharacterMap", name) == 0) {
        *shmem = (void *) & _config_table->LCD_CharacterMap;
    }
    else if (strcmp("LCD_Characters", name) == 0) {
        *shmem = (void *) & _config_table->LCD_Characters;
    }
    else if (strcmp("LCD_Commands", name) == 0) {
        *shmem = (void *) & _config_table->LCD_Commands;
    } else { shmem = NULL; return XC_FAILURE; } 

    return XC_SUCCESS;
}
