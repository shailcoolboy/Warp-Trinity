//**********************************************************************************************
// File:    fec_encoder.v
// Author:  Yang Sun (ysun@rice.edu)
// Created: 2010.10.8
//**********************************************************************************************
module fec_encoder (
        clk             ,   // I, clock 
        ce              ,   // I, clock enable
        nrst            ,   // I, n reset
        start           ,   // I, start pulse
        coding_en       ,   // I, coding enable
        pkt_done        ,   // I, pkt transmit done
        fec_rd          ,   // I, fec data request
        info_data       ,   // I, info data
        info_scram      ,   // I, info data scrabled
        info_len        ,   // I, number of payload
        codeword_len    ,   // O, number of coded data in bytes
        info_rd         ,   // O, read
        info_raddr      ,   // O, TX byte address
        fec_data            // O, encoded data in bytes
        ) ;
        
input           clk ;
input           ce ;
input           nrst ;
input           start ;
input           coding_en ;
input           pkt_done ;
input           fec_rd ;
input   [7:0]   info_data ;
input   [7:0]   info_scram ;
input   [15:0]  info_len ;
output  [15:0]  codeword_len ;
output          info_rd ;
output  [13:0]  info_raddr ;
output  [7:0]   fec_data ;


//============================
//Internal signal
//============================
reg             in_enc ;
wire            ff_half_full ;
wire    [7:0]   ff_wdata ;
wire            ff_wr ;
wire            ff_rd ;
wire    [7:0]   ff_rdata ;
wire            enc_done ;
wire            ffdata_req ;
reg             ffdata_req_d ;
reg             ffdata_req_dd ;
reg     [13:0]  addr_out ;

wire    [7:0]   sff_din_cc ;
wire            sff_empty_cc ;
wire            sff_full_cc ;
wire            sff_rd_cc ;
wire            sff_wr_cc ;
wire    [3:0]   sff_dout_cc ;

wire            cc_vin ;
wire    [3:0]   cc_din ;
wire    [7:0]   cc_dout ;
wire    [7:0]   cc_mask ;
wire    [7:0]   cc_dpunct ;
wire    [3:0]   n_cc_dpunct ;

wire            sff_empty_qam ;
wire            sff_full_qam ;
wire            sff_rd_qam ;
wire            sff_wr_qam ;
wire    [7:0]   sff_dout_qam ;
wire    [7:0]   sff_din_qam ;
wire    [3:0]   sff_nsin_qam ;
wire            coding_en ;
wire    [1:0]   cc_rate_mux ;
reg     [1:0]   cc_rate ;

reg     [5:0]   cc_cnt ;
wire            in_baserate_cc ;
reg     [7:0]   fec_data_i ;
wire            bypass ;

reg     [15:0]  pkt_len ;
reg     [15:0]  info_len_lat ;
reg     [15:0]  payload_len ;
wire    [15:0]  payload_len_i ;

wire    [10:0]  coe ;
wire    [26:0]  tmp_mult ;
reg     [15:0]  payload_coded ;

//============================
// Main RTL
//============================
assign info_raddr = addr_out ;
assign fec_data = fec_data_i ;
assign info_rd = ffdata_req_d ;
assign codeword_len = pkt_len ;

always @ (posedge clk or negedge nrst)
  if(~nrst)
    fec_data_i <= 0 ;
  else if(ce)
  begin
    if(start)
      fec_data_i <= 0 ;
    else if(fec_rd)
      fec_data_i <= sff_dout_qam ;
  end


always @ (posedge clk or negedge nrst)
  if (~nrst)
    in_enc <= 1'b0 ;
  else if (ce)
  begin
    if (start)
      in_enc <= 1'b1 ;
    else if (pkt_done)
      in_enc <= 1'b0 ;
  end

assign ffdata_req = in_enc & ~ff_half_full ;
always @ (posedge clk or negedge nrst)
  if (~nrst)
    {ffdata_req_dd, ffdata_req_d} <= 2'b00 ;
  else if (ce)
    {ffdata_req_dd, ffdata_req_d} <= {ffdata_req_d, ffdata_req} ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
    addr_out <= 0 ;
  else if (ce)
  begin
    if (start)
      addr_out <= 0 ;
    else if (ffdata_req)
      addr_out <= addr_out +1 ;
  end

  
