////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2004 Xilinx, Inc.  All rights reserved. 
// 
// Xilinx, Inc. 
// XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A 
// COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS 
// ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR 
// STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION 
// IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE 
// FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION. 
// XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO 
// THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO 
// ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE 
// FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY 
// AND FITNESS FOR A PARTICULAR PURPOSE. 
// 
// Date   : 2002, November.
// Author : Sathya Thammanur (sathya@xilinx.com)
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// $Id: xilnet_config.h,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
//////////////////////////////////////////////////////////////////////////////

#ifndef _XILNET_CONFIG_H
#define _XILNET_CONFIG_H

#ifdef __cplusplus
extern "C" {
#endif

#define _CONFIG_EMAC_   1  // Use Emac Device
#define MAX_TCP_CONNS   5  // maximum no of open tcp conns
#define MAX_UDP_CONNS   5  // maximum no of open udp conns

#ifdef __cplusplus
}
#endif

#endif
