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
// File   : tcp.h
// Date   : 2002, March 20.
// Author : Sathya Thammanur
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// Summary:
// Header file for TCP 
//
// $Id: tcp.h,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
////////////////////////////////////////////////////////////////////////////////

#ifndef _TCP_H
#define _TCP_H

#ifdef __cplusplus
extern "C" {
#endif

#include <net/ip.h>
#include <net/xilnet_config.h>

#define TCP_HDR_LEN       0x05  /* hlen in no.of 32-bit words */
#define IP_PROTO_TCP      0x06  /* protocol field in ip header */
#define TCP_PORT          8080  /* tcp port for web server */

struct xilnet_tcp_hdr {
  unsigned short src_port;
  unsigned short dst_port;
  unsigned int	seq_no;
  unsigned int	ack_no;
  unsigned short hdr_len:4,
    reserved:6,
    urg:1,
    ack:1,
    psh:1,
    rst:1,
    syn:1,
    fin:1;
  unsigned char window_size[2];
  unsigned short check_sum;
  unsigned short urg_ptr;
};

// tcp flags
#define TCP_FIN   0x01
#define TCP_SYN   0x02
#define TCP_RST   0x04
#define TCP_PSH   0x08
#define TCP_ACK   0x10
#define TCP_URG   0x20

// offsets for fields in tcp pkt
#define TCP_FLAGS_OFF   0x0d
#define TCP_DEST_OFF    0x02
#define TCP_SRC_OFF     0x0
#define TCP_SEQ_OFF     0x04
#define TCP_ACKSEQ_OFF  0x08
#define TCP_HLEN_OFF    0x0c
#define TCP_CHECK_OFF   0x10
#define TCP_WND_OFF     0xe
#define TCP_URGPTR_OFF  0x12

// tcp mss max seg size
#define TCP_MSS       (LINK_HDR_LEN - 40)
#define TCP_WND_HIGH  (TCP_MSS >> 8)
#define TCP_WND_LOW   (TCP_MSS & 0xff)

// tcp states
enum {
  TCP_CLOSED = 1,
  TCP_LISTEN,
  TCP_SYN_RCVD,
  TCP_SYN_SENT,
  TCP_ESTABLISHED,
  TCP_CLOSE_WAIT,
  TCP_LAST_ACK,
  TCP_FIN_WAIT1,
  TCP_FIN_WAIT2,
  TCP_CLOSING,
  TCP_TIME_WAIT,
};

// tcp conn management

struct xilnet_tcp_conn {
   unsigned short src_port;
   unsigned short dst_port;
   unsigned char src_ip[IP_VERSION];
   unsigned char dst_ip[IP_VERSION];
   unsigned char state;
   int seqno;
   int ack_seqno;
   int exp_acknum;
   int fd; // socket descriptor into xsock_sockets table
};

extern struct xilnet_tcp_conn xilnet_tcp_conns[MAX_TCP_CONNS];

extern void xilnet_tcp_init_conns();

#ifdef __cplusplus
}
#endif

#endif	/* _TCP_H */
