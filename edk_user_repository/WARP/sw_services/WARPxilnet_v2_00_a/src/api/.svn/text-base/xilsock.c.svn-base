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
// File   : xilsock.c
// Date   : 2002, March 20.
// Author : Sathya Thammanur
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// Summary:
// Xilinx internal socket related functions (xilsock functions)
//
// $Id: xilsock.c,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
////////////////////////////////////////////////////////////////////////////////


#include <net/xilsock.h>

/* buffers for sending and receiving packets */
unsigned char recvbuf[LINK_FRAME_LEN];
unsigned char sendbuf[LINK_FRAME_LEN];
unsigned char mb_ip_addr[IP_VERSION] = {0,0,0,0};    /* microblaze ip address , currently set to 127.0.0.0 */
unsigned char mb_hw_addr[ETH_ADDR_LEN] = {0x00,0x60,0x08,0x11,0x27,0x7b};  /* microblaze hardware address */

unsigned char magicSync_ip_addr[IP_VERSION] = {0,0,0,0};

struct xilsock_socket xilsock_sockets[NO_OF_XILSOCKS];
/* gives the status of the received packet */
int xilsock_status_flag = 0;

/*
 * Initialisation of xilsock_sockets
 */

unsigned char is_xilsock_init = 0;

int xilsock_init (void) {

   int i;
   if (!is_xilsock_init) {
      for (i = 0; i < NO_OF_XILSOCKS; i++) {
         xilsock_sockets[i].type = 0;
         xilsock_sockets[i].domain = 0;
         xilsock_sockets[i].proto = 0;
         xilsock_sockets[i].listen = 0;
         xilsock_sockets[i].bound = 0;
         xilsock_sockets[i].accept = 0;
         xilsock_sockets[i].connect = 0;
         xilsock_sockets[i].closing = 0;
         xilsock_sockets[i].closed = 0;
         xilsock_sockets[i].free = 1;
         xilsock_sockets[i].conn.tcp_conn = NULL;
         xilsock_sockets[i].recvbuf.buf = NULL;
         xilsock_sockets[i].recvbuf.size = 0;
      }
      is_xilsock_init = 1;
   }
   return is_xilsock_init;
}


/*
 * Release a socket
 */

void xilsock_rel_socket (int sd) {

   if (xilsock_sockets[sd].type == SOCK_STREAM) {
      xilsock_sockets[sd].conn.tcp_conn = NULL;
   }
   else {
      xilsock_sockets[sd].conn.udp_conn = NULL;
   }
   xilsock_sockets[sd].type = 0;
   xilsock_sockets[sd].domain = 0;
   xilsock_sockets[sd].proto = 0;
   xilsock_sockets[sd].listen = 0;
   xilsock_sockets[sd].bound = 0;
   xilsock_sockets[sd].accept = 0;
   xilsock_sockets[sd].connect = 0;
   xilsock_sockets[sd].closing = 0;
   xilsock_sockets[sd].closed = 0;
   xilsock_sockets[sd].free = 1;
   xilsock_sockets[sd].recvbuf.buf = NULL;
   xilsock_sockets[sd].recvbuf.size = 0;

}


/*
 * Allocate a xilsock_socket and return socket descriptor
 * if not able to alloc socket, return -1
 */

int xilsock_socket(int domain, int type, int proto) {

   int sd;

   // find a free xilsock_socket
   if (!xilsock_init())
      return (-1);
   for (sd = 0; sd < NO_OF_XILSOCKS; sd++) {
      if (xilsock_sockets[sd].free) {
         // initialise the socket & make it unavailable
         xilsock_sockets[sd].domain = domain;
         xilsock_sockets[sd].type = type;
         xilsock_sockets[sd].proto = proto;
         xilsock_sockets[sd].free = 0;
         return sd;
      }
   }
   // return as no sockets available
   return -1;
}


/*
 * bind a socket to the specified address.
 * binds addr to socket sd. returns 1 if bound
 * returns -1 if not able to bind
 */

int xilsock_bind(int sd, struct sockaddr* addr, int addrlen) {

   int connd;

   // open a tcp conn/udp conn
   if (xilsock_sockets[sd].type == SOCK_STREAM) {
      if ( (connd = xilnet_tcp_open_conn (((struct sockaddr_in*)addr)->sin_port)) == -1) {
         print("bind: tcp sockets not available \n");
         xilsock_rel_socket(sd);
         return -1;
      }
      xilsock_sockets[sd].conn.tcp_conn = (xilnet_tcp_conns + connd);
      // update fd of tcp conn
      xilnet_tcp_conns[connd].fd = sd;
   }
   else if (xilsock_sockets[sd].type == SOCK_DGRAM) {
      if ( (connd = xilnet_udp_open_conn (((struct sockaddr_in*)addr)->sin_port)) == -1) {
         print("bind: udp sockets not available \n");
         xilsock_rel_socket(sd);
         return -1;
      }
      xilsock_sockets[sd].conn.udp_conn = (xilnet_udp_conns + connd);
      // update fd of udp conn
      xilnet_udp_conns[connd].fd = sd;
   }

   return 1;
}


