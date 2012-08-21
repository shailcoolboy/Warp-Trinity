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
// File   : xilsock.h
// Date   : 2002, March 20.
// Author : Sathya Thammanur
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// Summary:
// Header file for Xilinx internal socket structure definitions
//
// $Id: xilsock.h,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
////////////////////////////////////////////////////////////////////////////////

#ifndef _XILSOCK_H_
#define _XILSOCK_H_

#ifdef __cplusplus
extern "C" {
#endif

#include <net/eth.h>
#include <net/arp.h>
#include <net/ip.h>
#include <net/tcp.h>
#include <net/udp.h>
#include <net/icmp.h>
#include <net/in.h>
#include <net/socket.h>
#include <string.h>

// definitions for connections
#define TRUE                  1
#define FALSE                 0

/* Data Link Layer definitions
 * Add #if's for PPP header lengths
 */

#define LINK_HDR_LEN          ETH_HDR_LEN
#define LINK_FRAME_LEN     ETH_FRAME_LEN

// msg structure
struct xilsock_buf {
   unsigned char *buf;
   int size;
};


// internal socket structure
struct xilsock_socket {
   int type;
   int domain;
   int proto;
   // status of socket
   unsigned char listen:1;
   unsigned char bound:1;
   unsigned char accept:1;
   unsigned char connect:1;
   unsigned char free:1;
   unsigned char closing:1;
   unsigned char closed:1;
   union {
      struct xilnet_tcp_conn *tcp_conn;
      struct xilnet_udp_conn *udp_conn;
   } conn;
   int *if_addr;                 // interface base addr
   struct xilsock_buf recvbuf;     // structure for recv/send msgs
};

#define NO_OF_XILSOCKS   (MAX_TCP_CONNS+MAX_UDP_CONNS)
extern struct xilsock_socket xilsock_sockets[NO_OF_XILSOCKS];


/* #defines for TCP communication */
#define XILSOCK_NEW_CONN        0x1
#define XILSOCK_SYNACK_RCVD     0x2
#define XILSOCK_TCP_DATA        0x4
#define XILSOCK_TCP_ACK         0x8
#define XILSOCK_EXISTING_CONN   0x10
#define XILSOCK_CLOSE_CONN      0x20

/* Functions of xilsock sockets */

//#define xilsock_recvfrom xilsock_recv

extern int xilsock_init(void);
extern void xilsock_rel_socket(int);
extern int xilsock_socket(int, int, int);
extern int xilsock_bind(int, struct sockaddr*, int);
extern int xilsock_listen(int, int);
extern int xilsock_accept(int, struct sockaddr*, int*);
extern int xilsock_recv(int, unsigned char*, unsigned int);
extern int xilsock_recvfrom(int, unsigned char*, unsigned int, struct sockaddr* from, unsigned int *fromlen);
extern int xilsock_sendto(int, unsigned char*, unsigned int, struct sockaddr* to, unsigned int tolen);
extern int xilsock_send(int, unsigned char*, unsigned int);
extern void xilsock_close(int);

/*
 * TCP/IP functions Prototype
 */

// Ethernet functions
extern int xilnet_eth_recv_frame(unsigned char *, int);
extern int xilnet_eth_send_frame(unsigned char *, int, unsigned char*, void*, unsigned short);
extern void xilnet_eth_update_hw_tbl(unsigned char *, int);
extern void xilnet_add_hw_tbl_entry(unsigned char *, unsigned char *);
extern int xilnet_eth_get_hw_addr(unsigned char *);
extern void xilnet_eth_init_hw_addr_tbl(void);
extern int xilnet_eth_find_old_entry(void);

// ARP functions
extern int xilnet_arp(unsigned char*, int);
extern void xilnet_arp_reply(unsigned char*, int);

// IP functions
extern void xilnet_ip_init(unsigned char*);
extern int xilnet_ip(unsigned char*, int);
extern void xilnet_ip_header(unsigned char*, int, int, unsigned char*);
extern unsigned short xilnet_ip_calc_chksum(unsigned char*, int);

// TCP/UDP/ICMP functions
extern int xilnet_udp(unsigned char*, int);
extern void xilnet_udp_header(struct xilnet_udp_conn*, unsigned char*, int);
extern unsigned short xilnet_udp_tcp_calc_chksum(unsigned char*, int, unsigned char*, unsigned char*, unsigned short);
extern void xilnet_udp_init_conns();
extern int xilnet_udp_open_conn(unsigned short);
extern int xilnet_udp_close_conn(struct xilnet_udp_conn*);
extern void xilnet_icmp_echo_reply(unsigned char *, unsigned int);
extern int xilnet_icmp(unsigned char *, int);
extern int xilnet_tcp(unsigned char*, int);
extern void xilnet_tcp_header(struct xilnet_tcp_conn*, unsigned char*, int, unsigned char);
extern void xilnet_tcp_send_pkt(struct xilnet_tcp_conn*, unsigned char*, int, unsigned char);
extern void xilnet_tcp_init_conns();
extern int xilnet_tcp_open_conn(unsigned short);
extern int xilnet_tcp_close_conn(struct xilnet_tcp_conn*);

/* buffers for sending and receiving packets */
extern unsigned char recvbuf[];
extern unsigned char sendbuf[];
extern unsigned char mb_ip_addr[IP_VERSION];
extern unsigned char mb_hw_addr[ETH_ADDR_LEN];
extern int xilsock_status_flag;

extern unsigned char magicSync_ip_addr[IP_VERSION];

#ifdef __cplusplus
}
#endif

#endif /* _XILSOCK_H_ */
