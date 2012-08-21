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
// File   : tcp.c
// Date   : 2002, March 20.
// Author : Sathya Thammanur
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// Summary:
// TCP layer specific functions
//
// $Id: tcp.c,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
////////////////////////////////////////////////////////////////////////////////

#include <net/xilsock.h>

#ifndef NULL
#define NULL 0
#endif 

struct xilnet_tcp_conn xilnet_tcp_conns[MAX_TCP_CONNS];

/*
 * tcp packet handler:
 * "buf" is a IP datagram
 * tcp identifies the right connection the pkt is destined for
 * returns "0", if pkt for existing conn
 * returns "-1", if incorrect pkt
 * returns XILSOCK_NEW_CONN for a new conn
 */

int xilnet_tcp(unsigned char* buf, int len) {
   
   struct xilnet_tcp_conn *curr_conn = NULL;
   struct xilnet_tcp_hdr tcp_req;
   unsigned char* tcp_reply = (sendbuf+LINK_HDR_LEN+(IP_HDR_LEN*4));
   int tcpdata_in = 0;
   int listen_conn_index = -1;
   int reset = FALSE;
   int i;
   int iplen = 0;

   // set the tcp_req to zero
   memset((unsigned char*)&tcp_req, 0, sizeof(struct xilnet_tcp_hdr));
   
   // cpy buf to tcp_req
   memcpy((unsigned char*)(&tcp_req), (buf+IP_HDR_LEN*4), (TCP_HDR_LEN*4));
   
   // check for active conns
   for (i = 0; i < MAX_TCP_CONNS; i++) {
      if (xilnet_tcp_conns[i].state != TCP_CLOSED) {
         if ( (xilnet_tcp_conns[i].src_port == tcp_req.dst_port)) {
            if ( (xilnet_tcp_conns[i].dst_port == tcp_req.src_port) &&
                 (xilnet_tcp_conns[i].dst_ip[0] == buf[IP_SADDR_BASE]) &&
                 (xilnet_tcp_conns[i].dst_ip[1] == buf[IP_SADDR_BASE+1]) &&
                 (xilnet_tcp_conns[i].dst_ip[2] == buf[IP_SADDR_BASE+2]) &&
                 (xilnet_tcp_conns[i].dst_ip[3] == buf[IP_SADDR_BASE+3])
                 ) {
               curr_conn = &(xilnet_tcp_conns[i]);
               break;
            }
            else {
               listen_conn_index = i;
            }
         }
      }
   }
   
   // no activeconn found. check for listening conn
   if (!curr_conn) {
      if (listen_conn_index < 0) {
         reset = TRUE;
      }
      else {
         if (tcp_req.syn) {
            curr_conn = &(xilnet_tcp_conns[listen_conn_index]);
            curr_conn->dst_port = tcp_req.src_port;
            curr_conn->dst_ip[0] = buf[IP_SADDR_BASE] ;
            curr_conn->dst_ip[1] = buf[IP_SADDR_BASE+1];
            curr_conn->dst_ip[2] = buf[IP_SADDR_BASE+2] ;
            curr_conn->dst_ip[3] = buf[IP_SADDR_BASE+3];
         }
         else
            reset = TRUE;
      }
   }
   
   // check if reset flag is set and send a reset packet
   if (reset) {
      struct xilnet_tcp_conn conn = {0};
      conn.src_port = tcp_req.dst_port;
      conn.dst_port = tcp_req.src_port;
      conn.seqno = tcp_req.ack_no;
      conn.ack_seqno = tcp_req.seq_no;
      conn.dst_ip[0] = buf[IP_SADDR_BASE];
      conn.dst_ip[1] = buf[IP_SADDR_BASE+1];
      conn.dst_ip[2] = buf[IP_SADDR_BASE+2] ;
      conn.dst_ip[3] = buf[IP_SADDR_BASE+3];
      memset(sendbuf, 0, LINK_FRAME_LEN);	
      xilnet_tcp_send_pkt(&conn, sendbuf+LINK_HDR_LEN+IP_HDR_LEN*4, 0, TCP_RST);
      xilnet_ip_header(sendbuf+LINK_HDR_LEN, (TCP_HDR_LEN*4)+IP_HDR_LEN*4, IP_PROTO_TCP, conn.dst_ip);
      xilnet_eth_send_frame(sendbuf, (TCP_HDR_LEN*4)+IP_HDR_LEN*4+ETH_HDR_LEN, conn.dst_ip, NULL, ETH_PROTO_IP);
      return 0;
   }
   
   tcpdata_in = len - (IP_HDR_LEN*4) - (tcp_req.hdr_len*4);

   // check for corr acknum if not a syn packet
   if ( (!tcp_req.syn) && (tcp_req.ack_no != curr_conn->exp_acknum)) {
	print("tcp: incorrect acknum \n");
      return -1;
   }
   
   switch (curr_conn->state) {
      
   case TCP_LISTEN:
      // incoming SYN;send ACK and Seqno
      if (tcp_req.syn) {
         unsigned char flags = 0;
         unsigned short check = 0;
         
         // set ack_seqno
         curr_conn->ack_seqno = tcp_req.seq_no + 1;
	 curr_conn->state = TCP_SYN_RCVD;
         xilsock_sockets[curr_conn->fd].recvbuf.buf = buf;
         xilsock_sockets[curr_conn->fd].recvbuf.size = tcpdata_in;
         return XILSOCK_NEW_CONN;
      }
      return -1;
      break;	
      
   case TCP_SYN_RCVD:
      // incoming ACK & no data;
      if (tcp_req.ack && (!tcpdata_in)) {
         // set the ack_seq 
         curr_conn->ack_seqno = tcp_req.seq_no + 1;
         curr_conn->seqno = tcp_req.ack_no;
         curr_conn->state = TCP_ESTABLISHED;
         xilsock_sockets[curr_conn->fd].recvbuf.buf = buf;
         xilsock_sockets[curr_conn->fd].recvbuf.size = tcpdata_in;
         return XILSOCK_SYNACK_RCVD;
      }	
      return -1;
      break;
      
   case TCP_ESTABLISHED:
      // incoming ACK; data in;
      if (tcp_req.ack && (tcpdata_in)) {
         // set the ack seq
         curr_conn->ack_seqno = tcp_req.seq_no + tcpdata_in;
         curr_conn->seqno = tcp_req.ack_no;
         
         // strip tcp header
         buf = buf + (IP_HDR_LEN*4) +(TCP_HDR_LEN*4);
         
         // update socket corr to this conn
         xilsock_sockets[curr_conn->fd].recvbuf.buf = buf;
         xilsock_sockets[curr_conn->fd].recvbuf.size = tcpdata_in;
         return XILSOCK_TCP_DATA;
      }
      else if (tcp_req.ack && (!tcpdata_in)) {
         // set the ack seq
         curr_conn->ack_seqno = tcp_req.seq_no + 1;
         curr_conn->seqno = tcp_req.ack_no;	
         xilsock_sockets[curr_conn->fd].recvbuf.buf = buf;
         xilsock_sockets[curr_conn->fd].recvbuf.size = tcpdata_in;
         return XILSOCK_TCP_ACK;
      }	
      return -1;	
      break;

   case TCP_FIN_WAIT1:
      // wait for fin ack
      if (tcp_req.ack && (!tcpdata_in)) {
         curr_conn->ack_seqno = tcp_req.seq_no + 1;
         curr_conn->seqno = tcp_req.ack_no;
         
         if (tcp_req.fin) {
            
            // send ack for FIN
            memset(sendbuf, 0, LINK_FRAME_LEN);	
            xilnet_tcp_send_pkt(curr_conn, sendbuf+LINK_HDR_LEN+IP_HDR_LEN*4, 0, TCP_ACK);
            xilnet_ip_header(sendbuf+LINK_HDR_LEN, (TCP_HDR_LEN*4)+IP_HDR_LEN*4, IP_PROTO_TCP, curr_conn->dst_ip);
            xilnet_eth_send_frame(sendbuf, (TCP_HDR_LEN*4)+IP_HDR_LEN*4+ETH_HDR_LEN, curr_conn->dst_ip, NULL, ETH_PROTO_IP);
            
            // reset tcp conn state
            xilsock_sockets[curr_conn->fd].closed = 1;
            return XILSOCK_CLOSE_CONN;
         }
         curr_conn->state = TCP_FIN_WAIT2;
         xilsock_sockets[curr_conn->fd].recvbuf.buf = buf;
         xilsock_sockets[curr_conn->fd].recvbuf.size = tcpdata_in;
      }
      return -1;
      break;
      
   case TCP_FIN_WAIT2:
      // incoming FIN;
      if (tcp_req.fin) {
         // set the ack seq
         curr_conn->ack_seqno = tcp_req.seq_no + 1;
         curr_conn->seqno = tcp_req.ack_no;
         
         // send ack for FIN
         memset(sendbuf, 0, LINK_FRAME_LEN);	
         xilnet_tcp_send_pkt(curr_conn, sendbuf+LINK_HDR_LEN+IP_HDR_LEN*4, 0, TCP_ACK);
         xilnet_ip_header(sendbuf+LINK_HDR_LEN, (TCP_HDR_LEN*4)+IP_HDR_LEN*4, IP_PROTO_TCP, curr_conn->dst_ip);
         xilnet_eth_send_frame(sendbuf, (TCP_HDR_LEN*4)+IP_HDR_LEN*4+ETH_HDR_LEN, curr_conn->dst_ip, NULL, ETH_PROTO_IP);
         
         // reset tcp conn state
         xilsock_sockets[curr_conn->fd].closed = 1;
         return XILSOCK_CLOSE_CONN;
      }	
      break;
   default:
      return 0;
      break;
   }	
}