/*
 * listen on a socket
 * called from listen()
 */

int xilsock_listen(int s, int backlog) {

   xilsock_sockets[s].listen = 1;
   return 1;

}


/*
 * accept a conn on the socket
 * if pkt for new conn, open new xilsock_socket, return 0
 * if pkt for exisiting conn, return 0
 */

int xilsock_accept(int sd, struct sockaddr* addr, int *addrlen) {

   int n = 0;
   int nsd;
   int ns;
   struct xilnet_tcp_conn* new_conn;
   struct xilnet_tcp_conn* curr_conn;
   int connd;
   unsigned char *buf = recvbuf; // recvbuf is the array to recv messages
   int len = LINK_FRAME_LEN;

   // reset status flag
   xilsock_status_flag = 0;

   // check for tcp conn to execute this call
   if (xilsock_sockets[sd].type != SOCK_STREAM) {
      print("accept: not a tcp socket \n");
      return -1;
   }

   // call eth recv. if return val is 1, new conn
   // create new file, socket with same properties
   // else no new conn., return -1

   n = xilnet_eth_recv_frame(buf, len);
   if (n < 0) // not for any of the supported conns
      return -1;

   if ( n == XILSOCK_NEW_CONN) {
      // create a new socket
      nsd = xilsock_socket(xilsock_sockets[sd].domain, xilsock_sockets[sd].type, xilsock_sockets[sd].proto);
      if (nsd < 0) {
         print("xilsock sockets not available \n");
         return (-1);
      }
      if ( (connd = xilnet_tcp_open_conn (xilsock_sockets[sd].conn.tcp_conn->src_port)) == -1) {
         print("accept: tcp sockets not available \n");
         xilsock_rel_socket(nsd);
         return -1;
      }
      // copy the orig socket characteristics to new socket
      xilsock_sockets[nsd].type = xilsock_sockets[sd].type;
      xilsock_sockets[nsd].domain = xilsock_sockets[sd].domain;
      xilsock_sockets[nsd].proto = xilsock_sockets[sd].proto;
      xilsock_sockets[nsd].connect = 1;
      new_conn = xilsock_sockets[nsd].conn.tcp_conn = (xilnet_tcp_conns + connd);
      curr_conn = xilsock_sockets[sd].conn.tcp_conn;

      // update new tcp conn which starts listening
      new_conn->fd = nsd;
      new_conn->dst_ip[0] = xilsock_sockets[sd].conn.tcp_conn->dst_ip[0];
      new_conn->dst_ip[1] = xilsock_sockets[sd].conn.tcp_conn->dst_ip[1];
      new_conn->dst_ip[2] = xilsock_sockets[sd].conn.tcp_conn->dst_ip[2];
      new_conn->dst_ip[3] = xilsock_sockets[sd].conn.tcp_conn->dst_ip[3];
      new_conn->dst_port = xilsock_sockets[sd].conn.tcp_conn->dst_port;
      new_conn->seqno = curr_conn->seqno;
      new_conn->ack_seqno = curr_conn->ack_seqno;
      new_conn->exp_acknum = curr_conn->exp_acknum;
      new_conn->state = curr_conn->state;

      // reset the listening connection
      curr_conn->state = TCP_LISTEN;
      curr_conn->dst_ip[0] = 0;
      curr_conn->dst_ip[1] = 0;
      curr_conn->dst_ip[2] = 0;
      curr_conn->dst_ip[3] = 0;
      curr_conn->dst_port = 0;
      curr_conn->seqno = 0;
      curr_conn->ack_seqno = 0;
      curr_conn->exp_acknum = 0;
      xilsock_sockets[sd].listen = 1;

      // send a reply using new socket
      memset(sendbuf, 0, LINK_FRAME_LEN);
      xilnet_tcp_send_pkt(new_conn, (sendbuf + LINK_HDR_LEN + (IP_HDR_LEN*4)), 0, (TCP_SYN|TCP_ACK));
      xilnet_ip_header(sendbuf+LINK_HDR_LEN,(IP_HDR_LEN*4)+(TCP_HDR_LEN*4), IP_PROTO_TCP, new_conn->dst_ip);
      xilnet_eth_send_frame(sendbuf,LINK_HDR_LEN+(IP_HDR_LEN*4)+(TCP_HDR_LEN*4), new_conn->dst_ip, 0, ETH_PROTO_IP);
      new_conn->exp_acknum += 1;

      // set status flag
      xilsock_status_flag |= XILSOCK_NEW_CONN;
      return nsd;
   }
   else if (n == XILSOCK_CLOSE_CONN) {
      int i;
      for ( i = 0; i < NO_OF_XILSOCKS; i++) {
         if (xilsock_sockets[i].closed) {
            // close conn
            if (xilsock_sockets[i].type == SOCK_STREAM)
               xilnet_tcp_close_conn(xilsock_sockets[i].conn.tcp_conn);
            else if (xilsock_sockets[i].type == SOCK_DGRAM)
               xilnet_udp_close_conn(xilsock_sockets[i].conn.udp_conn);
            // close the socket
            xilsock_rel_socket(i);
	    // set status flag
            xilsock_status_flag |= XILSOCK_CLOSE_CONN;
            return -1;
         }
      }
   }
   // set status flag
   xilsock_status_flag |= n;
   return n;
}


