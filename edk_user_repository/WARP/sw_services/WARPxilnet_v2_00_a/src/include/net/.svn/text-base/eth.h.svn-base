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
// File   : eth.h
// Date   : 2002, March 20.
// Author : Sathya Thammanur
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// Summary:
// Header file for Ethernet layer
//
// $Id: eth.h,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
////////////////////////////////////////////////////////////////////////////////

#ifndef _ETH_H
#define _ETH_H

#ifdef __cplusplus
extern "C" {
#endif

#include <net/xilnet_config.h>
#include <net/ip.h>

#define ETH_ADDR_LEN	       6   /* len of eth addr */	
#define ETH_HDR_LEN	        14   /* eth hdr len */	
#define ETH_MIN_FRAME_LEN	  60   /* Min Eth Frame Payload */	

#define ETH_MAX_FRAME_LEN	  1500 /* Max Eth Frame Payload */	
#define ETH_FRAME_LEN	      1514 /* Max Eth Frame Size */	


/* MAC address used */
extern unsigned int MYMAC_BASEADDR;

/*
 * Protocol vals in eth hdr 
 */

#define ETH_PROTO_IP	0x0800		/* IP  packet	*/
#define ETH_PROTO_ARP	0x0806		/* ARP packet	*/



/*
 * Ethernet Header
 */
 
struct xilnet_eth_hdr {
  unsigned char	dest_addr[ETH_ADDR_LEN];  /* destination eth addr	*/
  unsigned char	src_addr[ETH_ADDR_LEN];	  /* source eth addr	*/
  unsigned short type;		          /* protocol type */
};


/*
 * HW Addr Table
 *
 */

#define HW_ADDR_TBL_ENTRIES     5
#define HW_ADDR_ENTRY_IS_TRUE   1
#define HW_ADDR_ENTRY_IS_FALSE  0
#define HW_ADDR_TBL_MAXAGE      2

struct xilnet_hw_addr_table 
{
   unsigned char ip_addr[IP_VERSION];
   unsigned char hw_addr[ETH_ADDR_LEN];
   unsigned char flag;
   unsigned int age;
};

extern struct xilnet_hw_addr_table xilnet_hw_tbl[HW_ADDR_TBL_ENTRIES];

#ifdef __cplusplus
}
#endif

#endif	/* _ETH_H */
