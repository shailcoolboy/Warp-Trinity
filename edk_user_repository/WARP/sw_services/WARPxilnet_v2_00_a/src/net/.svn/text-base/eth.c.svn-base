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
// File   : eth.c
// Date   : 2002, March 20.
// Author : Sathya Thammanur
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// Summary:
// Ethernet layer specific functions
//
// $Id: eth.c,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
////////////////////////////////////////////////////////////////////////////////

#include <string.h>
#include <net/xilnet_config.h>
#include <net/xilsock.h>

struct xilnet_hw_addr_table xilnet_hw_tbl[HW_ADDR_TBL_ENTRIES];
unsigned char ishwaddrinit = 0;
static unsigned long long curr_age = 0;


/* 
 * initialize xilnet hardware address
 */
void xilnet_eth_init_hw_addr(unsigned char* addr) {
   int k = 0;
   int j;
   int sum = 0;
   int val = 0;
   
   for (j = 0; j < 5; j++) {
   
      // parse input for colon separated hw address 
      while(addr[k] != ':') {
         if (addr[k] >= 'a' && addr[k] <= 'f') 
            val = addr[k] - 'a' + 10;
         else if (addr[k] >= 'A' && addr[k] <= 'F')
            val = addr[k] - 'A' + 10;
         else
            val = addr[k] - '0';
         sum = sum * 16 + val;
         k++;
      }
    
      k++; // move over the colon
      mb_hw_addr[j] = (unsigned char) sum;
      sum = 0;    
   }
   
   // read last byte of hw address
   while (addr[k] != '\0') {
      if (addr[k] >= 'a' && addr[k] <= 'f') 
         val = addr[k] - 'a' + 10;
      else if (addr[k] >= 'A' && addr[k] <= 'F')
         val = addr[k] - 'A' + 10;
      else
         val = addr[k] - '0';
      sum = sum * 16 + val;
      k++;
   }  
   mb_hw_addr[5] = (unsigned char) sum;
}


/*
 * Receive frame 
 */
int xilnet_eth_recv_frame(unsigned char *buf, int len) {

   struct xilnet_eth_hdr *eth;
   int size = 0;
   
   //device specific routine for getting a frame
#ifdef _CONFIG_EMAC_
   size = XEmac_RecvFrame(MYMAC_BASEADDR, buf);
#else 
#ifdef _CONFIG_EMACLITE_
   size = XEmacLite_RecvFrame(MYMAC_BASEADDR, buf);
#endif
#endif
   
#ifdef _DEBUG_
	xil_printf("Ethernet Recvd Frame of size %d...\r\n", size);
	xil_printf("src : %d%d%d%d%d%d...\r\n", buf[0], buf[1],buf[2],buf[3],buf[4],buf[5]);
	xil_printf("dst : %d%d%d%d%d%d...\r\n", buf[6], buf[7],buf[8],buf[9],buf[10],buf[11]);
	xil_printf("type : %d%d...\r\n", buf[12], buf[13]);
#endif

  
  // Strip off the FCS(or CRC) from the received frame
  buf[size-1] = 0;
  buf[size-2] = 0;
  buf[size-3] = 0;
  buf[size-4] = 0;
  size -= 4;
  
  eth = (struct xilnet_eth_hdr*) buf;  
    
  switch (eth->type) {
  case ETH_PROTO_IP:
     return (xilnet_ip(buf, size));
  case ETH_PROTO_ARP:
     return (xilnet_arp(buf, size));
  default:
#ifdef _DEBUG_
     xil_printf("Unknown protocol %x...\r\n", eth->type);
#endif
     break;
  }
  return -1;
}


/*
 * Send frame to peer ip addr, peer hw addr
 */
  

int xilnet_eth_send_frame(unsigned char *pkt, int len, unsigned char *dip_addr,
                          void *dhw_addr, unsigned short type)
{
   int i;
   int hw_tbl_index = 0;
   
   for (i = 0; i < ETH_ADDR_LEN; i++) {
      ((struct xilnet_eth_hdr*)pkt)->src_addr[i] = mb_hw_addr[i];
   }	       
   
   if (dhw_addr) 
      memcpy(((struct xilnet_eth_hdr*)pkt)->dest_addr, dhw_addr, ETH_ADDR_LEN);
   else {
      // find the hw tbl entry index corr to dip_addr
      hw_tbl_index = xilnet_eth_get_hw_addr(dip_addr);
      
      for (i = 0; i < ETH_ADDR_LEN; i++) {
         ((struct xilnet_eth_hdr*)pkt)->dest_addr[i] = xilnet_hw_tbl[hw_tbl_index].hw_addr[i];
      }
   }
   ((struct xilnet_eth_hdr*)pkt)->type = type;
   
   // pad the ethernet frame if < 60 bytes
   if (len < 60) { 
      for(i = len; i < ETH_MIN_FRAME_LEN; i++) {
         pkt[i] = 0;
      }
      len = ETH_MIN_FRAME_LEN;
   }
    // Write to MAC
#ifdef _CONFIG_EMAC_
   XEmac_SendFrame(MYMAC_BASEADDR, pkt, len);
#else 
#ifdef _CONFIG_EMACLITE_
   XEmacLite_SendFrame(MYMAC_BASEADDR, pkt, len);
#endif
#endif
   
   return len;
}


/*
 * Update Hardware Address Table
 */