/*
 * recv data on socket
 * called from recv()
 * returns -1 if no data recvd for "s" (non_blocking call) or
 * number of bytes recvd for "s"
 */

int xilsock_recv(int s, unsigned char *buf, unsigned int len) {

   int n;
   int i;
   int bytes_recvd = 0;

   if (s > NO_OF_XILSOCKS) {
      print("recv: invalid socket descriptor \n");
      exit(-1);
   }

   n = xilnet_eth_recv_frame(buf, len);

   // Return if data not for socket s
   if ((n < 0 ) || (xilsock_sockets[s].recvbuf.buf == NULL))
      return -1;

   // Copy data if required onto buf
   if (xilsock_sockets[s].recvbuf.buf != buf)
   {
      memcpy(buf, xilsock_sockets[s].recvbuf.buf, len);
      bytes_recvd = xilsock_sockets[s].recvbuf.size;

      //reset socket buffer and size
      xilsock_sockets[s].recvbuf.buf = NULL;
      xilsock_sockets[s].recvbuf.size = 0;
   }


   // return no of bytes recvd for this conn
   //return xilsock_sockets[s].recvbuf.size;
   return bytes_recvd;

}


/*
 * send data on socket
 * called from send()
 */

int xilsock_send(int s,  unsigned char* buf, unsigned int len) {

   struct xilnet_tcp_conn *conn;

   conn = xilsock_sockets[s].conn.tcp_conn;

   if (!conn) {
      print("send: no such socket \n");
      return -1;
   }

   if (buf != sendbuf) {
      memset(sendbuf, 0, LINK_FRAME_LEN);
      memcpy(sendbuf+LINK_HDR_LEN+IP_HDR_LEN*4+(TCP_HDR_LEN*4), buf, len);
   }

   xilnet_tcp_send_pkt(conn, sendbuf+LINK_HDR_LEN+IP_HDR_LEN*4, len, TCP_ACK);
   xilnet_ip_header(sendbuf+LINK_HDR_LEN, len+(TCP_HDR_LEN*4)+IP_HDR_LEN*4, IP_PROTO_TCP, conn->dst_ip);

   xilnet_eth_send_frame(sendbuf, len+(TCP_HDR_LEN*4)+IP_HDR_LEN*4+ETH_HDR_LEN, conn->dst_ip, NULL, ETH_PROTO_IP);

   return len;

}


/*
 * recvfrom socket
 * Data recvd on any UDP socket
 * return -1 if data not for socket "s" [non-blocking call]
 */
int xilsock_recvfrom(int s, unsigned char *buf, unsigned int len,
                     struct sockaddr* from, unsigned int *fromlen)
{
   int n;
   int i;
   int bytes_recvd = 0;

   struct xilnet_udp_conn *conn = xilsock_sockets[s].conn.udp_conn;

   if (s > NO_OF_XILSOCKS) {
      print("recvfrom: invalid socket descriptor \n");
      exit(-1);
   }

   n = xilnet_eth_recv_frame(buf, len);

   // Return if data not for socket s
   if ((n < 0 ) || (xilsock_sockets[s].recvbuf.buf == NULL))
      return -1;