/*
 * xilnet_tcp_send_pkt: sends a tcp packet from "conn", with flags 
 */

void xilnet_tcp_send_pkt(struct xilnet_tcp_conn *conn, unsigned char* buf, int len, unsigned char flags) {
   
   unsigned short check = 0;
   

   // call tcp_header
   xilnet_tcp_header(conn, buf, len, flags);
   
   // calculate checksum
   check = xilnet_udp_tcp_calc_chksum(buf, len+(TCP_HDR_LEN*4), mb_ip_addr, conn->dst_ip, IP_PROTO_TCP);  
   buf[TCP_CHECK_OFF] = (check & 0xff00) >> 8;
   buf[TCP_CHECK_OFF+1] = (check & 0x00ff);
    
}


/*
 * xilnet_tcp_header: creates tcp header
 */
void xilnet_tcp_header(struct xilnet_tcp_conn *conn, unsigned char* buf, int len, unsigned char flags) {

   struct xilnet_tcp_hdr tcph;

   memset((unsigned char*) &tcph, 0, sizeof(struct xilnet_tcp_hdr));
   if (conn) {
      tcph.src_port = conn->src_port;
      tcph.dst_port = conn->dst_port;
      tcph.seq_no = conn->seqno;
      conn->exp_acknum = conn->seqno + len;
      tcph.ack_no = conn->ack_seqno;
   }
  
   tcph.hdr_len = TCP_HDR_LEN;
   tcph.reserved = 0;
   tcph.urg  = (flags & TCP_URG) ? 1:0;
   tcph.ack  = (flags & TCP_ACK) ? 1:0;
   tcph.psh  = (flags & TCP_PSH) ? 1:0;
   tcph.rst  = (flags & TCP_RST) ? 1:0;
   tcph.syn  = (flags & TCP_SYN) ? 1:0;
   if (flags & TCP_FIN) {
      tcph.fin = 1;
      tcph.ack_no -= 1;
   }
  
   tcph.window_size[0] = TCP_WND_HIGH;
   tcph.window_size[1] = TCP_WND_LOW;
   tcph.check_sum = 0;
   tcph.urg_ptr = 0;
  
   memcpy(buf, (unsigned char *) &tcph, (TCP_HDR_LEN*4));
}


