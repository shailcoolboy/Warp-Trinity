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
// File   : udp.c
// Date   : 2002, March 20.
// Author : Sathya Thammanur
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// Summary:
// UDP layer specific functions
//
// $Id: udp.c,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
////////////////////////////////////////////////////////////////////////////////

#include <net/xilsock.h>

struct xilnet_udp_conn xilnet_udp_conns[MAX_UDP_CONNS];
unsigned char isudpinit = 0;

/*
 * udp packet handler
 * "buf" is a IP datagram
 * currently, this fn just checks for the src port and returns
 * there is only one udp conn available. multiple conns has to have 
 * more support from high level applns for handling packets for diff conns.
 */

int xilnet_udp(unsigned char* buf, int len) {

   int i;
   struct xilnet_udp_hdr *udph = (struct xilnet_udp_hdr*) (buf+IP_HDR_LEN*4);
   struct xilnet_udp_conn *curr_conn = NULL;

   // check for an open conn
   for (i = 0; i < MAX_UDP_CONNS; i++) {
      if (xilnet_udp_conns[i].state != UDP_CONN_CLOSED) {
         // match a conn
         if ( (xilnet_udp_conns[i].src_port == udph->dst_port)) {
            curr_conn = (xilnet_udp_conns + i);
            // update the conn with the dst ip only the first time
            xilnet_udp_conns[i].dst_port = udph->src_port;
            xilnet_udp_conns[i].dst_ip[0] = buf[IP_SADDR_BASE];
            xilnet_udp_conns[i].dst_ip[1] = buf[IP_SADDR_BASE+1];
            xilnet_udp_conns[i].dst_ip[2] = buf[IP_SADDR_BASE+2];
            xilnet_udp_conns[i].dst_ip[3] = buf[IP_SADDR_BASE+3];
            //            xilnet_udp_conns[i].state = UDP_CONN_ESTABLISHED;
            break;
         }
      }
   }
   // write data onto the socket of the found conn
   if (curr_conn) {
      buf = buf + (IP_HDR_LEN*4) + UDP_HDR_LEN;
      xilsock_sockets[curr_conn->fd].recvbuf.buf = buf;
      xilsock_sockets[curr_conn->fd].recvbuf.size = len - (IP_HDR_LEN*4) - UDP_HDR_LEN;
      return (len - (IP_HDR_LEN*4) - UDP_HDR_LEN);
   }
   
   return 0;
   
}


/*
 * udp_header: fills the udp header for the packet to be sent
 */

void xilnet_udp_header(struct xilnet_udp_conn *conn, unsigned char* buf, int len) {
   
   struct xilnet_udp_hdr *udph = (struct xilnet_udp_hdr*) buf;
   
   udph->src_port = conn->src_port;
   udph->dst_port = conn->dst_port;
   udph->udp_len = len;
   udph->check_sum = 0;
   udph->check_sum = xilnet_udp_tcp_calc_chksum(buf, len, mb_ip_addr, conn->dst_ip, IP_PROTO_UDP);
}


/* 
 * xilnet_udp_tcp_calc_chksum: Calculate UDP checksum 
 */
unsigned short xilnet_udp_tcp_calc_chksum(unsigned char *buf, int buflen, unsigned char *saddr,
                                        unsigned char *daddr, unsigned short protocol) {
   unsigned int sum = 0;
   unsigned short w16 = 0;
   unsigned short proto = protocol;
   short pad = 0;
   int i = 0;
 
   //check if udp/tcp datagram needs padding
   if (buflen %2) {
      pad = 1; 
      buf[buflen+1] = 0;
   }
   // get the 16bit sum for udp/tcp datagram
   for (i = 0; i < buflen+pad; i = i + 2) {
      w16 = ((buf[i] << 8) & 0xFF00) + (buf[i+1] & 0xFF);
      sum = sum + (unsigned int) w16;   
   }    
   // add the src and dst ip address
   for (i = 0; i < 4; i = i + 2) {
      w16 = ((saddr[i] << 8) & 0xFF00) + (saddr[i+1] & 0xFF);
      sum = sum + (unsigned int) w16;   
   }
   
   for (i = 0; i < 4; i = i + 2) {
      w16 = ((daddr[i] << 8) & 0xFF00) + (daddr[i+1] & 0x00FF);
      sum = sum + (unsigned int) w16;   
   }
   // add proto and udplength to sum
   sum = sum + proto + buflen;

   while (sum >> 16)
      sum = (sum & 0xFFFF) + (sum >> 16);   
   
   return ((unsigned short)(~sum));	
} 


/******************************
 * udp connection management **
 ******************************/

/*
 * initialise all udp conns so that all the states are CLOSED
 */

void xilnet_udp_init_conns() {
   
   int i;

   for (i = 0; i < MAX_UDP_CONNS; i++) {
      xilnet_udp_conns[i].state = UDP_CONN_CLOSED;
   }
   
}


/*
 * open a udp conn:
 * opens a new udp conn and changes state to OPEN
 * returns connection index if able to open else -1 if not possible
 */

int xilnet_udp_open_conn(unsigned short port) {
   
   int i;

   if (!isudpinit) {
      xilnet_udp_init_conns();
      isudpinit = 1; 
   }
   
   for (i = 0; i < MAX_UDP_CONNS; i++) {
      if (xilnet_udp_conns[i].state == UDP_CONN_CLOSED)
         break;
   }
   
   if (i < MAX_UDP_CONNS) {
      xilnet_udp_conns[i].src_port = port;
      xilnet_udp_conns[i].state = UDP_CONN_OPEN;
      return i;
   }
   
   return -1;
   
}


/* close a udp conn:
 * closes a udp conn by changing state to CLOSED
 * returns 1 if able to close else return -1
 */

int xilnet_udp_close_conn(struct xilnet_udp_conn *conn) {
   
   int i;

   for (i = 0; i < MAX_UDP_CONNS; i++) {
      if ( (xilnet_udp_conns+i) == conn) {
         xilnet_udp_conns[i].state = UDP_CONN_CLOSED;
         return 1;
      }
   }
   
   return -1;
}

