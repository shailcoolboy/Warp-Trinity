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

#ifndef __XL_WARP_TIMER_PLBW_H__
#define __XL_WARP_TIMER_PLBW_H__

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
    uint32_t timer0_timeLeft;
    uint32_t timer0_timeLeft_n_bits;
    uint32_t timer0_timeLeft_bin_pt;
    // uint32_t timer0_timeLeft_attr;
    uint32_t timer1_timeLeft;
    uint32_t timer1_timeLeft_n_bits;
    uint32_t timer1_timeLeft_bin_pt;
    // uint32_t timer1_timeLeft_attr;
    uint32_t timer2_timeLeft;
    uint32_t timer2_timeLeft_n_bits;
    uint32_t timer2_timeLeft_bin_pt;
    // uint32_t timer2_timeLeft_attr;
    uint32_t timer3_timeLeft;
    uint32_t timer3_timeLeft_n_bits;
    uint32_t timer3_timeLeft_bin_pt;
    // uint32_t timer3_timeLeft_attr;
    uint32_t timer_control_r;
    uint32_t timer_control_r_n_bits;
    uint32_t timer_control_r_bin_pt;
    // uint32_t timer_control_r_attr;
    uint32_t timer_status;
    uint32_t timer_status_n_bits;
    uint32_t timer_status_bin_pt;
    // uint32_t timer_status_attr;
    uint32_t timer0_countTo;
    uint32_t timer0_countTo_n_bits;
    uint32_t timer0_countTo_bin_pt;
    // uint32_t timer0_countTo_attr;
    uint32_t timer1_countTo;
    uint32_t timer1_countTo_n_bits;
    uint32_t timer1_countTo_bin_pt;
    // uint32_t timer1_countTo_attr;
    uint32_t timer2_countTo;
    uint32_t timer2_countTo_n_bits;
    uint32_t timer2_countTo_bin_pt;
    // uint32_t timer2_countTo_attr;
    uint32_t timer3_countTo;
    uint32_t timer3_countTo_n_bits;
    uint32_t timer3_countTo_bin_pt;
    // uint32_t timer3_countTo_attr;
    uint32_t timer_control_w;
    uint32_t timer_control_w_n_bits;
    uint32_t timer_control_w_bin_pt;
    // uint32_t timer_control_w_attr;
    // XPS parameters
    Xuint16  DeviceId;
    uint32_t  BaseAddr;
} WARP_TIMER_PLBW_Config;

extern WARP_TIMER_PLBW_Config WARP_TIMER_PLBW_ConfigTable[];

// forward declaration of low-level functions
xc_status_t xc_warp_timer_plbw_create(xc_iface_t **iface, void *config_table);
xc_status_t xc_warp_timer_plbw_release(xc_iface_t **iface) ;
xc_status_t xc_warp_timer_plbw_open(xc_iface_t *iface);
xc_status_t xc_warp_timer_plbw_close(xc_iface_t *iface);
xc_status_t xc_warp_timer_plbw_read(xc_iface_t *iface, xc_r_addr_t addr, uint32_t *value);
xc_status_t xc_warp_timer_plbw_write(xc_iface_t *iface, xc_w_addr_t addr, const uint32_t value);
xc_status_t xc_warp_timer_plbw_getshmem(xc_iface_t *iface, const char *name, void **shmem);

#endif