assign ff_wr = ffdata_req_dd ;
assign ff_wdata = info_scram ;
assign ff_rd = sff_wr_cc ;

//-- 8x8 Input FIFO
fifo_async_rd #(8, 8, 3) input_fifo (
    .clk        (clk            ),
    .nrst       (nrst           ),
    .ce         (ce             ),
    .reset      (start          ),
    .wdata      (ff_wdata       ),
    .wr         (ff_wr          ),
    .rd         (ff_rd          ),
    .rdata      (ff_rdata       ),
    .empty      (ff_empty       ),
    .half_full  (ff_half_full   ),
    .full       (ff_full        )
    ) ;

    
assign sff_din_cc = ff_rdata ;    
assign sff_wr_cc = (~sff_full_cc) & (~ff_empty) & in_enc ;
assign sff_rd_cc = sff_wr_qam ;

//-- shift fifo between input fifo and CC encoder
sfifo_8to4 cc_fifo (
        .clk        (clk            ),  // clock
        .ce         (ce             ),  // clock enable
        .nrst       (nrst           ),  // asyn reset
        .reset      (start          ),  // sync reset
        .din        (sff_din_cc     ),  // data input
        .dout       (sff_dout_cc    ),  // data output
        .rd         (sff_rd_cc      ),  // read
        .wr         (sff_wr_cc      ),  // write
        .full       (sff_full_cc    ),  // fifo full
        .empty      (sff_empty_cc   ),  // fifo empty
        .nsin       (4'd8           ),  // num of shift in (bits)
        .nsout      (4'd4           )   // num of shift out (bits)
        ) ;

// get coding rate from second byte of the header
always @ (posedge clk or negedge nrst)
  if (~nrst)
    cc_rate <= 0 ;
  else if (ce)
  begin
    if(start)
      cc_rate <= 0 ;
    else if (info_rd & (info_raddr == 3))   // read latency is 2
      cc_rate <= info_data ;
  end

assign cc_vin = sff_wr_qam  ;
assign cc_din = sff_dout_cc ;
assign cc_rate_mux = in_baserate_cc ? 0 : cc_rate ;

//-- cc_encoder
cc_encoder cc_encoder (
        .clk        (clk            ),  // I, clock                                                                                             
        .ce         (ce             ),  // I, clock enable                                                                                      
        .nrst       (nrst           ),  // I, n reset                                                                                           
        .cc_start   (start          ),  // I, start pulse           
        .rate       (cc_rate_mux    ),  // I, code rate                                                                            
        .vin        (cc_vin         ),  // I, valid in                                                                                          
        .din        (cc_din         ),  // I, parallel data input. QPSK = din[3], 16-QAM = din[3:2], 64-QAM = din[3:1], 256-QAM = din[3:0]      
        .vout       (               ),  // O, encoded data out valid                                                                            
        .dout       (cc_dout        ),  // O, arallel data output. QPSK = dout[7:6], 16-QAM = dout[7:4], 64-QAM = dout[7:2], 256-QAM = dout[7:0]
        .mask       (cc_mask        )   // O, mask
        ) ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
    cc_cnt <= 0 ;
  else if (ce)
  begin
    if(start)
      cc_cnt <= 0 ;
    else if (cc_vin & in_baserate_cc)
      cc_cnt <= cc_cnt +1 ;
  end
  
assign in_baserate_cc = cc_cnt != 48; 

//-- cc_puncture
cc_puncture cc_puncture (
    .din    (cc_dout    )   ,   // I, data in
    .mask   (cc_mask    )   ,   // I, data in mask
    .dout   (cc_dpunct  )   ,   // O, data out
    .ndout  (n_cc_dpunct)       // O, number of output bits
    ) ;

assign sff_rd_qam = fec_rd ;
assign sff_wr_qam = ((~sff_full_qam) & (~sff_empty_cc)) & in_enc ;

assign bypass = (~coding_en) | (cc_rate_mux == 3) ;
assign sff_din_qam = bypass ? {sff_dout_cc, 4'd0} : cc_dpunct ;
assign sff_nsin_qam = bypass ? 4 : n_cc_dpunct ;

//-- shift fifo between cc encoder and QAM modulator
sfifo_nto8 output_fifo (
        .clk        (clk            ),  // clock
        .ce         (ce             ),  // clock enable
        .nrst       (nrst           ),  // asyn reset
        .reset      (start          ),  // sync reset
        .din        (sff_din_qam    ),  // data input
        .dout       (sff_dout_qam   ),  // data output
        .rd         (sff_rd_qam     ),  // read
        .wr         (sff_wr_qam     ),  // write
        .full       (sff_full_qam   ),  // fifo full
        .empty      (sff_empty_qam  ),  // fifo empty
        .nsin       (sff_nsin_qam   ),  // num of shift in (bits), could be 4, 6 or 8        
        .nsout      (4'd8           )   // num of shift out (bits)
        ) ;


always @(posedge clk or negedge nrst)
  if(~nrst)
    info_len_lat <= 256 ;
  else if(ce)
    info_len_lat <= info_len ;

always @(posedge clk or negedge nrst)
  if(~nrst)
    payload_len <= 0 ;
  else if(ce)
    payload_len <= info_len -24 ;

assign payload_len_i = {payload_len, 1'b0} ;

always @*
begin
  pkt_len = info_len_lat ;
  if(coding_en)
  begin
    case(cc_rate_mux)
      2'd0: pkt_len = {info_len_lat[14:0], 1'b0} ;  // rate 1/2
      2'd1: pkt_len = payload_coded +50 ;           // rate 2/3
      2'd2: pkt_len = payload_coded +50 ;           // rate 3/4
      2'd3: pkt_len = info_len_lat +24 ;            // rate 1
    endcase
  end   
  else
    pkt_len = info_len_lat ;
end

// 1536 = 3/4 * 2048, 1365 = 2/3 * 2048
assign coe = (cc_rate_mux == 1) ? 1536 : 1365 ;    
assign tmp_mult = coe * payload_len_i ;

always @(posedge clk or negedge nrst)
  if(~nrst)
    payload_coded <= 256 ;
  else if (ce)
    payload_coded <= tmp_mult[26:11] ;
    
endmodule

//**************************************************************
// File:    cc_encoder.v
// Author:  Yang Sun (ysun@rice.edu)
// Created: $ 02/11/07
// Des:     Convolutional encoder core
//          K = 7, compliant with 802.11a
// u0 u1 u2 u3 -> {A0,B0}, {A1,B1}, {A2,B2}, {A3,B3}
//
// History: $ 02/11/07, First version, K = 5
//          $ 03/31/07, Added 256-QAM
//          $ 04/20/07, K = 7
//          $ 04/29/07, Added ce
//          $ 11/26/07, Remove puncture
//          $ 09/27/08, Added puncture
//          $ 10/11/08, Added uncoded and BPSK support
//**************************************************************
module cc_encoder (
        clk         ,   // I, clock 
        ce          ,   // I, clock enable
        nrst        ,   // I, n reset
        cc_start    ,   // I, start pulse
        rate        ,   // I, code rate, 0 = 1/2, 1 = 2/3, 2 = 3/4
        vin         ,   // I, valid in
        din         ,   // I, parallel data input [3:0]
        vout        ,   // O, encoded data out valid
        dout        ,   // O, Parallel data output [7:0]
        mask            // O, mask
        ) ;
        
input               clk ;
input               ce ;
input               nrst ;
input               cc_start ;  
input       [1:0]   rate ;
input               vin ;       
input       [3:0]   din ;       
output              vout ;      
output      [7:0]   dout ;
output reg  [7:0]   mask ;

//===========================================
//Internal signal
//===========================================
wire    [3:0]   u ;
wire    [7:0]   v ;

reg             s0 ;
reg             s1 ;
reg             s2 ;
reg             s3 ;
reg             s4 ;
reg             s5 ;

wire            s0_next ;
wire            s1_next ;
wire            s2_next ;
wire            s3_next ;
wire            s4_next ;
wire            s5_next ;

wire    [3:0]   A ;
wire    [3:0]   B ;

reg     [1:0]   cnt ;

//===========================================
// Main body of code
//===========================================
assign vout = vin ;
assign dout = v ;

assign A[3] = u[3] ^ s1 ^ s2 ^ s4 ^ s5 ;
assign B[3] = u[3] ^ s0 ^ s1 ^ s2 ^ s5 ;

assign A[2] = (u[2] ^ s0 ^ s1 ^ s3 ^ s4) ;
assign B[2] = (u[2] ^ u[3] ^ s0 ^ s1 ^ s4) ;

assign A[1] = (u[1] ^ u[3] ^ s0 ^ s2 ^ s3) ;
assign B[1] = (u[1] ^ u[2] ^ u[3] ^ s0 ^ s3) ;

assign A[0] = (u[0] ^ u[2] ^ u[3] ^ s1 ^ s2) ;
assign B[0] = (u[0] ^ u[1] ^ u[2] ^ u[3] ^ s2) ;

assign u = din ;
assign v = {A[3], B[3], A[2], B[2], A[1], B[1], A[0], B[0]} ;

assign s0_next = u[0] ;
assign s1_next = u[1] ;
assign s2_next = u[2] ;
assign s3_next = u[3] ;
assign s4_next = s0 ;
assign s5_next = s1 ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
  begin
    s0 <= 1'b0 ;
    s1 <= 1'b0 ;
    s2 <= 1'b0 ;
    s3 <= 1'b0 ;
    s4 <= 1'b0 ;
    s5 <= 1'b0 ;
  end
  else if (ce)
  begin
    if (cc_start)
    begin
      s0 <= 1'b0 ;
      s1 <= 1'b0 ;
      s2 <= 1'b0 ;
      s3 <= 1'b0 ;
      s4 <= 1'b0 ;
      s5 <= 1'b0 ;
    end
    else if (vin)
    begin
      s0 <= s0_next ;
      s1 <= s1_next ;
      s2 <= s2_next ;
      s3 <= s3_next ;
      s4 <= s4_next ;
      s5 <= s5_next ;
    end
  end

always @ (posedge clk or negedge nrst)
  if (~nrst)
    cnt <= 0 ;
  else if (ce)
  begin
    if (cc_start)
      cnt <= 0 ;
    else if (vin)
    begin
      if (cnt == 2)
        cnt <= 0 ;
      else
        cnt <= cnt +1 ;
    end
  end

always @*
begin
  mask = 8'd0 ;
  if (rate == 0)
    mask = 8'b1111_1111 ;
  else if (rate == 1)
    mask = 8'b1110_1110 ;
  else
  begin
    case(cnt)
      0: mask = 8'b1110_0111 ;
      1: mask = 8'b1001_1110 ; 
      2: mask = 8'b0111_1001 ;
      default: mask = 8'b1110_0111 ;
    endcase
  end
end

endmodule


//**************************************************************
// File:    cc_puncture.v
// Author:  Yang Sun (ysun@rice.edu)
// Created: $ 09/27/08
// Des:     data puncture
//
// History: $ 09/27/08, created
//**************************************************************
module cc_puncture (
    din         ,   // I, data in
    mask        ,   // I, data in mask
    dout        ,   // O, data out
    ndout           // O, number of output bits
    ) ;
    
input       [7:0]   din ;
input       [7:0]   mask ;

output reg  [7:0]   dout ;
output reg  [3:0]   ndout ;

//===========================================
//Internal signal
//===========================================


//===========================================
// Main RTL
//===========================================
always @*
begin
  ndout = 8 ;
  dout = din ;
  
  case (mask)   
    8'b1111_1111: begin // rate 1/2
      ndout = 8 ;
      dout = din ;
    end
    8'b1110_1110: begin // rate 2/3
      ndout = 6 ;
      dout = {din[7:5], din[3:1], 1'b0, 1'b0} ;
    end
    8'b1110_0111: begin // rate 3/4
      ndout = 6 ;
      dout = {din[7:5], din[2:0], 1'b0, 1'b0} ;
    end    
    8'b1001_1110: begin // rate 3/4
      ndout = 5 ;
      dout = {din[7], din[4:1], 1'b0, 1'b0, 1'b0} ;
    end  
    8'b0111_1001: begin // rate 3/4
      ndout = 5 ;
      dout = {din[6:3], din[0], 1'b0, 1'b0, 1'b0} ;
    end          
  endcase  
end

endmodule

//*********************************************************
// File:    my_fifo_a.v
// Author:  Y. Sun
// Des:     Asnyc read FIFO
//*********************************************************
module fifo_async_rd (
    clk         ,   // I, clock
    ce          ,   // I, clock en
    nrst        ,   // I, async reset
    reset       ,   // I, sync reset
    wdata       ,   // I, write data
    wr          ,   // I, write enable
    rd          ,   // I, read enable
    rdata       ,   // I, read data
    empty       ,   // O, empty
    half_full   ,   // O, half full
    full            // O, full
    ) ;

parameter           WIDTH = 8 ;
parameter           DEPTH = 8 ;
parameter           ADDR_BITS = 3 ;

input               clk ;
input               ce ;
input               nrst ;
input               reset ;
input   [WIDTH-1:0] wdata ;
input               wr ;
input               rd ;
output  [WIDTH-1:0] rdata ;
output              empty ;
output              half_full ;
output              full ;


//============================
// Internal signals
//============================
reg     [WIDTH-1:0]     mem [DEPTH-1:0] ;
reg     [ADDR_BITS:0]   cnt ;
reg     [ADDR_BITS-1:0] waddr ;
reg     [ADDR_BITS-1:0] raddr ;

//============================
// Main RTL Code
//============================
assign empty = cnt == 0 ;
assign full = cnt == DEPTH ;
assign half_full = cnt >= DEPTH/2 ;


always @ (posedge clk or negedge nrst)
  if(~nrst)
    cnt <= 0 ; 
  else if(ce)
  begin
    if (reset)
      cnt <= 0 ;
    else if (wr & ~rd)
      cnt <= cnt +1 ;
    else if (rd & ~wr)
      cnt <= cnt -1 ;
  end

always @ (posedge clk or negedge nrst)
  if(~nrst)
    waddr <= 0 ;
  else if(ce)
  begin
    if (reset)
      waddr <= 0 ;
    else if (wr)
      waddr <= waddr == DEPTH -1 ? 0 : waddr +1 ;
  end
    
always @ (posedge clk or negedge nrst)
  if(~nrst)
    raddr <= 0 ;
  else if(ce)
  begin
    if (reset)
      raddr <= 0 ;
    else if (rd)
      raddr <= raddr == DEPTH -1 ? 0 : raddr +1 ;   
  end 

always @ (posedge clk)
  if(ce)
  begin
    if (wr)
      mem [waddr] <= wdata ;
  end

assign rdata = mem [raddr] ;

endmodule

//********************************************************************************
// File:    sfifo_8to4
// Author:  Yang Sun (ysun@rice.edu)
// Birth:   $ 11/24/07
// Des:     Small size serial fifo
// History: $ 11/24/07, Created
//          $ 11/26/07, Modify input format
//********************************************************************************
module sfifo_8to4 (
        clk         ,   // clock
        ce          ,   // clock enable
        nrst        ,   // asyn reset
        reset       ,   // sync reset
        din         ,   // data input
        dout        ,   // data output
        rd          ,   // read
        wr          ,   // write
        full        ,   // fifo full
        empty       ,   // fifo empty
        nsin        ,   // num of shift in (bits), could be 4, 6 or 8
        nsout           // num of shift out (bits), could be 2 or 4.
        ) ;
        
input           clk ;
input           ce ;
input           nrst ;
input           reset ;
input   [7:0]   din ;
output  [3:0]   dout ;
input           rd ;
input           wr ;
output          full ;
output          empty ;
input   [3:0]   nsin ;
input   [3:0]   nsout ;

//=========================
// Internal signal
//=========================
reg     [15:0]  buffer ;
reg     [4:0]   cnt ;
wire    [19:0]  shift_out ;
wire    [23:0]  shift_in ;
wire    [4:0]   space_left ;

//=========================
// Main RTL
//=========================
assign full = (cnt + nsin) > 16 ;
assign empty = cnt < nsout ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
    cnt <= 0 ;
  else if (ce)
  begin
    if (reset)
      cnt <= 0 ;
    else
    begin
      if (wr & rd)
        cnt <= cnt +nsin -nsout ;
      if (wr & ~rd)
        cnt <= cnt +nsin ;
      if (~wr & rd)
        cnt <= cnt -nsout ;
    end
  end
  
assign shift_out = {4'h0, buffer} << nsout ;  
assign dout = shift_out [19:16] ; 
  
assign space_left = rd ? 16 -cnt + nsout : 16 -cnt ;  
assign shift_in = {16'h0, din} << space_left ;
  
always @ (posedge clk or negedge nrst)
  if (~nrst)
    buffer <= 0 ;
  else if (ce)
  begin
    if (reset)
      buffer <= 0 ;
    else
    begin
      if (wr & rd)
        buffer <= shift_out [15:0] | shift_in [23:8] ;
      if (wr & ~rd)
        buffer <= buffer | shift_in [23:8] ;
      if (~wr & rd)
        buffer <= shift_out [15:0] ;
    end
  end  

endmodule

//********************************************************************************
// File:    sfifo_8to8
// Author:  Yang Sun (ysun@rice.edu)
// Des:     Small size serial fifo, n bit in, 8 bit out
//********************************************************************************
module sfifo_nto8 (
        clk         ,   // clock
        ce          ,   // clock enable
        nrst        ,   // asyn reset
        reset       ,   // sync reset
        din         ,   // data input
        dout        ,   // data output
        rd          ,   // read
        wr          ,   // write
        full        ,   // fifo full
        empty       ,   // fifo empty
        nsin        ,   // num of shift in (bits)
        nsout           // num of shift out (bits)
        ) ;
        
input           clk ;
input           ce ;
input           nrst ;
input           reset ;
input   [7:0]   din ;
output  [7:0]   dout ;
input           rd ;
input           wr ;
output          full ;
output          empty ;
input   [3:0]   nsin ;
input   [3:0]   nsout ;

//=========================================
// Internal signal
//=========================================
reg     [23:0]  buffer ;        // 24-bit buffer
reg     [5:0]   cnt ;           // counter to record num of bits loaded into buffer
wire    [31:0]  shift_out ;
wire    [31:0]  shift_in ;
wire    [5:0]   space_left ;

//=========================================
// Main RTL
//=========================================
assign dout = shift_out [31:24] ;
assign full = (cnt + nsin) > 24 ;
assign empty = cnt < nsout ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
    cnt <= 0 ;
  else if (ce)
  begin
    if (reset)
      cnt <= 0 ;
    else
    begin
      if (wr & rd)
        cnt <= cnt + nsin - nsout ;
      if (wr & ~rd)
        cnt <= cnt + nsin ;
      if (~wr & rd)
        cnt <= cnt - nsout ;
    end
  end
  
assign shift_out = {8'h0, buffer} << nsout ;  
assign space_left = rd ? 24 -cnt + nsout : 24 -cnt ;  
assign shift_in = {24'h0, din} << space_left ;
  
always @ (posedge clk or negedge nrst)
  if (~nrst)
    buffer <= 0 ;
  else if (ce)
  begin
    if (reset)
      buffer <= 0 ;
    else
    begin
      if (wr & rd)
        buffer <= shift_out [23:0] | shift_in [31:8] ;
      if (wr & ~rd)
        buffer <= buffer | shift_in [31:8] ;
      if (~wr & rd)
        buffer <= shift_out [23:0] ;
    end
  end  

endmodule