void xilnet_eth_update_hw_tbl(unsigned char *buf, int proto) {
   
   unsigned char ip[IP_VERSION];
   unsigned char hw[ETH_ADDR_LEN];
   int i, j;
   struct xilnet_eth_hdr *eth = (struct xilnet_eth_hdr*) buf;

   // Update the current age
   curr_age++;
   
   // get hw addr
   for (i = 0; i < ETH_ADDR_LEN; i++) {
      hw[i] = ((struct xilnet_eth_hdr*)buf)->src_addr[i];
   }	 

   // get ip addr
   switch (proto) {
   case ETH_PROTO_ARP:
      for (i = 0; i < IP_VERSION; i++) {
         ip[i] = (buf+ETH_HDR_LEN)[ARP_SIP_OFFSET+i];
      }
      break;
   case ETH_PROTO_IP:
      for (i = 0; i < IP_VERSION; i++) {
         ip[i] = (buf+ETH_HDR_LEN)[IP_SADDR_BASE+i];
      }
      break;
   }

   // update the hw addr table
   
   for (i = 0; i < HW_ADDR_TBL_ENTRIES; i++) {
      if (xilnet_hw_tbl[i].flag) {
         if ( (hw[0] == xilnet_hw_tbl[i].hw_addr[0]) &&
              (hw[1] == xilnet_hw_tbl[i].hw_addr[1]) &&
              (hw[2] == xilnet_hw_tbl[i].hw_addr[2]) &&
              (hw[3] == xilnet_hw_tbl[i].hw_addr[3]) &&
              (hw[4] == xilnet_hw_tbl[i].hw_addr[4]) &&
              (hw[5] == xilnet_hw_tbl[i].hw_addr[5])
              ) {
            for (j = 0; j < IP_VERSION; j++)
               xilnet_hw_tbl[i].ip_addr[j] = ip[j];;
            xilnet_hw_tbl[i].flag = HW_ADDR_ENTRY_IS_TRUE;
            xilnet_hw_tbl[i].age = curr_age;
            return;
         }
      }
   }
   xilnet_add_hw_tbl_entry(ip, hw);
}


/*
 * Add an entry into Hw Addr table
 */

void xilnet_add_hw_tbl_entry(unsigned char *ip, unsigned char *hw)
{
   int i, j;
   
   for (i = 0; i < HW_ADDR_TBL_ENTRIES; i++) {
      if (!xilnet_hw_tbl[i].flag) {
         for (j = 0; j < ETH_ADDR_LEN; j++) {
            xilnet_hw_tbl[i].hw_addr[j] = hw[j];
         }
         for (j = 0; j < IP_VERSION; j++)  {
            xilnet_hw_tbl[i].ip_addr[j] = ip[j];
         }
         xilnet_hw_tbl[i].flag = HW_ADDR_ENTRY_IS_TRUE;
         xilnet_hw_tbl[i].age = curr_age;
         return;
      }
   }
   
   // Find an old entry to be eliminated from hw tbl
   i = xilnet_eth_find_old_entry();
   for (j = 0; j < ETH_ADDR_LEN; j++) {
      xilnet_hw_tbl[i].hw_addr[j] = hw[j];
   }
   for (j = 0; j < IP_VERSION; j++)  {
      xilnet_hw_tbl[i].ip_addr[j] = ip[j];
   }
   xilnet_hw_tbl[i].flag = HW_ADDR_ENTRY_IS_TRUE;
   xilnet_hw_tbl[i].age = curr_age;
   
}


/*
 * Get index into hw tbl for ip_addr
 */

int xilnet_eth_get_hw_addr(unsigned char *ip) {
   
   int i;
   
   for (i = 0; i < HW_ADDR_TBL_ENTRIES; i++) {
      if (xilnet_hw_tbl[i].flag) 
         if ( (ip[0] == xilnet_hw_tbl[i].ip_addr[0]) &&
              (ip[1] == xilnet_hw_tbl[i].ip_addr[1]) &&
              (ip[2] == xilnet_hw_tbl[i].ip_addr[2]) &&
              (ip[3] == xilnet_hw_tbl[i].ip_addr[3]) ) {
            return i;
         }
   }
   
   print("Hw Addr Not found for IP \r\n");
   return -1;
   
}


/*	
 * Init the hw addr table
 */

void xilnet_eth_init_hw_addr_tbl() {
   
  int i;
  
  for (i = 0; i < HW_ADDR_TBL_ENTRIES; i++) {
     xilnet_hw_tbl[i].flag = HW_ADDR_ENTRY_IS_FALSE;
     xilnet_hw_tbl[i].age = 0;
  }
  
  ishwaddrinit = 1;
}

/*
 * Find the oldest entry in the Hw Table and
 * return its index
 */

int xilnet_eth_find_old_entry()
{
   int i;
   int oldest_age = 0;
   int oldest = 0;
   
   for (i = 0; i < HW_ADDR_TBL_ENTRIES; i++) {
      
      if (curr_age - xilnet_hw_tbl[i].age > HW_ADDR_TBL_MAXAGE) {
         oldest = i;
         break;
      }
      else {
         if (( curr_age - xilnet_hw_tbl[i].age) > oldest_age) {
            oldest_age = curr_age - xilnet_hw_tbl[i].age;
            oldest = i;
         }
      }
   }
   
   return oldest;
   
}
