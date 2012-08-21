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

#ifndef __XL_USER_IO_BOARD_CONTROLLER_PLBW_H__
#define __XL_USER_IO_BOARD_CONTROLLER_PLBW_H__

#include "xbasic_types.h"
#include "xstatus.h"
#include "xcope.h"

typedef struct {
    uint32_t version;
    // Pointers to low-level functions
    xc_status_t (*xc_create)(xc_iface_t **, void *);
    xc_status_t (*xc_release)(xc_iface_t **);
    xc_status_t (*xc_open)(xc_iface_t *);
    xc_status_t (*xc_close)(xc_iface_t *);
    xc_status_t (*xc_read)(xc_iface_t *, xc_r_addr_t, uint32_t *);
    xc_status_t (*xc_write)(xc_iface_t *, xc_w_addr_t, const uint32_t);
    xc_status_t (*xc_get_shmem)(xc_iface_t *, const char *, void **shmem);
    // Optional parameters
    // (empty)
    // Memory map information
    uint32_t Buttons_Big;
    uint32_t Buttons_Big_n_bits;
    uint32_t Buttons_Big_bin_pt;
    // uint32_t Buttons_Big_attr;
    uint32_t Buttons_Small;
    uint32_t Buttons_Small_n_bits;
    uint32_t Buttons_Small_bin_pt;
    // uint32_t Buttons_Small_attr;
    uint32_t DIP_Switch;
    uint32_t DIP_Switch_n_bits;
    uint32_t DIP_Switch_bin_pt;
    // uint32_t DIP_Switch_attr;
    uint32_t Trackball;
    uint32_t Trackball_n_bits;
    uint32_t Trackball_bin_pt;
    // uint32_t Trackball_attr;
    uint32_t Buzzer_DutyCycle;
    uint32_t Buzzer_DutyCycle_n_bits;
    uint32_t Buzzer_DutyCycle_bin_pt;
    // uint32_t Buzzer_DutyCycle_attr;
    uint32_t Buzzer_Enable;
    uint32_t Buzzer_Enable_n_bits;
    uint32_t Buzzer_Enable_bin_pt;
    // uint32_t Buzzer_Enable_attr;
    uint32_t Buzzer_Period;
    uint32_t Buzzer_Period_n_bits;
    uint32_t Buzzer_Period_bin_pt;
    // uint32_t Buzzer_Period_attr;
    uint32_t LCD_BackgroundColor;
    uint32_t LCD_BackgroundColor_n_bits;
    uint32_t LCD_BackgroundColor_bin_pt;
    // uint32_t LCD_BackgroundColor_attr;
    uint32_t LCD_CharacterOffset;
    uint32_t LCD_CharacterOffset_n_bits;
    uint32_t LCD_CharacterOffset_bin_pt;
    // uint32_t LCD_CharacterOffset_attr;
    uint32_t LCD_CharactersSelect;
    uint32_t LCD_CharactersSelect_n_bits;
    uint32_t LCD_CharactersSelect_bin_pt;
    // uint32_t LCD_CharactersSelect_attr;
    uint32_t LCD_ColSet;
    uint32_t LCD_ColSet_n_bits;
    uint32_t LCD_ColSet_bin_pt;
    // uint32_t LCD_ColSet_attr;
    uint32_t LCD_ConfigLocation;
    uint32_t LCD_ConfigLocation_n_bits;
    uint32_t LCD_ConfigLocation_bin_pt;
    // uint32_t LCD_ConfigLocation_attr;
    uint32_t LCD_DividerSelect;
    uint32_t LCD_DividerSelect_n_bits;
    uint32_t LCD_DividerSelect_bin_pt;
    // uint32_t LCD_DividerSelect_attr;
    uint32_t LCD_FirstEnd;
    uint32_t LCD_FirstEnd_n_bits;
    uint32_t LCD_FirstEnd_bin_pt;
    // uint32_t LCD_FirstEnd_attr;
    uint32_t LCD_FirstStart;
    uint32_t LCD_FirstStart_n_bits;
    uint32_t LCD_FirstStart_bin_pt;
    // uint32_t LCD_FirstStart_attr;
    uint32_t LCD_LineOffset;
    uint32_t LCD_LineOffset_n_bits;
    uint32_t LCD_LineOffset_bin_pt;
    // uint32_t LCD_LineOffset_attr;
    uint32_t LCD_RamWrite;
    uint32_t LCD_RamWrite_n_bits;
    uint32_t LCD_RamWrite_bin_pt;
    // uint32_t LCD_RamWrite_attr;
    uint32_t LCD_Reset;
    uint32_t LCD_Reset_n_bits;
    uint32_t LCD_Reset_bin_pt;
    // uint32_t LCD_Reset_attr;
    uint32_t LCD_ResetLCD;
    uint32_t LCD_ResetLCD_n_bits;
    uint32_t LCD_ResetLCD_bin_pt;
    // uint32_t LCD_ResetLCD_attr;
    uint32_t LCD_RowSet;
    uint32_t LCD_RowSet_n_bits;
    uint32_t LCD_RowSet_bin_pt;
    // uint32_t LCD_RowSet_attr;
    uint32_t LCD_SecondEnd;
    uint32_t LCD_SecondEnd_n_bits;
    uint32_t LCD_SecondEnd_bin_pt;
    // uint32_t LCD_SecondEnd_attr;
    uint32_t LCD_SecondStart;
    uint32_t LCD_SecondStart_n_bits;
    uint32_t LCD_SecondStart_bin_pt;
    // uint32_t LCD_SecondStart_attr;
    uint32_t LCD_Send;
    uint32_t LCD_Send_n_bits;
    uint32_t LCD_Send_bin_pt;
    // uint32_t LCD_Send_attr;
    uint32_t LCD_TotalCmdTransfer;
    uint32_t LCD_TotalCmdTransfer_n_bits;
    uint32_t LCD_TotalCmdTransfer_bin_pt;
    // uint32_t LCD_TotalCmdTransfer_attr;
    uint32_t LEDs;
    uint32_t LEDs_n_bits;
    uint32_t LEDs_bin_pt;
    // uint32_t LEDs_attr;
    uint32_t LCD_CharacterMap;
    // uint32_t LCD_CharacterMap_grant;
    // uint32_t LCD_CharacterMap_req;
    uint32_t LCD_CharacterMap_n_bits;
    uint32_t LCD_CharacterMap_bin_pt;
    // uint32_t LCD_CharacterMap_attr;
    uint32_t LCD_Characters;
    // uint32_t LCD_Characters_grant;
    // uint32_t LCD_Characters_req;
    uint32_t LCD_Characters_n_bits;
    uint32_t LCD_Characters_bin_pt;
    // uint32_t LCD_Characters_attr;
    uint32_t LCD_Commands;
    // uint32_t LCD_Commands_grant;
    // uint32_t LCD_Commands_req;
    uint32_t LCD_Commands_n_bits;
    uint32_t LCD_Commands_bin_pt;
    // uint32_t LCD_Commands_attr;
    // XPS parameters
    Xuint16  DeviceId;
    uint32_t  BaseAddr;
} USER_IO_BOARD_CONTROLLER_PLBW_Config;

extern USER_IO_BOARD_CONTROLLER_PLBW_Config USER_IO_BOARD_CONTROLLER_PLBW_ConfigTable[];

// forward declaration of low-level functions
xc_status_t xc_user_io_board_controller_plbw_create(xc_iface_t **iface, void *config_table);
xc_status_t xc_user_io_board_controller_plbw_release(xc_iface_t **iface) ;
xc_status_t xc_user_io_board_controller_plbw_open(xc_iface_t *iface);
xc_status_t xc_user_io_board_controller_plbw_close(xc_iface_t *iface);
xc_status_t xc_user_io_board_controller_plbw_read(xc_iface_t *iface, xc_r_addr_t addr, uint32_t *value);
xc_status_t xc_user_io_board_controller_plbw_write(xc_iface_t *iface, xc_w_addr_t addr, const uint32_t value);
xc_status_t xc_user_io_board_controller_plbw_getshmem(xc_iface_t *iface, const char *name, void **shmem);

#endif