   // Copy data if required onto buf
   if (xilsock_sockets[s].recvbuf.buf != buf)
   {
      memcpy(buf, xilsock_sockets[s].recvbuf.buf, len);
      bytes_recvd = xilsock_sockets[s].recvbuf.size;

      //reset socket buffer and size
      xilsock_sockets[s].recvbuf.buf = NULL;
      xilsock_sockets[s].recvbuf.size = 0;
   }

   // Copy the source address onto "to"
   ((struct sockaddr_in*)from)->sin_addr.s_addr =
      (conn->dst_ip[0] << 24) + (conn->dst_ip[1] << 16) + (conn->dst_ip[2] << 8) + conn->dst_ip[3];
   ((struct sockaddr_in*)from)->sin_port = conn->dst_port;
   *fromlen = sizeof(from);

   // return no of bytes recvd for this conn
   return bytes_recvd;

}


/*
 * sendto socket
 * called from sendto()
 */

int xilsock_sendto(int s,  unsigned char* buf, unsigned int len, struct sockaddr* to, unsigned int tolen)
{

   struct xilnet_udp_conn *conn;
   unsigned int dstaddr = ((struct sockaddr_in*)to)->sin_addr.s_addr;

   conn = xilsock_sockets[s].conn.udp_conn;
   conn->dst_ip[0] = (unsigned char) ((dstaddr >> 24) & 0xFF);
   conn->dst_ip[1] = (unsigned char) ((dstaddr >> 16) & 0xFF);
   conn->dst_ip[2] = (unsigned char) ((dstaddr >> 8) & 0xFF);
   conn->dst_ip[3] = (unsigned char) ((dstaddr) & 0xFF);
   conn->dst_port = ((struct sockaddr_in*)to)->sin_port;

   if (!conn) {
      print("sendto: no such socket \n");
      return -1;
   }

   if (buf != sendbuf) {
      memset(sendbuf, 0, LINK_FRAME_LEN);
      memcpy(sendbuf+LINK_HDR_LEN+IP_HDR_LEN*4+UDP_HDR_LEN, buf, len);
   }

   // calls to udp stack
   xilnet_udp_header(conn, sendbuf+LINK_HDR_LEN+IP_HDR_LEN*4, len+UDP_HDR_LEN);
   xilnet_ip_header(sendbuf+LINK_HDR_LEN, len+UDP_HDR_LEN+IP_HDR_LEN*4, IP_PROTO_UDP, conn->dst_ip);

   xilnet_eth_send_frame(sendbuf, len+UDP_HDR_LEN+IP_HDR_LEN*4+ETH_HDR_LEN, conn->dst_ip, NULL, ETH_PROTO_IP);

   return len;
}


/*
 * close socket
 */

void xilsock_close(int s) {

   unsigned char flags = 0;
   unsigned short check = 0;
   unsigned char *tcp_reply;

   if (xilsock_sockets[s].type == SOCK_STREAM) {
      struct xilnet_tcp_conn *conn = xilsock_sockets[s].conn.tcp_conn;

      // construct the FIN and wait for ack & FIN from client
      flags = (TCP_FIN | TCP_ACK);
      ((struct xilnet_tcp_conn*)conn)->state = TCP_FIN_WAIT1;
      memset(sendbuf, 0, LINK_FRAME_LEN);
      tcp_reply = sendbuf+ETH_HDR_LEN+(IP_HDR_LEN*4);

      xilnet_tcp_header(((struct xilnet_tcp_conn*)conn), tcp_reply, 1, flags);

      // calculate tcp checksum
      check = xilnet_udp_tcp_calc_chksum(tcp_reply, (TCP_HDR_LEN*4), mb_ip_addr, ((struct xilnet_tcp_conn*)conn)->dst_ip, IP_PROTO_TCP);
      tcp_reply[TCP_CHECK_OFF] = (check & 0xff00) >> 8;
      tcp_reply[TCP_CHECK_OFF+1] = (check & 0x00ff);

      xilnet_ip_header(sendbuf+ETH_HDR_LEN,(IP_HDR_LEN*4)+(TCP_HDR_LEN*4), IP_PROTO_TCP, ((struct xilnet_tcp_conn*)conn)->dst_ip);
      xilnet_eth_send_frame(sendbuf, (TCP_HDR_LEN*4)+(IP_HDR_LEN*4)+ETH_HDR_LEN, ((struct xilnet_tcp_conn*)conn)->dst_ip, NULL, ETH_PROTO_IP);


   }
   else if (xilsock_sockets[s].type == SOCK_DGRAM) {
      xilnet_udp_close_conn(xilsock_sockets[s].conn.udp_conn);
      // close the socket
      xilsock_rel_socket(s);
   }

}