/*****************************
 * tcp connection management *
 *****************************/

/*
 * initialise all tcp conns
 */

#define XILNET_TCP_SYS_PORT 8000
unsigned char istcpinit = 0;
void xilnet_tcp_init_conns() {
   
   int i;
   
   for (i = 0; i < MAX_TCP_CONNS; i++) {
      xilnet_tcp_conns[i].state = TCP_CLOSED;      
   }   
}


/*
 * open a tcp conn:
 * opens a new tcp conn and changes state to LISTEN
 * returns connection index if able to open else -1 if not possible
 */

int xilnet_tcp_open_conn(unsigned short port) {

   int i;
   
   if (!istcpinit) {
	xilnet_tcp_init_conns();
 	istcpinit = 1; 
      }
   for (i = 0; i < MAX_TCP_CONNS; i++) {
      if (xilnet_tcp_conns[i].state == TCP_CLOSED)
         break;
   }

   if (i < MAX_TCP_CONNS) {
      xilnet_tcp_conns[i].src_port = port;
      xilnet_tcp_conns[i].state = TCP_LISTEN;
      xilnet_tcp_conns[i].seqno = 0;
      xilnet_tcp_conns[i].ack_seqno = 0;
      xilnet_tcp_conns[i].exp_acknum = 0;
      return i;
   }
   return -1;
   
}


/* close a tcp conn:
 * closes a tcp conn by changing state to TCP_CLOSED
 * returns 1 if able to close else return -1
 */

int xilnet_tcp_close_conn(struct xilnet_tcp_conn *conn) {
   
   int i;
   
   for (i = 0; i < MAX_TCP_CONNS; i++) {
      if ((xilnet_tcp_conns+i) == conn) {
         xilnet_tcp_conns[i].state = TCP_CLOSED;
         return 1;
      }
   }
   return -1;
}
