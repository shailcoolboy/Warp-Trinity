//********************************************************************************************
// File:    fec_decoder
// Author:  Yang Sun (ysun@rice.edu)
// Birth:   $ 4/26/07
// Des:     This module integreated a Viterbi decoder
// History: $ 04/26/07: Init coding for QPSK CC coding
//          $ 11/25/07: Updated for uncodede system
//          $ 04/16/08: Added 16-QAM support
//          $ 09/27/08: Added dec-puncture  
//          $ 09/27/08: Added dec-puncture 
//          $ 10/11/08, Added uncodeded and BPSK
//          $ 10/10/10, OFDM reference design v15.0
//********************************************************************************************
module fec_decoder (
        clk         , // I, clock
        ce          , // I, clock enable
        nrst        , // I, n reset 
        fec_reg     , // I, controll register
        start       , // I, packet start pulse
        vin         , // I, data valid input
        xk_index    , // I, FFT index
        mod_level   , // I, 0=Invalid, 1=BPSK, 2=QPSK, 4=16-QAM
        rx_i        , // I, RX I 
        rx_q        , // I, RX Q
        rx_we       , // O, buffer write enable
        rx_addr     , // O, buffer write address 
        rx_data     , // O, buffer write data
        rx_done     , // O, RX done pulse
        rx_we_2     , // O, buffer write enable in clk/2 domain
        rx_addr_2   , // O, buffer write address in clk/2 domain
        rx_data_2   , // O, buffer write data in clk/2 domain
        rx_done_2     // O, RX done pulse in clk/2 domain
        ) ;
        
input           clk ;
input           ce ;
input           nrst ;
input   [31:0]  fec_reg ;
input           start ;
input           vin ;
input   [5:0]   xk_index ;
input   [3:0]   mod_level ;     
input   [15:0]  rx_i ;
input   [15:0]  rx_q ;
output          rx_we ;
output  [13:0]  rx_addr ;
output  [7:0]   rx_data ;
output          rx_done ;
output          rx_we_2 ;
output  [13:0]  rx_addr_2 ;
output  [7:0]   rx_data_2 ;
output          rx_done_2 ;

//==============================
//Internal signal
//==============================
wire            sym_start ;
wire    [3:0]   llr_a ;
wire    [3:0]   llr_b ;
wire            dec_vout ;

wire    [7:0]   dec_dout ;

wire    [13:0]  nbyte ;
wire    [13:0]  byte_cnt ;
wire            rx_packet_done ;
reg             rx_packet_done_s0 ;
reg             rx_packet_done_s1 ;

wire            demapper_vld ;
wire            coding_en ;
wire            zero_tail ;
wire            soft_decoding ;
wire    [3:0]   scale_qpsk ;
wire    [4:0]   scale_16qam ;

wire            depunct_dav ;
wire    [7:0]   iq_data ;
wire    [7:0]   iq_data_buf ;
wire            llr_buf_empty ;
wire            buf_full ;
wire    [3:0]   llr_i_depunc ;
wire    [3:0]   llr_q_depunc ;
wire            llr_valid ;
wire            llr_buf_rd ;

wire            ack_pkt ;

wire    [1:0]   cc_rate ;

reg     [23:0]  timeout_reg ;
reg             in_dec ;
wire            timeout ;
reg             timeout_s1 ;
wire            timeout_pls ;
wire            depunt_buf_rd ;
wire            in_fullrate ;
wire            unc_buf_rd ;
wire            data_coded ;
wire    [3:0]   hdr_mod_level ;

wire            we_1x ;
wire    [7:0]   data_1x ;

wire            we_down2 ;
wire    [7:0]   data_down2 ;
wire    [13:0]  addr_down2 ;
reg             rx_done_d ;
wire            rx_done_i ;
reg     [15:0]   rx_done_dly ;

//=========================================
// Main body of code
//=========================================
assign rx_done = (rx_packet_done_s0 & ~rx_packet_done_s1) | timeout_pls ;
assign rx_addr = byte_cnt ;
assign rx_data = dec_dout ;
assign rx_we = dec_vout & ~rx_packet_done ;

assign rx_addr_2 = addr_down2 ;
assign rx_we_2 = we_down2 ;
assign rx_data_2 = data_down2 ;
assign rx_done_2 = rx_done_dly[15] ;


assign we_1x = dec_vout & ~rx_packet_done ;
assign data_1x = dec_dout ;

assign coding_en = fec_reg [0] ;
assign soft_decoding = fec_reg [1] ;
assign zero_tail = fec_reg [2] ;
assign scale_qpsk = fec_reg [7:4] ;
assign scale_16qam = fec_reg [12:8] ;


always @(posedge clk or negedge nrst)
  if(~nrst)
    rx_done_d <= 1'b0 ;
  else
    rx_done_d <= rx_done ;

assign rx_done_i = rx_done | rx_done_d ;

always @(posedge clk or negedge nrst)
  if(~nrst)
    rx_done_dly <= 0 ;
  else
    rx_done_dly <= {rx_done_dly[14:0], rx_done_i} ;

//==============================
// soft_demapper
//==============================
soft_demapper soft_demapper (
        .clk            (clk            ), 
        .nrst           (nrst           ),
        .start          (start          ), 
        .coding_en      (coding_en      ),
        .vin            (vin            ), 
        .xk_index       (xk_index       ), 
        .mod_level      (mod_level      ),
        .rx_i           (rx_i           ), 
        .rx_q           (rx_q           ),
        .scale_qpsk     (scale_qpsk     ),
        .scale_16qam    (scale_16qam    ),
        .in_fullrate    (in_fullrate    ),
        .sym_start      (sym_start      ),
        .hdr_mod_level  (hdr_mod_level  ),
        .vout           (demapper_vld   ),
        .soft_decoding  (soft_decoding  ),
        .llr_a          (llr_a          ), 
        .llr_b          (llr_b          ) 
        ) ;

assign iq_data = {llr_a, llr_b} ;
assign llr_buf_rd = (in_fullrate & ~data_coded) ? unc_buf_rd : depunt_buf_rd ;

//==============================
// LLR buffer
//==============================
llr_buffer llr_buffer (
        .clk    (clk            ),  
        .nrst   (nrst           ),  
        .reset  (start          ),  
        .din    (iq_data        ),  
        .dout   (iq_data_buf    ),  
        .wr     (demapper_vld   ),  
        .rd     (llr_buf_rd     ),  
        .empty  (llr_buf_empty  ),  
        .full   (buf_full       )   
        ) ;

assign depunct_dav = ~llr_buf_empty ;
//==============================
// depuncture
//==============================
depunc depunc (
        .clk        (clk            ), 
        .nrst       (nrst           ), 
        .start      (start          ), 
        .dav        (depunct_dav    ), 
        .rate       (cc_rate        ), 
        .din        (iq_data_buf    ), 
        .vout       (llr_valid      ), 
        .dout_a     (llr_i_depunc   ), 
        .dout_b     (llr_q_depunc   ), 
        .buf_rd     (depunt_buf_rd  )  
        ) ;

//==============================
// decoder_system
//==============================
decoder_system decoder_system (
        .clk            (clk            ),  // I, clock
        .nrst           (nrst           ),  // I, n reset
        .start          (start          ),  // I, start pulse
        .in_dec         (in_dec         ),
        .coding_en      (coding_en      ),
        .zero_tail      (zero_tail      ),
        .sym_start      (sym_start      ),  // I, sym start
        .hdr_mod_level  (hdr_mod_level  ),
        .unc_buf_rd     (unc_buf_rd     ),  // I, LLR buffer read by unc
        .vin            (llr_valid      ),  // I, data valid input
        .llr_buf_empty  (llr_buf_empty  ),  // I, LLR buffer empty
        .llr_a          (llr_i_depunc   ),  // I, LLR I channel
        .llr_b          (llr_q_depunc   ),  // I, LLR Q channel
        .vout           (dec_vout       ),  // O, data valid output
        .dout           (dec_dout       ),  // O, byte data output
        .nbyte          (nbyte          ),  // O, num of bytes
        .byte_cnt       (byte_cnt       ),  // O, byte cnt
        .cc_rate        (cc_rate        ),  // O, code rate
        .data_coded     (data_coded     ),  // O, coded system
        .in_fullrate    (in_fullrate    )   // O, in full rate
        ) ;

out_ctrl out_ctrl (
        .clk        (clk        ),
        .nrst       (nrst       ),
        .start      (start      ),
        .vin        (we_1x      ),
        .din        (data_1x    ),
        .vout       (we_down2   ),
        .dout       (data_down2 ),
        .idx_out    (addr_down2 )
    ) ;



assign rx_packet_done = byte_cnt >= nbyte ;
always @ (posedge clk or negedge nrst)
  if (~nrst)
  begin
    rx_packet_done_s0 <= 1'b0 ;
    rx_packet_done_s1 <= 1'b0 ;    
  end
  else
  begin
    rx_packet_done_s0 <= rx_packet_done ;
    rx_packet_done_s1 <= rx_packet_done_s0 ;
  end
  

assign ack_pkt = (nbyte == 24) ;

always @(posedge clk or negedge nrst)
  if (~nrst)
    in_dec <= 1'b0 ;
  else if (start)
    in_dec <= 1'b1 ;
  else if (rx_done)
    in_dec <= 1'b0 ;

assign timeout = timeout_reg == 24'h40000 ;
always @(posedge clk or negedge nrst)
  if (~nrst)
    timeout_reg <= 0 ;
  else if (start)
    timeout_reg <= 0 ;
  else if (in_dec)
  begin
    if (~timeout)
      timeout_reg <= timeout_reg +1 ;
  end    
  
assign timeout_pls = ~timeout_s1 & timeout ;
always @(posedge clk or negedge nrst)
  if (~nrst)
    timeout_s1 <= 1'b0 ;
  else
    timeout_s1 <= timeout ;  
      
endmodule

//********************************************************************************
// File:    decoder_system.v
// Author:  Yang Sun (ysun@rice.edu)
// Birth:   $ 11/25/07
// Des:     decoder system
// History: $ 11/25/07, Uncoded decoder
//          $ 12/1/07, Added Viterbi decoder (VBD)
//          $ 09/27/08: Added dec-puncture 
//********************************************************************************
module decoder_system (
        clk             ,   // I, clock
        nrst            ,   // I, n reset
        start           ,   // I, start pulse
        in_dec          ,
        coding_en       ,
        zero_tail       ,
        sym_start       ,   // I, sym start
        hdr_mod_level   ,   // I, header modulation level
        vin             ,   // I, data valid input
        llr_a           ,   // I, LLR bit a
        llr_b           ,   // I, LLR bit b
        llr_buf_empty   ,   // I, LLR buffer empty
        unc_buf_rd      ,   // O, LLR buffer read by unc
        vout            ,   // O, data valid output
        dout            ,   // O, byte data output
        nbyte           ,   // O, num of bytes
        byte_cnt        ,   // O, byte cnt
        cc_rate         ,   // O, code rate
        data_coded      ,   // O, coded system
        in_fullrate         // O, in full rate
        ) ;
        
input                   clk ;
input                   start ;
input                   in_dec ;
input                   coding_en ;
input                   zero_tail ;
input                   sym_start ;
input       [3:0]       hdr_mod_level ;
input                   nrst ;
input                   vin ;
input       [3:0]       llr_a ;
input       [3:0]       llr_b ;
input                   llr_buf_empty ;
                    
output                  unc_buf_rd ;                    
output                  vout ;
output      [7:0]       dout ;

output      [13:0]      nbyte ;
output reg  [13:0]      byte_cnt ;
output      [1:0]       cc_rate ;
output                  data_coded ;
output                  in_fullrate ;

//==============================
//Internal signal
//==============================
wire            hd_a ;
wire            hd_b ;
wire            unc_vout ;
wire    [7:0]   unc_byte_out ;
wire            unc_vin ;

wire            ld_mod_type ;
wire            ld_payload_lsb ;
wire            ld_payload_msb ;
reg             ld_payload ;
wire            ld_rate ;
reg             update_mod_type ;

wire    [13:0]  num_payload_i ;
reg     [13:0]  num_payload ;
reg     [7:0]   num_payload_low ;
reg     [7:0]   num_payload_high ;

reg     [16:0]  bit_cnt ;  
wire            input_done ;
reg             input_done_s0 ;
wire            pkt_end ;

wire    [3:0]   vb_b1 ;
wire    [3:0]   vb_b0 ;
wire            vb_vin ;
wire            vb_vout ;
wire    [7:0]   vb_dout ;
wire            vb_done ;

wire    [7:0]   dec_byte ;
wire            dec_val ;

wire    [4:0]   descramb_addr ;
wire    [7:0]   descramb_data ;

reg     [3:0]   mod_type_i ;
wire    [13:0]  input_byte_cnt ;

reg     [3:0]   sym_cnt ;

wire            vb_start ;
wire            vb_end ;

reg     [1:0]   cc_rate_i ;
reg             in_baserate ;
reg             data_coded_i ;
wire            dout_sel ;

//==============================
// Main body of code
//==============================
assign nbyte = num_payload ;
assign vout = dec_val ;
assign dout = dec_byte ;

assign data_coded = data_coded_i ;

assign hd_a = llr_a [3] ;
assign hd_b = llr_b [3] ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
    sym_cnt <= 0 ;
  else if (start)
    sym_cnt <= 0 ;
  else if (sym_start)
    sym_cnt <= (sym_cnt == 9 ? sym_cnt : sym_cnt +1) ;

//?? assign unc_vin = in_fullrate & ~llr_buf_empty & ~data_coded ;

assign unc_vin = coding_en ? (in_fullrate & ~llr_buf_empty & ~data_coded) : (in_dec & ~llr_buf_empty) ;
assign unc_buf_rd =  coding_en ? (unc_vin & ~data_coded) : unc_vin ;
//=====================================
// uncodede decoder
//=====================================
unc_decoder unc_decoder (
        .clk    (clk            ),   // clock
        .nrst   (nrst           ),   // n reset        
        .hd_a   (hd_a           ),   // hard decision of I
        .hd_b   (hd_b           ),   // hard decision of Q
        .start  (start          ),   // start decoding pulse
        .vin    (unc_vin        ),   // valid input
        .vout   (unc_vout       ),   // valid output
        .dout   (unc_byte_out   )    // byte out
        ) ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
    bit_cnt <= 0 ;
  else if (start)
    bit_cnt <= 0 ;
  else if (vin)
    bit_cnt <= bit_cnt +2 ;

assign input_byte_cnt = bit_cnt [16:3] ;
assign input_done = (bit_cnt [16:4] == (data_coded_i ? num_payload : 24)) ; 
always @ (posedge clk)
  input_done_s0 <= input_done ;
assign pkt_end = input_done & ~input_done_s0 ;

assign vb_vin = vin ;
assign vb_b1 = llr_a ;
assign vb_b0 = llr_b ;

//======================================================
// Viter decoder system
//======================================================
vb_decoder_top vb_decoder_top (
        .clk            (clk            ),  //I 
        .nrst           (nrst           ),  //I 
        .packet_start   (vb_start       ),  //I 
        .zero_tail      (zero_tail      ),
        .packet_end     (vb_end         ),  //I
        .vin            (vb_vin         ),  //I 
        .llr_b1         (vb_b1          ),  //I 
        .llr_b0         (vb_b0          ),  //I
        .vout           (vb_vout        ),  //O
        .done           (vb_done        ),  //O
        .dout_in_byte   (vb_dout        )   //O
        ) ;


// Select
assign dout_sel = (in_baserate | data_coded) & coding_en ;

assign dec_byte = dout_sel ? vb_dout : unc_byte_out ;
assign dec_val =  dout_sel ? vb_vout : unc_vout ;

assign descramb_addr = byte_cnt [4:0] ;
//===================================
// de-scrambler 
//===================================
scrambler descrambler (
        .addr       (descramb_addr  ),   // address 32
        .din        (dec_byte       ),   // byte in
        .dout       (descramb_data  )    // byte out
        ) ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
    byte_cnt <= 0 ;
  else if (start)
    byte_cnt <= 0 ;
  else if (dec_val)
    byte_cnt <= byte_cnt +1 ;

assign ld_mod_type = dec_val & (byte_cnt == 0) ;
assign ld_payload_msb = byte_cnt == 2 ;
assign ld_payload_lsb = byte_cnt == 3 ;
assign ld_rate = byte_cnt == 1 ;

always @*
begin
  update_mod_type = 1'b0 ;  
  if(sym_start)
  begin
    if(coding_en)
      case(hdr_mod_level)
        4'd1: update_mod_type = (sym_cnt == 8) ;
        4'd2: update_mod_type = (sym_cnt == 4) ;
        4'd4: update_mod_type = (sym_cnt == 2) ;
      endcase
    else
      case(hdr_mod_level)
        4'd1: update_mod_type = (sym_cnt == 4) ;
        4'd2: update_mod_type = (sym_cnt == 2) ;
        4'd4: update_mod_type = (sym_cnt == 1) ;
      endcase          
  end
end

// Header is always not punctured
assign cc_rate = coding_en ? (in_baserate ? 2'd0 : cc_rate_i) : 2'd0 ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
  begin
    num_payload_low <= 64 ;
    num_payload_high <= 0 ;
    cc_rate_i <= 0 ;
    data_coded_i <= 1'b1 ;
  end
  else if (start)
  begin
    num_payload_low <= 64 ;
    num_payload_high <= 0 ;
    cc_rate_i <= 0 ;
    data_coded_i <= 1'b1 ;
  end
  else if (dec_val)
  begin
    if (ld_payload_lsb)
      num_payload_low <= descramb_data ;
    if (ld_payload_msb)
      num_payload_high <= descramb_data ;
    if (ld_rate)
    begin
      cc_rate_i <= descramb_data[1:0] ;
      data_coded_i <= (descramb_data[1:0] != 2'b11) ;
    end
  end  

always @ (posedge clk)
  ld_payload <= ld_payload_lsb ;
  
assign num_payload_i = {num_payload_high [5:0], num_payload_low} ;
always @ (posedge clk or negedge nrst)
  if (~nrst)
    num_payload <= 64 ;
  else if (start)
    num_payload <= 64 ;
  else if (ld_payload)
    num_payload <= num_payload_i ;  

always @ (posedge clk or negedge nrst)
  if (~nrst)
    mod_type_i <= 2 ;
  else if (start)
    mod_type_i <= 2 ;
  else if (ld_mod_type)
    mod_type_i <= descramb_data [3:0] ;

assign in_fullrate = ~in_baserate ;
always @ (posedge clk or negedge nrst)
  if (~nrst)
    in_baserate <= 1'b1 ;
  else if (start)
    in_baserate <= 1'b1 ;
  else if (update_mod_type)
    in_baserate <= 1'b0 ;

assign vb_start = start ;
assign vb_end = pkt_end ;

endmodule

//**************************************************************
// File:    depunc.v
// Author:  Yang Sun (ysun@rice.edu)
// Created: $ 2/4/07
// Des:     viterbi decoder system
// History: $ 02/04/07, Support puncture 2/3, 3/4
//          $ 09/27/08: updated
//**************************************************************
module depunc (
        clk         , 
        nrst        , 
        start       , 
        dav         ,   // I, data available
        din         , 
        vout        , 
        dout_a      , 
        dout_b      , 
        buf_rd      , 
        rate            // 0 = 1/2, 1 = 2/3, 2 = 3/4
        ) ;
        
parameter           SW = 4 ;        // soft input precision

input               clk ;
input               nrst ;
input               start ;
input               dav ;
input   [SW*2 -1:0] din ;
input   [1:0]       rate ;
output              vout ;
output  [SW -1:0]   dout_a ;
output  [SW -1:0]   dout_b ;
output              buf_rd ;

//=================================================
//Internal signal
//=================================================
reg     [1:0]               cnt ;

wire                        rd ;
wire                        rd_r12 ;
wire                        rd_r34 ;
wire                        rd_r23 ;
wire                        r23_ext ;
reg                         r23_ext_s0 ;
wire                        r34_ext ;

reg     [SW -1:0]           app_i_r34 ; 
reg     [SW -1:0]           app_q_r34 ;
reg     [SW -1:0]           app_i_r23 ; 
reg     [SW -1:0]           app_q_r23 ;
wire    [SW -1:0]           app_i_r12 ; 
wire    [SW -1:0]           app_q_r12 ;
wire    [SW -1:0]           app_i_mux ; 
wire    [SW -1:0]           app_q_mux ;
wire                        app_valid ;
wire    [SW*2 -1:0]         iq_data_buf ;
reg     [SW*2 -1:0]         iq_data_buf_lat ;

//=================================================
// Main RTL
//=================================================
assign buf_rd = rd ;
assign dout_a = app_i_mux ;
assign dout_b = app_q_mux ;
assign vout = app_valid ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
    cnt <= 0 ;
  else if (start)
    cnt <= 0 ;
  else if (dav)
  begin
    if (rate == 1)
      cnt <= cnt + 1 ;  
    else if (rate ==2)
      cnt <= (cnt == 2 ? 0 : cnt +1) ;    
  end

// for rate = 1/2
assign rd_r12 = dav ;

// for rate = 2/3
assign r23_ext = cnt == 3 ;
always @ (posedge clk)
  r23_ext_s0 <= r23_ext ;

assign r23_ext_p = ~r23_ext_s0 & r23_ext ;
assign rd_r23 = dav & ~r23_ext ; 

// for rate = 3/4
assign rd_r34 = dav & (cnt != 2) ; 
assign r34_ext = dav & (cnt == 2) ;

// mux
assign rd = rate == 0 ? rd_r12 : rate == 1 ? rd_r23 : rd_r34 ;

assign iq_data_buf = din ;
always @ (posedge clk)
  if (rd)
    iq_data_buf_lat <= iq_data_buf ;

// rate = 2/3
always @*
begin
  app_i_r23 = 0 ;
  app_q_r23 = 0 ;
  case (cnt)
  0: begin
    app_i_r23 = iq_data_buf [SW*2 -1 : SW] ;
    app_q_r23 = iq_data_buf [SW -1: 0] ;
  end
  1: begin
    app_i_r23 = iq_data_buf [SW*2 -1 : SW] ;
    app_q_r23 = 0 ;
  end
  2: begin
    app_i_r23 = iq_data_buf_lat [SW -1: 0] ;
    app_q_r23 = iq_data_buf [SW*2 -1 : SW] ;
  end
  3: begin
    app_i_r23 = iq_data_buf_lat [SW -1: 0] ;
    app_q_r23 = 0 ;
  end  
  endcase
end

// rate = 3/4
always @*
begin
  app_i_r34 = 0 ;
  app_q_r34 = 0 ;
  case (cnt)
  0: begin
    app_i_r34 = iq_data_buf [SW*2 -1 : SW] ;
    app_q_r34 = iq_data_buf [SW -1: 0] ;
  end
  1: begin
    app_i_r34 = iq_data_buf [SW*2 -1 : SW] ;
    app_q_r34 = 0 ;
  end
  2: begin
    app_i_r34 = 0 ;
    app_q_r34 = iq_data_buf_lat [SW -1: 0] ;
  end
  default: begin
    app_i_r34 = 0 ;
    app_q_r34 = 0 ;
  end  
  endcase
end

// rate = 1/2
assign app_i_r12 = iq_data_buf [SW*2 -1 : SW] ;
assign app_q_r12 = iq_data_buf [SW -1: 0] ;

assign app_i_mux = rate == 0 ? app_i_r12 : rate == 1 ? app_i_r23 : app_i_r34 ;
assign app_q_mux = rate == 0 ? app_q_r12 : rate == 1 ? app_q_r23 : app_q_r34 ;

assign app_valid = rate == 0 ? rd_r12 : rate == 1 ? (rd_r23 | r23_ext_p) : (rd_r34 | r34_ext) ;

endmodule



//*********************************************************
// File:    fifo_16x8.v
// Author:  Y. Sun
// Des:     16x8 FIFO
//*********************************************************
module fifo_16x8 (
    clk         ,   // I, clock
    nrst        ,   // I, async reset
    reset       ,   // I, sync reset
    wdata       ,   // I, write data
    wr          ,   // I, write enable
    rd          ,   // I, read enable
    rdata       ,   // O, read data
    empty       ,   // O, empty
    full            // O, full
    ) ;

parameter           WIDTH = 8 ;
parameter           DEPTH = 16 ;
parameter           ADDR_BITS = 4 ;

input               clk ;
input               nrst ;
input               reset ;
input   [WIDTH-1:0] wdata ;
input               wr ;
input               rd ;
output  [WIDTH-1:0] rdata ;
output              empty ;
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


always @ (posedge clk or negedge nrst)
  if(~nrst)
    cnt <= 0 ; 
  else
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
  else
  begin
    if (reset)
      waddr <= 0 ;
    else if (wr)
      waddr <= waddr == DEPTH -1 ? 0 : waddr +1 ;
  end
    
always @ (posedge clk or negedge nrst)
  if(~nrst)
    raddr <= 0 ;
  else
  begin
    if (reset)
      raddr <= 0 ;
    else if (rd)
      raddr <= raddr == DEPTH -1 ? 0 : raddr +1 ;   
  end 

always @ (posedge clk)
    if (wr)
      mem [waddr] <= wdata ;

assign rdata = mem [raddr] ;

endmodule

//**************************************************************
// File:    llr_buffer.v
// Author:  Yang Sun (ysun@rice.edu)
// Created: $ 2/4/07
// Des:     Buffer IQ data for viterbi decoder
// History: $ 09/27/07 :updated
//**************************************************************
module llr_buffer (
        clk     , 
        nrst    , 
        reset   , 
        din     , 
        dout    , 
        wr      , 
        rd      , 
        empty   , 
        full
        ) ;

parameter               DEPTH = 256 ;   // 128 slots
parameter               ADDRW = 8 ; 
parameter               SW = 4 ;        
        
input                   clk ;       // system clock 
input                   nrst ;
input                   reset ;
input   [SW*2 -1:0]     din ;       
input                   wr ;
input                   rd ;
output  [SW*2 -1:0]     dout ;
output                  empty ;
output                  full ;

//==============================================
// Internal signal
//==============================================
reg     [SW*2 -1:0]     mem [DEPTH -1:0] ;
wire    [SW*2 -1:0]     data ;

reg     [ADDRW :0]      waddr ;
reg     [ADDRW :0]      raddr ;
wire    [ADDRW -1:0]    waddr_i ;
wire    [ADDRW -1:0]    raddr_i ;

//==============================================
// Main RTL
//==============================================
assign dout = data ;
assign waddr_i = waddr [ADDRW -1 : 0] ;
assign raddr_i = raddr [ADDRW -1 : 0] ;
assign empty = (waddr [ADDRW] ~^ raddr [ADDRW]) & (waddr_i == raddr_i) ;
assign full = (waddr [ADDRW] ^ raddr [ADDRW]) & (waddr_i == raddr_i) ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
    waddr <= 0 ;
  else if (reset)
    waddr <= 0 ;
  else if (wr)
    waddr <= waddr + 1 ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
    raddr <= 0 ;
  else if (reset)
    raddr <= 0 ;
  else if (rd)
    raddr <= raddr + 1 ;

always @ (posedge clk)
  if (wr)
    mem [waddr_i] <= din ;
    
assign data = mem [raddr_i] ;


endmodule

//**************************************************************
// File:    max_metric_logic.v
// Author:  Yang Sun (ysun@rice.edu)
// Birth:   $ 1/14/07
// Des:     The top level of viterbi decoder
//          Take 5 bit soft value is [-16 : +15]
//          K = 7. g0 = 133, g1 = 171
// History: $ 1/14/07, Init coding
//          $ 1/22/07, K = 5, Zero latency
//          $ 12/1/07: Updated
//**************************************************************
module max_metric_logic (
    a       ,   // I, metric a
    b       ,   // I, metric b
    c       ,   // I, metric c
    d       ,   // I, metric d
    sa      ,   // I, state a
    sb      ,   // I, state b
    sc      ,   // I, state c
    sd      ,   // I, state d
    state   ,   // O, state
    max         // O, max metric
    ) ;
    
parameter   M = 7 ;
parameter   K = 7 ;

input   [M -1:0]    a ;
input   [M -1:0]    b ;
input   [M -1:0]    c ;
input   [M -1:0]    d ;

input   [K -2:0]    sa ;
input   [K -2:0]    sb ;
input   [K -2:0]    sc ;
input   [K -2:0]    sd ;

output  [K -2:0]    state ;
output  [M -1:0]    max ;

//==================================
//Internal signal
//==================================

reg     [K -2:0]    pos0 ;
reg     [K -2:0]    pos1 ;
reg     [M -1:0]    max0 ;
reg     [M -1:0]    max1 ;
reg     [M -1:0]    tmp ;
reg     [K -2:0]    state_i ;
reg     [M -1:0]    max_i ;

//==================================
// Main body of code
//==================================
assign state = state_i ;
assign max = max_i ;

always @*
begin  
  tmp = a-b ;
  if(~tmp[M -1])
  begin
    max0 = a ;
    pos0 = sa ;
  end
  else
  begin
    max0 = b ;
    pos0 = sb ;
  end

  tmp = c-d ;
  if(~tmp[M-1])
  begin
    max1 = c ;
    pos1 = sc ;
  end
  else
  begin
    max1 = d ;
    pos1 = sd ;
  end

  tmp = max0 - max1 ;
  if (~tmp[M-1])
  begin
    max_i = max0 ;
    state_i = pos0 ;
  end
  else
  begin
    state_i = pos1 ;
    max_i = max1 ;
  end
end

endmodule

//**************************************************************
// File:    max_metric
// Author:  Yang Sun (ysun@rice.edu)
// Birth:   $ 1/14/07
// Des:     Find max metric
//          K = 7. g0 = 133, g1 = 171
// History: $ 1/14/07, Init coding
//          $ 1/22/07, K = 5
//          $ 2/23/07, 1 pipeline
//          $ 12/1/07: updated
//**************************************************************
module max_metric (
    clk     ,   // I, clock
    a       ,   // I, metric a
    b       ,   // I, metric b
    c       ,   // I, metric c
    d       ,   // I, metric d
    sa      ,   // I, state a
    sb      ,   // I, state b
    sc      ,   // I, state c
    sd      ,   // I, state d
    state   ,   // O, state
    max         // O, max metric
    ) ;

parameter   M = 7 ;
parameter   K = 7 ;

input               clk ;
input   [M -1:0]    a ;
input   [M -1:0]    b ;
input   [M -1:0]    c ;
input   [M -1:0]    d ;

input   [K -2:0]    sa ;
input   [K -2:0]    sb ;
input   [K -2:0]    sc ;
input   [K -2:0]    sd ;

output  [K -2:0]    state ;
output  [M -1:0]    max ;

//=====================================
//Internal signal
//=====================================
reg     [K -2:0]    pos0 ;
reg     [K -2:0]    pos1 ;
reg     [M -1:0]    max0 ;
reg     [M -1:0]    max1 ;
reg     [M -1:0]    tmp ;
reg     [K -2:0]    state_i ;
reg     [M -1:0]    max_i ;
reg     [K -2:0]    state_reg ;
reg     [M -1:0]    max_reg ;

//=====================================
// Main RTL code
//=====================================
assign state = state_reg ;
assign max = max_reg ;

always @ (posedge clk)
begin
  state_reg <= state_i ;
  max_reg <= max_i ;
end

always @*
begin  
  tmp = a-b ;
  if(~tmp[M -1])
  begin
    max0 = a ;
    pos0 = sa ;
  end
  else
  begin
    max0 = b ;
    pos0 = sb ;
  end

  tmp = c-d ;
  if(~tmp[M-1])
  begin
    max1 = c ;
    pos1 = sc ;
  end
  else
  begin
    max1 = d ;
    pos1 = sd ;
  end

  tmp = max0 - max1 ;
  if (~tmp[M-1])
  begin
    max_i = max0 ;
    state_i = pos0 ;
  end
  else
  begin
    state_i = pos1 ;
    max_i = max1 ;
  end
end

endmodule

//*********************************************************
// File:    out_ctrl
// Author:  Y. Sun
// Des:     Convert the outputs into clk/2 domain
//          I have to convert the output into clk/2 domain
//          coz the downstream block takes clk/2 signals
//*********************************************************
module out_ctrl (
    clk     ,   // I, clock
    nrst    ,   // I, async reset
    start   ,   // I, start
    vin     ,   // I, write enable
    din     ,   // I, write data
    vout    ,   // O, read enable
    dout    ,   // O, read data
    idx_out     // O, out index
    ) ;

input           clk ;
input           nrst ;
input           start ;
input           vin ;
input   [7:0]   din ;
output          vout ;
output  [7:0]   dout ;
output  [13:0]  idx_out ;

reg             en ;
wire            ff_empty ;
wire            ff_rd ;
wire    [7:0]   ff_rdata ;
reg     [7:0]   data_lat ;
reg             ff_rd_d ;
reg             ff_rd_dd ;
reg     [13:0]  cnt ;

//============================
// Main RTL Code
//============================
assign vout = ff_rd_d | ff_rd_dd ;
assign dout = data_lat ;
assign idx_out = cnt ;

always @(posedge clk or negedge nrst)
  if(~nrst)
    en <= 1'b1 ;
  else if (start)
    en <= 1'b1 ;
  else
    en <= ~en ;

assign ff_rd = ~ff_empty & en ;

fifo_16x8 fifo_16x8 (
    .clk    (clk        ),
    .nrst   (nrst       ),
    .reset  (start      ),
    .wr     (vin        ),
    .wdata  (din        ),
    .rd     (ff_rd      ),
    .rdata  (ff_rdata   ),
    .empty  (ff_empty   ),
    .full   (           )
    ) ;

always @(posedge clk or negedge nrst)
  if(~nrst)
    data_lat <= 0 ;
  else if (ff_rd)
    data_lat <= ff_rdata ;

always @(posedge clk or negedge nrst)
  if(~nrst)
  begin
    ff_rd_d <= 1'b0 ;
    ff_rd_dd <= 1'b0 ;
  end
  else if (start)
  begin
    ff_rd_dd <= 1'b0 ;
    ff_rd_d <= 1'b0 ;
  end
  else
  begin
    ff_rd_dd <= ff_rd_d ;
    ff_rd_d <= ff_rd ;
  end
  
always @(posedge clk or negedge nrst)
  if(~nrst)
    cnt <= 0 ;
  else if (start)      
    cnt <= 0 ;
  else if (ff_rd_dd)
    cnt <= cnt +1 ;
  

endmodule


//********************************************************************************
// Module:  round_data.v
// Author:  Yang Sun (ysun@rice.edu)
// Birth:   $ 4/29/07
// Des:     Round with 1 latency
// History: $ 4/29/07, Init coding
//          $ 05/04/08: Fixed a bug
//********************************************************************************
module round_data (
        clk, din, dout             
        ) ;

input                   clk ;
input       [12:0]      din ;
output reg  [3:0]       dout ;

//=====================================
//Internal signal
//=====================================
reg     [3:0]       tmp ;

//=====================================
// Main body of code
//=====================================

always @ (posedge clk)
  dout <= tmp ;

always @*
begin
  if ((~din[12]) && (din[11:10] != 2'b00))
    tmp = 4'b0111 ;
  else if (din[12] && (din[11:10] != 2'b11))
    tmp = 4'b1000 ;
  else if (din[12:10] == 3'b000)  // positive
  begin
    if ((din[9:7] != 3'b111) & din[6])
      tmp = din[10:7] +1 ;
    else
      tmp = din[10:7] ;
  end
  else                  // negtive
  begin
    if ((din[9:7] != 3'b000) & din[6])
      tmp = din[10:7] +1 ;
    else
      tmp = din[10:7] ;
  end  
end

endmodule
//********************************************************************************
// File:    scrambler.v
// Author:  Yang Sun (ysun@rice.edu)
// Des:     byte scrambler
// History: $ 12/1/07, Created
//********************************************************************************
`ifndef INCLUDE_SCRAMBLER
`define INCLUDE_SCRAMBLER
module scrambler (
        addr        ,   // address 32
        din         ,   // byte in
        dout            // byte out
        ) ;

input   [4:0]   addr ;
input   [7:0]   din ;
output  [7:0]   dout ;

//==============================
//Internal signal
//==============================
reg     [7:0]   scram_mask ;

//==============================
// Main RTL code
//==============================  
assign dout = din ^ scram_mask ;

always @*
  begin
    case (addr[4:0])
      0: scram_mask = 40 ;
      1: scram_mask = 198 ;
      2: scram_mask = 78 ; 
      3: scram_mask = 63 ; 
      4: scram_mask = 82 ; 
      5: scram_mask = 173 ;
      6: scram_mask = 102 ; 
      7: scram_mask = 245 ; 
      8: scram_mask = 48 ; 
      9: scram_mask = 111 ; 
      10: scram_mask = 172 ; 
      11: scram_mask = 115 ; 
      12: scram_mask = 147 ; 
      13: scram_mask = 230 ; 
      14: scram_mask = 216 ; 
      15: scram_mask = 93 ; 
      16: scram_mask = 72 ; 
      17: scram_mask = 65 ; 
      18: scram_mask = 62 ;
      19: scram_mask = 2 ;
      20: scram_mask = 205 ; 
      21: scram_mask = 242 ;
      22: scram_mask = 122 ;
      23: scram_mask = 90 ;
      24: scram_mask = 128 ;
      25: scram_mask = 83 ;
      26: scram_mask = 105 ;
      27: scram_mask = 97 ;
      28: scram_mask = 73 ; 
      29: scram_mask = 10 ;
      30: scram_mask = 5 ;
      31: scram_mask = 252 ;
      default: scram_mask = 40 ;
    endcase
  end

endmodule
`endif

//********************************************************************************
// Module:      Multiplier
// Author:      Yang Sun (ysun@rice.edu)
// Birth:       $ 4/29/07
// Description: Mult with 1 latency
// History:     $ 4/29/07, Init coding
//********************************************************************************
module smult (
        clk, a_in, b_in, p_out             
        ) ;

parameter               AWID = 8 ;
parameter               BWID = 5 ;
parameter               PWID = AWID + BWID ;
        
input                   clk ;
input   [AWID -1:0]     a_in ;
input   [BWID -1:0]     b_in ;
output  [PWID -1:0]     p_out ;

//***********************************************
//Internal signal
//***********************************************
wire    [AWID -1:0]     a_tmp ;
wire                    a_sgn ;
reg                     a_sgn_pipe ;
reg     [PWID -1:0]     p_tmp ;
wire    [PWID -1:0]     p_tmp2 ;
//***********************************************
// Main body of code
//***********************************************
assign p_out = p_tmp2 ;
assign a_tmp = a_sgn ? ~a_in +1 : a_in ;
assign a_sgn = a_in [AWID -1] ;

always @ (posedge clk)
  p_tmp <= a_tmp * b_in ;

always @ (posedge clk)
  a_sgn_pipe <= a_sgn ;


assign p_tmp2 = a_sgn_pipe ? ~p_tmp +1 : p_tmp ;

endmodule

//********************************************************************************
// File:    soft_demapper.v
// Author:  Yang Sun (ysun@rice.edu)
// Birth:   $ 4/29/07
// Des:     Produce soft LLR for I/Q
// History: $ 4/29/07: Init coding
//          $ 4/17/08: Added 16-QAM support
//********************************************************************************
module soft_demapper (
        clk             , 
        nrst            ,
        start           , 
        coding_en       ,
        mod_level       , 
        vin             , 
        xk_index        , 
        rx_i            , 
        rx_q            ,  
        scale_qpsk      ,
        scale_16qam     ,
        soft_decoding   ,
        in_fullrate     ,
        sym_start       , 
        hdr_mod_level   ,
        vout            , 
        llr_a           , 
        llr_b           
        ) ;
        
input           clk ;
input           nrst ;
input           start ;
input           coding_en ;
input   [3:0]   mod_level ;     // 0=Invalid, 1=BPSK, 2=QPSK, 4=16-QAM
input           vin ;           // valid input
input   [5:0]   xk_index ;      // FFT index
input   [15:0]  rx_i ;          // FIX_16_15
input   [15:0]  rx_q ;          // FIX_16_15
input   [3:0]   scale_qpsk ;    // 0~15 sclae factor
input   [4:0]   scale_16qam ;   // 0~31 sclae factor
input           soft_decoding ;
input           in_fullrate ;   

output          sym_start ;
output  [3:0]   hdr_mod_level ;
output          vout ;
output  [3:0]   llr_a ;
output  [3:0]   llr_b ;  
 

//================================================
//Internal signal
//================================================
wire            mod_vld ;
reg             mod_vld_d ;
reg             mod_vld_dd ;
reg             mod_vld_ddd ;
wire            llr_vld ;
wire    [7:0]   recv_fix_8_7 ;
wire    [12:0]  soft_a_mult ;
wire    [12:0]  soft_b_mult ;
wire    [3:0]   soft_a_round ;
wire    [3:0]   soft_b_round ;

reg     [7:0]   rx_q_d ;
reg     [7:0]   rx_i_d ;

wire    [7:0]   soft_a ;
reg     [7:0]   soft_b ;

reg     [3:0]   hard_a ;
reg     [3:0]   hard_b ;

reg     [3:0]   hard_a_s0 ;
reg     [3:0]   hard_b_s0 ;
wire    [8:0]   abs_tmp ;
wire    [7:0]   abs_tmp_sat ;

wire    [4:0]   llr_scale ;

reg     [7:0]   input_cnt ;
reg             bpsk_sel ;
wire            mod_ld ;
reg     [3:0]   mod_level_lat ; 
wire    [3:0]   mod_type ; 
wire            bpsk ;
wire            qpsk ;
wire            qam16 ;
reg             first_sym ;
reg             first_sym_d ;
reg             first_sym_dd ;
reg     [3:0]   hdr_mod_level_lat ;

//================================================
// Main body of code
//================================================
assign llr_a = (soft_decoding & coding_en) ? soft_a_round : hard_a_s0 ;
assign llr_b = (soft_decoding & coding_en) ? soft_b_round : hard_b_s0 ;
assign vout = llr_vld ;
assign sym_start = vin & (xk_index == 0) ;


assign hdr_mod_level = hdr_mod_level_lat ;

// 16-QAM
always @ (posedge clk or negedge nrst)
  if(~nrst)
    rx_q_d <= 0 ;
  else if (vin)
    rx_q_d <= rx_q [15:8] ;

// BPSK
always @ (posedge clk or negedge nrst)
  if(~nrst)
    rx_i_d <= 0 ;
  else if (mod_vld_d)
    rx_i_d <= rx_i [15:8] ;

assign mod_ld = vin & (xk_index == 1) ;
always @ (posedge clk or negedge nrst)
  if(~nrst)
    mod_level_lat <= 2 ;
  else if (mod_ld)
    mod_level_lat <= mod_level ;

assign mod_type = mod_ld ? mod_level : mod_level_lat ;

always @ (posedge clk or negedge nrst)
  if(~nrst)
    first_sym <= 1'b0 ;
  else if (start)
    first_sym <= 1'b1 ;
  else if (sym_start)
    first_sym <= 1'b0 ;

always @ (posedge clk or negedge nrst)
  if(~nrst)
    {first_sym_dd, first_sym_d} <= 2'd0 ;
  else
    {first_sym_dd, first_sym_d} <= {first_sym_d, first_sym} ;


always @ (posedge clk or negedge nrst)
  if(~nrst)
    hdr_mod_level_lat <= 2 ;
  else if (first_sym_dd & (mod_ld))
    hdr_mod_level_lat <= mod_level ;

// Trancate 16_15 to 8_7
//assign recv_fix_8_7 = in_fullrate ? (mod_type == 1 ? rx_i_s0 : (vin ? rx_i [15:8] : rx_q_s0)) : rx_i[15:8] ;    

assign bpsk = (mod_type == 1) ;
assign qpsk = (mod_type == 2) ;
assign qam16 =(mod_type == 4) ;

assign recv_fix_8_7 = bpsk ? rx_i_d : (vin ? rx_i[15:8] : rx_q_d) ;

//assign abs_tmp = recv_fix_8_7 [7] ? -recv_fix_8_7 : recv_fix_8_7 ;
assign abs_tmp = (recv_fix_8_7 ^{8{recv_fix_8_7[7]}}) + recv_fix_8_7[7] ;
assign abs_tmp_sat = abs_tmp[8] ? 8'hff : abs_tmp[7:0] ;

assign soft_a = recv_fix_8_7 ;
assign llr_scale = (bpsk | qpsk) ? scale_qpsk : scale_16qam ;

always @*
begin
  if (bpsk)                         // BPSK
    soft_b = rx_i[15:8] ;
  else if (qpsk)                    // QPSK
    soft_b = rx_q[15:8] ;
  else                              // 16-QAM
    soft_b = 8'b0100_0000 - abs_tmp_sat ;  // 0.5 - |Y|
end
  
always @ (posedge clk or negedge nrst)
  if(~nrst)
  begin
    hard_a <= 1'b0 ;
    hard_b <= 1'b0 ;    
  end
  else
  begin
    hard_a <= soft_a [7] ? 4'hf : 4'h1 ;
    hard_b <= soft_b [7] ? 4'hf : 4'h1 ;
  end  

always @ (posedge clk or negedge nrst)
  if(~nrst)
  begin
    hard_a_s0 <= 1'b0 ;
    hard_b_s0 <= 1'b0 ;  
  end
  else
  begin  
    hard_a_s0 <= hard_a ;
    hard_b_s0 <= hard_b ;  
  end  
  
//================================
// signed MULT
//================================  
smult smult_a (
        .clk        (clk        ),  //I
        .a_in       (soft_a     ),  //I
        .b_in       (llr_scale  ),  //I
        .p_out      (soft_a_mult)   //O             
        ) ;

//================================
// signed MULT
//================================         
smult smult_b (
        .clk        (clk        ),  //I
        .a_in       (soft_b     ),  //I
        .b_in       (llr_scale  ),  //I
        .p_out      (soft_b_mult)   //O             
        ) ;

//================================
// Round
//================================ 
round_data data_i (
        .clk    (clk            ),  //I 
        .din    (soft_a_mult    ),  //I 
        .dout   (soft_a_round   )   //O           
        ) ;

//================================
// Round
//================================         
round_data data_q (
        .clk    (clk            ),  //I 
        .din    (soft_b_mult    ),  //I 
        .dout   (soft_b_round   )   //O           
        ) ;        

//assign mod_pipe = in_fullrate ? (mod_type == 1 ? (mod_s0 & bpsk_sel) : (mod_type == 2 ? mod_s0 : (mod_s0 | mod_s1))) : mod_s0 ;
assign llr_vld = bpsk ? (mod_vld_dd & bpsk_sel) : (qpsk ? mod_vld_dd : (mod_vld_dd | mod_vld_ddd)) ;

assign mod_vld = vin & (mod_level != 0) ;
always @ (posedge clk )
  {mod_vld_ddd, mod_vld_dd,mod_vld_d} <= {mod_vld_dd, mod_vld_d,mod_vld}  ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
    input_cnt <= 0 ;
  else if (start)
    input_cnt <= 0 ;
  else if (llr_vld)
  begin
    if (input_cnt != 192)
      input_cnt <= input_cnt +1 ;
  end

always @ (posedge clk or negedge nrst)
  if (~nrst)
    bpsk_sel <= 1'b0 ;
  else if (start)
    bpsk_sel <= 1'b0 ;
  else if (mod_vld_dd)
      bpsk_sel <= ~bpsk_sel ;

endmodule


//********************************************************************************
// File:    unc_decoder.v
// Author:  Yang Sun (ysun@rice.edu)
// Birth:   $ 12/1/07
// Des:     decoder system
// History: $ 12/1/07, Uncoded decoder
//          $ 10/11/08, added BPSK
//********************************************************************************
module unc_decoder (
        clk     ,   // clock
        nrst    ,   // n reset
        hd_a    ,   // hard decision of a
        hd_b    ,   // hard decision of b
        start   ,   // start decoding pulse
        vin     ,   // valid input
        vout    ,   // valid output
        dout        // byte out
        ) ;

input           clk ;
input           nrst ;
input           hd_a ;
input           hd_b ;
input           start ;
input           vin ;
output          vout ;
output  [7:0]   dout ;        
        
//==============================
//Internal signal
//==============================
reg     [7:2]   tmpd ;
reg     [1:0]   cnt ;   
wire    [1:0]   data_2b ;
        
//==============================
// Main RTL code
//==============================        
assign data_2b = {hd_a, hd_b} ;
always @ (posedge clk or negedge nrst)
  if (~nrst)
    tmpd <= 0 ;
  else if (start)
    tmpd <= 0 ;
  else if (vin)
  begin
    case (cnt)
      3'd0: tmpd [7:6] <= data_2b ;
      3'd1: tmpd [5:4] <= data_2b ;
      3'd2: tmpd [3:2] <= data_2b ;
      default: tmpd <= tmpd ;
    endcase             
  end
  
always @ (posedge clk or negedge nrst)
  if (~nrst)
    cnt <= 0 ;
  else if (start)
    cnt <= 0 ;
  else if (vin)
    cnt <= cnt +1 ;

assign vout = vin & (cnt == 3) ;
assign dout = {tmpd, data_2b} ;  

endmodule  

//**************************************************************
// File:    unpack_m2n.v
// Author:  Yang Sun (ysun@rice.edu)
// Birth:   $ 1/15/07
// Des:     unpack from M bit to N bit, M > N
// History: $ 1/15/07, Init coding
//          $ 1/21/07, K = 7
//          $ 3/23, Fixed a naming problem for sysgen
//                  Can not use VHDL reserved key world
//          $ 12/1/07: Updated
//**************************************************************

module unpack_m2n (
        clk     ,   // I, clock 
        nrst    ,   // I, n reset
        start   ,   // I, start pulse
        din     ,   // I, data input
        vin     ,   // I, valid input
        dout    ,   // O, data output
        vout    ,   // O, valid output
        remain  ,   // I, remain
        last    ,   // I, last data
        done        // O, done
        ) ;

parameter               BITM = 40 ;
parameter               BITN = 8 ;
parameter               LW = 6 ;

input                   clk ;
input                   nrst ;
input                   start ;
input   [BITM-1 :0]     din ;
input                   vin ;
input   [LW -1:0]       remain ;
input                   last ;

output  [BITN-1 :0]     dout ;
output                  vout ;
output                  done ;

//================================================
//Internal signal
//================================================
reg     [BITM + BITN -1 :0]     sreg ;
wire    [BITM + BITN -1 :0]     sreg_next ;
reg     [LW -1 : 0]             cnt ;
wire                            rd ;
wire    [BITN-1 :0]             data ;
wire    [BITM + BITN -1 :0]     tmp ;
wire    [BITM + BITN -1 :0]     tmp2 ;
wire    [LW -1 : 0]             shift ;
reg                             last_i ;
reg                             last_byte_s0 ;
wire                            last_byte ;

//================================================
// Main RTL code
//================================================
assign dout = data ;
assign vout = rd ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
    cnt <= 0 ;
  else if (start)
    cnt <= 0 ;
  else if (vin)
  begin
    if (~last)
      cnt <= cnt + BITM ;
    else
      cnt <= cnt + remain ;
  end
  else if (rd)
    cnt <= cnt - BITN ;
    
assign rd = cnt >= BITN ;
assign data = sreg [BITM + BITN -1 : BITM] ;
assign tmp = {{BITM{1'b0}}, din} ;
assign shift = BITN - cnt ;
assign tmp2 = (tmp << shift) | sreg ;
assign sreg_next = vin ? tmp2 : rd ? {sreg[BITM -1 : 0], {BITN{1'b0}}} : sreg ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
    sreg <= 0 ;
  else if (start)
    sreg <= 0 ;
  else 
    sreg <= sreg_next ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
    last_i <= 1'b0 ;
  else if (start)
    last_i <= 1'b0 ;
  else if (vin & last)
    last_i <= 1'b1 ;

assign last_byte = last_i && cnt < BITN ;
always @ (posedge clk)
  last_byte_s0 <= last_byte ;

assign done = ~last_byte_s0 & last_byte ;

endmodule
//*****************************************************************
// File:    vb_decoder_top.v
// Author:  Yang Sun (ysun@rice.edu)
// Birth:   $ 1/15/07
// Des:     viterbi decoder top level
//          Take 5 bit soft value is [-16 : +15]
//          K = 3. g0 =7, g1 = 5
//          K = 7. g0 = 133, g1 = 171
// History: $ 1/15/07, Init coding
//          $ 1/21/07, K = 7
//          $ 1/27/07, Change to LLR domain
//          $ 2/4/07, Support puncture 2/3, 3/4
//          $ 3/22/07, Remove puncture and iq buffer for WARP
//          $ 3/23/07, Fixed a naming problem for sysgen
//                     Can not use VHDL reserved key world
//          $ 4/20/07, K = 7
//          $ 4/22/07, Change quantilization to -4 ~ 4 9-level
//          $ 12/1/07: Modified for OFDM V7
//*****************************************************************
module vb_decoder_top (
        clk         ,   // I, clock 
        nrst        ,   // I, n reset
        packet_start,   // I, packet start pulse
        packet_end  ,   // I, packet end pulse
        zero_tail   ,   // I, the code is zero terminated
        vin         ,   // I, valid input
        llr_b1      ,   // I, 1st LLR
        llr_b0      ,   // I, 2nd LLR
        vout        ,   // O, valid output
        dout_in_byte,   // O, decoded output in byte
        done            // O, decoding done
        ) ;

parameter           SW = 4 ;        // soft input precision
parameter           M = 7 ;         // Metric precision
parameter           R = 48 ;        // reliable trace
parameter           C = 40 ;        // unreliable trace
parameter           L = 88 ;        // total trace depth
parameter           LW = 7 ;        // L width
parameter           K = 7 ;         // constraint length
parameter           N = 64 ;        // number of states
parameter           TR = 128 ;      // trace buffer depth
parameter           TRW = 7 ;       // trace buffer address width
        
input               clk ;           // system clock
input               nrst ;          // active low reset
input               packet_start ;  // start of packet pulse
input               zero_tail ;     // 1 = the code is terminated with 0, 0 = no termination
input               packet_end ;    // end of packet pulse
input               vin ;           // data valid input
input   [SW -1:0]   llr_b1 ;        // soft value for bit1
input   [SW -1:0]   llr_b0 ;        // soft value for bit0

output              done ;
output              vout ;
output  [7:0]       dout_in_byte ;

//=============================================
//Internal signal
//=============================================
wire    [LW -1:0]           remain ;
wire                        dec_vout ;
wire    [R-1:0]             dec_dout ;
wire                        dec_done ;

//=============================================
// Main RTL code
//=============================================

//================================================================
// Viterbi decoder core logic
//================================================================
viterbi_core #(SW, M, R, C, L, LW, K, N, TR, TRW) viterbi_core (
        .clk            (clk            ),  //IN 
        .nrst           (nrst           ),  //IN 
        .packet_start   (packet_start   ),  //IN 
        .packet_end     (packet_end     ),  //IN
        .zero_tail      (zero_tail      ),
        `ifdef INT_PUNC                     //Internal puncture
        .dv_in          (llr_valid      ),  //IN 
        .llr1           (llr1_depunc    ),  //IN[SW-1:0] 
        .llr0           (llr0_depunc    ),  //IN[SW-1:0]
        `else
        .dv_in          (vin            ),  //IN 
        .llr1           (llr_b1         ),  //IN[SW-1:0] 
        .llr0           (llr_b0         ),  //IN[SW-1:0]        
        `endif
        .remain         (remain         ),  //OUT[LW -1:0]
        .done           (dec_done       ),  //OUT
        .dv_out         (dec_vout       ),  //OUT
        .dout           (dec_dout       )   //OUT[R -1:0]
        ) ;

//=============================================
// x to 8bit unpacking
//=============================================        
unpack_m2n #(R, 8, LW) unpack_Rto8 (
        .clk    (clk            ),  //IN 
        .nrst   (nrst           ),  //IN 
        .start  (packet_start   ),  //IN 
        .din    (dec_dout       ),  //IN[R -1:0]   
        .vin    (dec_vout       ),  //IN 
        .last   (dec_done       ),  //IN
        .remain (remain         ),  //IN[LW -1:0]
        .dout   (dout_in_byte   ),  //OUT
        .vout   (vout           ),  //OUT
        .done   (done           )   //OUT
        ) ;
        
endmodule

//**************************************************************
// File:    viterbi_core
// Author:  Yang Sun (ysun@rice.edu)
// Birth:   $ 1/14/07
// Des:     The top level of viterbi decoder
//          Take 4 bit soft value is [-8 : +7]
//          K = 3. g0 = 7, g1 = 5
//          K = 5, g0 (A) = 1 + x + x^2 + x^4, g1 (B) = 1 + x^3 + x^4
//          K = 7, g0 (A) = 1 + x^2 + x^3 + x^4 + x^5
//                 g1 (B) = 1 + x + x^2 + x^3 + x^6 
// History: $ 1/14/07, Init coding, K = 3
//          $ 1/22/07, K = 5
//          $ 1/26/07, Updated
//          $ 1/27/07, Change to LLR domain
//          $ 2/18/07, Supported K = 7
//          $ 2/23/07, Added pipeline to max_metric
//          $ 12/1/07, Updated
//**************************************************************
//`define ZERO_TERM

module viterbi_core (
        clk         ,   // I, clock
        nrst        ,   // I, n reset
        packet_start,   // I, packet start pulse
        zero_tail   ,   // I, the code is zero terminated
        dv_in       ,   // I, data valid input
        llr0        ,   // I, LLR 2nd
        llr1        ,   // I, LLR 1st
        packet_end  ,   // I, packet end pulse
        dv_out      ,   // O, data valid out
        dout        ,   // O, data out
        done        ,   // O, done pulse
        remain          // O, remain data cnt
        ) ;
        
parameter           SW = 4 ;        // soft input precision
parameter           M = 7 ;         // metric width

parameter           R = 48 ;        // reliable trace
parameter           C = 40 ;        // unreliable trace
parameter           L = 88 ;        // total trace depth
parameter           LW = 7 ;        // L width

parameter           K = 7 ;         // constraint length
parameter           N = 64 ;        // number of states = 2^(K-1)
parameter           TR = 128 ;      // trace buffer
parameter           TRW = 7 ;       // trace

input               clk ;           // system clock
input               nrst ;          // active low reset
input               packet_start ;  // start of packet pulse
input               zero_tail ;     // 1 = the code is terminated with 0, 0 = no termination
input               packet_end ;    // end of packet pulse
input               dv_in ;         // data valid input
input   [SW -1:0]   llr1 ;          // LLR soft value for bit1, LLR = log(Pr(ci=0/ri)/Pr(ci=1/ri))
input   [SW -1:0]   llr0 ;          // LLR soft value for bit0, LLR = log(Pr(ci=0/ri)/Pr(ci=1/ri))

output              done ;
output  [LW -1:0]   remain ;
output              dv_out ;
output  [R-1:0]     dout ;

//======================================
//Internal signal
//======================================
wire    [SW:0]      branch_00 ;
wire    [SW:0]      branch_01 ;
wire    [SW:0]      branch_10 ;
wire    [SW:0]      branch_11 ;

wire    [SW:0]      branch_A_0 ;
wire    [SW:0]      branch_B_0 ;
wire    [SW:0]      branch_A_1 ;
wire    [SW:0]      branch_B_1 ;
wire    [SW:0]      branch_A_2 ;
wire    [SW:0]      branch_B_2 ;
wire    [SW:0]      branch_A_3 ;
wire    [SW:0]      branch_B_3 ;
wire    [SW:0]      branch_A_4 ;
wire    [SW:0]      branch_B_4 ;
wire    [SW:0]      branch_A_5 ;
wire    [SW:0]      branch_B_5 ;
wire    [SW:0]      branch_A_6 ;
wire    [SW:0]      branch_B_6 ;
wire    [SW:0]      branch_A_7 ;
wire    [SW:0]      branch_B_7 ;
wire    [SW:0]      branch_A_8 ;
wire    [SW:0]      branch_B_8 ;
wire    [SW:0]      branch_A_9 ;
wire    [SW:0]      branch_B_9 ;
wire    [SW:0]      branch_A_10 ;
wire    [SW:0]      branch_B_10 ;
wire    [SW:0]      branch_A_11 ;
wire    [SW:0]      branch_B_11 ;
wire    [SW:0]      branch_A_12 ;
wire    [SW:0]      branch_B_12 ;
wire    [SW:0]      branch_A_13 ;
wire    [SW:0]      branch_B_13 ;
wire    [SW:0]      branch_A_14 ;
wire    [SW:0]      branch_B_14 ;
wire    [SW:0]      branch_A_15 ;
wire    [SW:0]      branch_B_15 ;
wire    [SW:0]      branch_A_16 ;
wire    [SW:0]      branch_B_16 ;
wire    [SW:0]      branch_A_17;
wire    [SW:0]      branch_B_17;
wire    [SW:0]      branch_A_18;
wire    [SW:0]      branch_B_18;
wire    [SW:0]      branch_A_19;
wire    [SW:0]      branch_B_19;
wire    [SW:0]      branch_A_20;
wire    [SW:0]      branch_B_20;
wire    [SW:0]      branch_A_21;
wire    [SW:0]      branch_B_21;
wire    [SW:0]      branch_A_22;
wire    [SW:0]      branch_B_22;
wire    [SW:0]      branch_A_23;
wire    [SW:0]      branch_B_23;
wire    [SW:0]      branch_A_24;
wire    [SW:0]      branch_B_24;
wire    [SW:0]      branch_A_25;
wire    [SW:0]      branch_B_25;
wire    [SW:0]      branch_A_26 ;
wire    [SW:0]      branch_B_26 ;
wire    [SW:0]      branch_A_27 ;
wire    [SW:0]      branch_B_27 ;
wire    [SW:0]      branch_A_28 ;
wire    [SW:0]      branch_B_28 ;
wire    [SW:0]      branch_A_29 ;
wire    [SW:0]      branch_B_29 ;
wire    [SW:0]      branch_A_30 ;
wire    [SW:0]      branch_B_30 ;
wire    [SW:0]      branch_A_31 ;
wire    [SW:0]      branch_B_31 ;
wire    [SW:0]      branch_A_32;
wire    [SW:0]      branch_B_32;
wire    [SW:0]      branch_A_33;
wire    [SW:0]      branch_B_33;
wire    [SW:0]      branch_A_34;
wire    [SW:0]      branch_B_34;
wire    [SW:0]      branch_A_35;
wire    [SW:0]      branch_B_35;
wire    [SW:0]      branch_A_36;
wire    [SW:0]      branch_B_36;
wire    [SW:0]      branch_A_37;
wire    [SW:0]      branch_B_37;
wire    [SW:0]      branch_A_38;
wire    [SW:0]      branch_B_38;
wire    [SW:0]      branch_A_39;
wire    [SW:0]      branch_B_39;
wire    [SW:0]      branch_A_40;
wire    [SW:0]      branch_B_40;
wire    [SW:0]      branch_A_41;
wire    [SW:0]      branch_B_41;
wire    [SW:0]      branch_A_42 ;
wire    [SW:0]      branch_B_42 ;
wire    [SW:0]      branch_A_43 ;
wire    [SW:0]      branch_B_43 ;
wire    [SW:0]      branch_A_44 ;
wire    [SW:0]      branch_B_44 ;
wire    [SW:0]      branch_A_45 ;
wire    [SW:0]      branch_B_45 ;
wire    [SW:0]      branch_A_46 ;
wire    [SW:0]      branch_B_46 ;
wire    [SW:0]      branch_A_47 ;
wire    [SW:0]      branch_B_47 ;
wire    [SW:0]      branch_A_48;
wire    [SW:0]      branch_B_48;
wire    [SW:0]      branch_A_49;
wire    [SW:0]      branch_B_49;
wire    [SW:0]      branch_A_50;
wire    [SW:0]      branch_B_50;
wire    [SW:0]      branch_A_51;
wire    [SW:0]      branch_B_51;
wire    [SW:0]      branch_A_52;
wire    [SW:0]      branch_B_52;
wire    [SW:0]      branch_A_53;
wire    [SW:0]      branch_B_53;
wire    [SW:0]      branch_A_54;
wire    [SW:0]      branch_B_54;
wire    [SW:0]      branch_A_55;
wire    [SW:0]      branch_B_55;
wire    [SW:0]      branch_A_56;
wire    [SW:0]      branch_B_56;
wire    [SW:0]      branch_A_57;
wire    [SW:0]      branch_B_57;
wire    [SW:0]      branch_A_58 ;
wire    [SW:0]      branch_B_58 ;
wire    [SW:0]      branch_A_59 ;
wire    [SW:0]      branch_B_59 ;
wire    [SW:0]      branch_A_60 ;
wire    [SW:0]      branch_B_60 ;
wire    [SW:0]      branch_A_61 ;
wire    [SW:0]      branch_B_61 ;
wire    [SW:0]      branch_A_62 ;
wire    [SW:0]      branch_B_62 ;
wire    [SW:0]      branch_A_63 ;
wire    [SW:0]      branch_B_63 ;

reg     [M -1:0]    metric_0 ;
reg     [M -1:0]    metric_1 ;
reg     [M -1:0]    metric_2 ;
reg     [M -1:0]    metric_3 ;
reg     [M -1:0]    metric_4 ;
reg     [M -1:0]    metric_5 ;
reg     [M -1:0]    metric_6 ;
reg     [M -1:0]    metric_7 ;
reg     [M -1:0]    metric_8 ;
reg     [M -1:0]    metric_9 ;
reg     [M -1:0]    metric_10 ;
reg     [M -1:0]    metric_11 ;
reg     [M -1:0]    metric_12 ;
reg     [M -1:0]    metric_13 ;
reg     [M -1:0]    metric_14 ;
reg     [M -1:0]    metric_15 ;
reg     [M -1:0]    metric_16;
reg     [M -1:0]    metric_17;
reg     [M -1:0]    metric_18;
reg     [M -1:0]    metric_19;
reg     [M -1:0]    metric_20;
reg     [M -1:0]    metric_21;
reg     [M -1:0]    metric_22;
reg     [M -1:0]    metric_23;
reg     [M -1:0]    metric_24;
reg     [M -1:0]    metric_25;
reg     [M -1:0]    metric_26 ;
reg     [M -1:0]    metric_27 ;
reg     [M -1:0]    metric_28 ;
reg     [M -1:0]    metric_29 ;
reg     [M -1:0]    metric_30 ;
reg     [M -1:0]    metric_31 ;
reg     [M -1:0]    metric_32;
reg     [M -1:0]    metric_33;
reg     [M -1:0]    metric_34;
reg     [M -1:0]    metric_35;
reg     [M -1:0]    metric_36;
reg     [M -1:0]    metric_37;
reg     [M -1:0]    metric_38;
reg     [M -1:0]    metric_39;
reg     [M -1:0]    metric_40;
reg     [M -1:0]    metric_41;
reg     [M -1:0]    metric_42 ;
reg     [M -1:0]    metric_43 ;
reg     [M -1:0]    metric_44 ;
reg     [M -1:0]    metric_45 ;
reg     [M -1:0]    metric_46 ;
reg     [M -1:0]    metric_47 ;
reg     [M -1:0]    metric_48;
reg     [M -1:0]    metric_49;
reg     [M -1:0]    metric_50;
reg     [M -1:0]    metric_51;
reg     [M -1:0]    metric_52;
reg     [M -1:0]    metric_53;
reg     [M -1:0]    metric_54;
reg     [M -1:0]    metric_55;
reg     [M -1:0]    metric_56;
reg     [M -1:0]    metric_57;
reg     [M -1:0]    metric_58 ;
reg     [M -1:0]    metric_59 ;
reg     [M -1:0]    metric_60 ;
reg     [M -1:0]    metric_61 ;
reg     [M -1:0]    metric_62 ;
reg     [M -1:0]    metric_63 ;

wire    [M -1:0]    metric_next_0 ;
wire    [M -1:0]    metric_next_1 ;
wire    [M -1:0]    metric_next_2 ;
wire    [M -1:0]    metric_next_3 ;
wire    [M -1:0]    metric_next_4 ;
wire    [M -1:0]    metric_next_5 ;
wire    [M -1:0]    metric_next_6 ;
wire    [M -1:0]    metric_next_7 ;
wire    [M -1:0]    metric_next_8 ;
wire    [M -1:0]    metric_next_9 ;
wire    [M -1:0]    metric_next_10 ;
wire    [M -1:0]    metric_next_11 ;
wire    [M -1:0]    metric_next_12 ;
wire    [M -1:0]    metric_next_13 ;
wire    [M -1:0]    metric_next_14 ;
wire    [M -1:0]    metric_next_15 ;
wire    [M -1:0]    metric_next_16;
wire    [M -1:0]    metric_next_17;
wire    [M -1:0]    metric_next_18;
wire    [M -1:0]    metric_next_19;
wire    [M -1:0]    metric_next_20;
wire    [M -1:0]    metric_next_21;
wire    [M -1:0]    metric_next_22;
wire    [M -1:0]    metric_next_23;
wire    [M -1:0]    metric_next_24;
wire    [M -1:0]    metric_next_25;
wire    [M -1:0]    metric_next_26 ;
wire    [M -1:0]    metric_next_27 ;
wire    [M -1:0]    metric_next_28 ;
wire    [M -1:0]    metric_next_29 ;
wire    [M -1:0]    metric_next_30 ;
wire    [M -1:0]    metric_next_31 ;
wire    [M -1:0]    metric_next_32;
wire    [M -1:0]    metric_next_33;
wire    [M -1:0]    metric_next_34;
wire    [M -1:0]    metric_next_35;
wire    [M -1:0]    metric_next_36;
wire    [M -1:0]    metric_next_37;
wire    [M -1:0]    metric_next_38;
wire    [M -1:0]    metric_next_39;
wire    [M -1:0]    metric_next_40;
wire    [M -1:0]    metric_next_41;
wire    [M -1:0]    metric_next_42 ;
wire    [M -1:0]    metric_next_43 ;
wire    [M -1:0]    metric_next_44 ;
wire    [M -1:0]    metric_next_45 ;
wire    [M -1:0]    metric_next_46 ;
wire    [M -1:0]    metric_next_47 ;
wire    [M -1:0]    metric_next_48;
wire    [M -1:0]    metric_next_49;
wire    [M -1:0]    metric_next_50;
wire    [M -1:0]    metric_next_51;
wire    [M -1:0]    metric_next_52;
wire    [M -1:0]    metric_next_53;
wire    [M -1:0]    metric_next_54;
wire    [M -1:0]    metric_next_55;
wire    [M -1:0]    metric_next_56;
wire    [M -1:0]    metric_next_57;
wire    [M -1:0]    metric_next_58 ;
wire    [M -1:0]    metric_next_59 ;
wire    [M -1:0]    metric_next_60 ;
wire    [M -1:0]    metric_next_61 ;
wire    [M -1:0]    metric_next_62 ;
wire    [M -1:0]    metric_next_63 ;

wire    [M -1:0]    metric_A_0 ;
wire    [M -1:0]    metric_B_0 ;
wire    [M -1:0]    metric_A_1 ;
wire    [M -1:0]    metric_B_1 ;
wire    [M -1:0]    metric_A_2 ;
wire    [M -1:0]    metric_B_2 ;
wire    [M -1:0]    metric_A_3 ;
wire    [M -1:0]    metric_B_3 ;
wire    [M -1:0]    metric_A_4 ;
wire    [M -1:0]    metric_B_4 ;
wire    [M -1:0]    metric_A_5 ;
wire    [M -1:0]    metric_B_5 ;
wire    [M -1:0]    metric_A_6 ;
wire    [M -1:0]    metric_B_6 ;
wire    [M -1:0]    metric_A_7 ;
wire    [M -1:0]    metric_B_7 ;
wire    [M -1:0]    metric_A_8 ;
wire    [M -1:0]    metric_B_8 ;
wire    [M -1:0]    metric_A_9 ;
wire    [M -1:0]    metric_B_9 ;
wire    [M -1:0]    metric_A_10 ;
wire    [M -1:0]    metric_B_10 ;
wire    [M -1:0]    metric_A_11 ;
wire    [M -1:0]    metric_B_11 ;
wire    [M -1:0]    metric_A_12 ;
wire    [M -1:0]    metric_B_12 ;
wire    [M -1:0]    metric_A_13 ;
wire    [M -1:0]    metric_B_13 ;
wire    [M -1:0]    metric_A_14 ;
wire    [M -1:0]    metric_B_14 ;
wire    [M -1:0]    metric_A_15 ;
wire    [M -1:0]    metric_B_15 ;
wire    [M -1:0]    metric_A_16;
wire    [M -1:0]    metric_B_16;
wire    [M -1:0]    metric_A_17;
wire    [M -1:0]    metric_B_17;
wire    [M -1:0]    metric_A_18;
wire    [M -1:0]    metric_B_18;
wire    [M -1:0]    metric_A_19;
wire    [M -1:0]    metric_B_19;
wire    [M -1:0]    metric_A_20;
wire    [M -1:0]    metric_B_20;
wire    [M -1:0]    metric_A_21;
wire    [M -1:0]    metric_B_21;
wire    [M -1:0]    metric_A_22;
wire    [M -1:0]    metric_B_22;
wire    [M -1:0]    metric_A_23;
wire    [M -1:0]    metric_B_23;
wire    [M -1:0]    metric_A_24;
wire    [M -1:0]    metric_B_24;
wire    [M -1:0]    metric_A_25;
wire    [M -1:0]    metric_B_25;
wire    [M -1:0]    metric_A_26 ;
wire    [M -1:0]    metric_B_26 ;
wire    [M -1:0]    metric_A_27 ;
wire    [M -1:0]    metric_B_27 ;
wire    [M -1:0]    metric_A_28 ;
wire    [M -1:0]    metric_B_28 ;
wire    [M -1:0]    metric_A_29 ;
wire    [M -1:0]    metric_B_29 ;
wire    [M -1:0]    metric_A_30 ;
wire    [M -1:0]    metric_B_30 ;
wire    [M -1:0]    metric_A_31 ;
wire    [M -1:0]    metric_B_31 ;
wire    [M -1:0]    metric_A_32;
wire    [M -1:0]    metric_B_32;
wire    [M -1:0]    metric_A_33;
wire    [M -1:0]    metric_B_33;
wire    [M -1:0]    metric_A_34;
wire    [M -1:0]    metric_B_34;
wire    [M -1:0]    metric_A_35;
wire    [M -1:0]    metric_B_35;
wire    [M -1:0]    metric_A_36;
wire    [M -1:0]    metric_B_36;
wire    [M -1:0]    metric_A_37;
wire    [M -1:0]    metric_B_37;
wire    [M -1:0]    metric_A_38;
wire    [M -1:0]    metric_B_38;
wire    [M -1:0]    metric_A_39;
wire    [M -1:0]    metric_B_39;
wire    [M -1:0]    metric_A_40;
wire    [M -1:0]    metric_B_40;
wire    [M -1:0]    metric_A_41;
wire    [M -1:0]    metric_B_41;
wire    [M -1:0]    metric_A_42 ;
wire    [M -1:0]    metric_B_42 ;
wire    [M -1:0]    metric_A_43 ;
wire    [M -1:0]    metric_B_43 ;
wire    [M -1:0]    metric_A_44 ;
wire    [M -1:0]    metric_B_44 ;
wire    [M -1:0]    metric_A_45 ;
wire    [M -1:0]    metric_B_45 ;
wire    [M -1:0]    metric_A_46 ;
wire    [M -1:0]    metric_B_46 ;
wire    [M -1:0]    metric_A_47 ;
wire    [M -1:0]    metric_B_47 ;
wire    [M -1:0]    metric_A_48;
wire    [M -1:0]    metric_B_48;
wire    [M -1:0]    metric_A_49;
wire    [M -1:0]    metric_B_49;
wire    [M -1:0]    metric_A_50;
wire    [M -1:0]    metric_B_50;
wire    [M -1:0]    metric_A_51;
wire    [M -1:0]    metric_B_51;
wire    [M -1:0]    metric_A_52;
wire    [M -1:0]    metric_B_52;
wire    [M -1:0]    metric_A_53;
wire    [M -1:0]    metric_B_53;
wire    [M -1:0]    metric_A_54;
wire    [M -1:0]    metric_B_54;
wire    [M -1:0]    metric_A_55;
wire    [M -1:0]    metric_B_55;
wire    [M -1:0]    metric_A_56;
wire    [M -1:0]    metric_B_56;
wire    [M -1:0]    metric_A_57;
wire    [M -1:0]    metric_B_57;
wire    [M -1:0]    metric_A_58 ;
wire    [M -1:0]    metric_B_58 ;
wire    [M -1:0]    metric_A_59 ;
wire    [M -1:0]    metric_B_59 ;
wire    [M -1:0]    metric_A_60 ;
wire    [M -1:0]    metric_B_60 ;
wire    [M -1:0]    metric_A_61 ;
wire    [M -1:0]    metric_B_61 ;
wire    [M -1:0]    metric_A_62 ;
wire    [M -1:0]    metric_B_62 ;
wire    [M -1:0]    metric_A_63 ;
wire    [M -1:0]    metric_B_63 ;
                             
// 64 state tran             
reg     [0:0]       tran_state_0  [TR -1:0] ;
reg     [0:0]       tran_state_1  [TR -1:0] ;
reg     [0:0]       tran_state_2  [TR -1:0] ;
reg     [0:0]       tran_state_3  [TR -1:0] ;
reg     [0:0]       tran_state_4  [TR -1:0] ;
reg     [0:0]       tran_state_5  [TR -1:0] ;
reg     [0:0]       tran_state_6  [TR -1:0] ;
reg     [0:0]       tran_state_7  [TR -1:0] ;
reg     [0:0]       tran_state_8  [TR -1:0] ;
reg     [0:0]       tran_state_9  [TR -1:0] ;
reg     [0:0]       tran_state_10 [TR -1:0] ;
reg     [0:0]       tran_state_11 [TR -1:0] ;
reg     [0:0]       tran_state_12 [TR -1:0] ;
reg     [0:0]       tran_state_13 [TR -1:0] ;
reg     [0:0]       tran_state_14 [TR -1:0] ;
reg     [0:0]       tran_state_15 [TR -1:0] ;
reg     [0:0]       tran_state_16 [TR -1:0] ;
reg     [0:0]       tran_state_17 [TR -1:0] ;
reg     [0:0]       tran_state_18 [TR -1:0] ;
reg     [0:0]       tran_state_19 [TR -1:0] ;
reg     [0:0]       tran_state_20 [TR -1:0] ;
reg     [0:0]       tran_state_21 [TR -1:0] ;
reg     [0:0]       tran_state_22 [TR -1:0] ;
reg     [0:0]       tran_state_23 [TR -1:0] ;
reg     [0:0]       tran_state_24 [TR -1:0] ;
reg     [0:0]       tran_state_25 [TR -1:0] ;
reg     [0:0]       tran_state_26 [TR -1:0] ;
reg     [0:0]       tran_state_27 [TR -1:0] ;
reg     [0:0]       tran_state_28 [TR -1:0] ;
reg     [0:0]       tran_state_29 [TR -1:0] ;
reg     [0:0]       tran_state_30 [TR -1:0] ;
reg     [0:0]       tran_state_31 [TR -1:0] ;
reg     [0:0]       tran_state_32 [TR -1:0] ;
reg     [0:0]       tran_state_33 [TR -1:0] ;
reg     [0:0]       tran_state_34 [TR -1:0] ;
reg     [0:0]       tran_state_35 [TR -1:0] ;
reg     [0:0]       tran_state_36 [TR -1:0] ;
reg     [0:0]       tran_state_37 [TR -1:0] ;
reg     [0:0]       tran_state_38 [TR -1:0] ;
reg     [0:0]       tran_state_39 [TR -1:0] ;
reg     [0:0]       tran_state_40 [TR -1:0] ;
reg     [0:0]       tran_state_41 [TR -1:0] ;
reg     [0:0]       tran_state_42 [TR -1:0] ;
reg     [0:0]       tran_state_43 [TR -1:0] ;
reg     [0:0]       tran_state_44 [TR -1:0] ;
reg     [0:0]       tran_state_45 [TR -1:0] ;
reg     [0:0]       tran_state_46 [TR -1:0] ;
reg     [0:0]       tran_state_47 [TR -1:0] ;
reg     [0:0]       tran_state_48 [TR -1:0] ;
reg     [0:0]       tran_state_49 [TR -1:0] ;
reg     [0:0]       tran_state_50 [TR -1:0] ;
reg     [0:0]       tran_state_51 [TR -1:0] ;
reg     [0:0]       tran_state_52 [TR -1:0] ;
reg     [0:0]       tran_state_53 [TR -1:0] ;
reg     [0:0]       tran_state_54 [TR -1:0] ;
reg     [0:0]       tran_state_55 [TR -1:0] ;
reg     [0:0]       tran_state_56 [TR -1:0] ;
reg     [0:0]       tran_state_57 [TR -1:0] ;
reg     [0:0]       tran_state_58 [TR -1:0] ;
reg     [0:0]       tran_state_59 [TR -1:0] ;
reg     [0:0]       tran_state_60 [TR -1:0] ;
reg     [0:0]       tran_state_61 [TR -1:0] ;
reg     [0:0]       tran_state_62 [TR -1:0] ;
reg     [0:0]       tran_state_63 [TR -1:0] ;
                             
reg     [TRW -1:0]  wptr ;   
reg     [TRW -1:0]  last_wptr ;
                             
wire    [M -1:0]    diff_0 ; 
wire    [M -1:0]    diff_1 ; 
wire    [M -1:0]    diff_2 ; 
wire    [M -1:0]    diff_3 ; 
wire    [M -1:0]    diff_4 ; 
wire    [M -1:0]    diff_5 ; 
wire    [M -1:0]    diff_6 ; 
wire    [M -1:0]    diff_7 ; 
wire    [M -1:0]    diff_8 ; 
wire    [M -1:0]    diff_9 ;
wire    [M -1:0]    diff_10;
wire    [M -1:0]    diff_11;
wire    [M -1:0]    diff_12;
wire    [M -1:0]    diff_13;
wire    [M -1:0]    diff_14;
wire    [M -1:0]    diff_15;
wire    [M -1:0]    diff_16; 
wire    [M -1:0]    diff_17; 
wire    [M -1:0]    diff_18; 
wire    [M -1:0]    diff_19; 
wire    [M -1:0]    diff_20; 
wire    [M -1:0]    diff_21; 
wire    [M -1:0]    diff_22; 
wire    [M -1:0]    diff_23; 
wire    [M -1:0]    diff_24; 
wire    [M -1:0]    diff_25;
wire    [M -1:0]    diff_26;
wire    [M -1:0]    diff_27;
wire    [M -1:0]    diff_28;
wire    [M -1:0]    diff_29;
wire    [M -1:0]    diff_30;
wire    [M -1:0]    diff_31;
wire    [M -1:0]    diff_32; 
wire    [M -1:0]    diff_33; 
wire    [M -1:0]    diff_34; 
wire    [M -1:0]    diff_35; 
wire    [M -1:0]    diff_36; 
wire    [M -1:0]    diff_37; 
wire    [M -1:0]    diff_38; 
wire    [M -1:0]    diff_39; 
wire    [M -1:0]    diff_40; 
wire    [M -1:0]    diff_41;
wire    [M -1:0]    diff_42;
wire    [M -1:0]    diff_43;
wire    [M -1:0]    diff_44;
wire    [M -1:0]    diff_45;
wire    [M -1:0]    diff_46;
wire    [M -1:0]    diff_47;
wire    [M -1:0]    diff_48; 
wire    [M -1:0]    diff_49; 
wire    [M -1:0]    diff_50; 
wire    [M -1:0]    diff_51; 
wire    [M -1:0]    diff_52; 
wire    [M -1:0]    diff_53; 
wire    [M -1:0]    diff_54; 
wire    [M -1:0]    diff_55; 
wire    [M -1:0]    diff_56; 
wire    [M -1:0]    diff_57;
wire    [M -1:0]    diff_58;
wire    [M -1:0]    diff_59;
wire    [M -1:0]    diff_60;
wire    [M -1:0]    diff_61;
wire    [M -1:0]    diff_62;
wire    [M -1:0]    diff_63;

reg                 nd ;
reg     [LW -1:0]   cnt ;
reg                 trace ;
reg                 trace_en ;
wire                trace_done ;
reg                 trace_done_s0 ;
wire                trace_done_pos ;
reg     [TRW -1:0]  trace_cnt ;
reg     [L-1:0]     res ;
wire    [L-1:0]     res_shift ;
wire    [K-2: 0]    init_state_i ;
reg     [K-2: 0]    trace_state ;

wire    [K-2: 0]    cur_state0 ;
wire    [K-2: 0]    cur_state1 ;
wire    [K-2: 0]    next_state ;
reg     [TRW -1:0]  trace_start_wptr ;
wire    [TRW -1:0]  trace_start_pos ;
wire    [TRW -1:0]  trace_start_pos0 ;
wire    [TRW -1:0]  trace_start_pos1 ;
reg                 last_trace ;
reg                 last_trace_s0 ;
wire                trace2 ;
reg                 trace2_s1 ;
reg                 trace2_s2 ;
reg                 trace_pos ;
wire                trace_pos_i ;
reg     [LW -1:0]   last_trace_num ;
reg                 flush_en ;
wire                flush ;
reg                 done_i ;

wire    [K-2: 0]    state_0 ;
wire    [K-2: 0]    state_1 ;
wire    [K-2: 0]    state_2 ;
wire    [K-2: 0]    state_3 ;
wire    [K-2: 0]    state_4 ;
wire    [K-2: 0]    state_5 ;
wire    [K-2: 0]    state_6 ;
wire    [K-2: 0]    state_7 ;
wire    [K-2: 0]    state_8 ;
wire    [K-2: 0]    state_9 ;
wire    [K-2: 0]    state_10 ;
wire    [K-2: 0]    state_11 ;
wire    [K-2: 0]    state_12 ;
wire    [K-2: 0]    state_13 ;
wire    [K-2: 0]    state_14 ;
wire    [K-2: 0]    state_15 ;

wire    [K-2: 0]    state_s1_0 ;
wire    [K-2: 0]    state_s1_1 ;
wire    [K-2: 0]    state_s1_2 ;
wire    [K-2: 0]    state_s1_3 ;

wire    [K-2: 0]    state_s2_0 ;

wire    [M-1: 0]    max_0  ;
wire    [M-1: 0]    max_1  ;
wire    [M-1: 0]    max_2  ;
wire    [M-1: 0]    max_3  ;
wire    [M-1: 0]    max_4  ;
wire    [M-1: 0]    max_5  ;
wire    [M-1: 0]    max_6  ;
wire    [M-1: 0]    max_7  ;
wire    [M-1: 0]    max_8  ;
wire    [M-1: 0]    max_9  ;
wire    [M-1: 0]    max_10 ;
wire    [M-1: 0]    max_11 ;
wire    [M-1: 0]    max_12 ;
wire    [M-1: 0]    max_13 ;
wire    [M-1: 0]    max_14 ;
wire    [M-1: 0]    max_15 ;

wire    [M-1: 0]    max_s1_0 ;
wire    [M-1: 0]    max_s1_1 ;
wire    [M-1: 0]    max_s1_2 ;
wire    [M-1: 0]    max_s1_3 ;

//reg     [M-1: 0]    max_s1_0_s0 ;
//reg     [M-1: 0]    max_s1_1_s0 ;
//reg     [M-1: 0]    max_s1_2_s0 ;
//reg     [M-1: 0]    max_s1_3_s0 ;

//wire    [M-1: 0]    max_s2_0 ;

wire    [N -1:0]    tran_all_0 ;
wire    [N -1:0]    tran_all_1 ;

reg     [6:0]       flush_cnt ;
wire    [LW -1:0]   rem_i ;
reg     [LW -1:0]   last_cnt ;
wire    [LW -1:0]   last_cnt_next ;
reg                 last_trace_d0 ;
reg                 last_trace_d1 ;
reg                 last_trace_d2 ;
reg                 last_trace_d3 ;
reg                 last_trace_d4 ;
reg                 last_trace_d5 ;
reg                 one_more_out ;
reg                 in_dec ;
wire                dv_in_gate ;
reg                 trace_pos_s0 ; 

//======================================
// Main body of code
//======================================
assign dv_out = trace_done_pos | one_more_out ;
assign res_shift = res << last_trace_num ;
assign dout = res_shift [L -1:C] ;
assign remain = last_trace ? rem_i : 0 ;
assign done = dv_out & done_i ;
assign rem_i = ~last_cnt_next[LW-1] ? 0 : last_cnt ;

//assign dv_in_gate = dv_in & in_dec ;
assign dv_in_gate = dv_in & in_dec & (~packet_end) ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
    in_dec <= 1'b0 ;
  else if (packet_start)
    in_dec <= 1'b1 ;
  else if (packet_end)
    in_dec <= 1'b0 ;


//{coe_0 coe_1}, generated from C model gen_table
//0 0; 
//0 1;
//1 0;
//1 1;
//1 0;
//1 1;
//0 0;
//0 1;

assign branch_00 = {llr1[SW -1], llr1} + {llr0[SW -1], llr0} ;  //LLR(bit1) + LLR(bit0)
assign branch_01 = {llr1[SW -1], llr1} ;                        //LLR(bit1)
assign branch_10 = {llr0[SW -1], llr0} ;                        //LLR(bit0)
assign branch_11 = 0  ;                                         //0

assign branch_A_0 = branch_00 ;
assign branch_B_0 = branch_11 ;
assign branch_A_1 = branch_10 ;
assign branch_B_1 = branch_01 ;
assign branch_A_2 = branch_00 ;
assign branch_B_2 = branch_11 ;
assign branch_A_3 = branch_10 ;
assign branch_B_3 = branch_01 ;
assign branch_A_4 = branch_11 ;
assign branch_B_4 = branch_00 ;
assign branch_A_5 = branch_01 ;
assign branch_B_5 = branch_10 ;
assign branch_A_6 = branch_11 ;
assign branch_B_6 = branch_00 ;
assign branch_A_7 = branch_01 ;
assign branch_B_7 = branch_10 ;
assign branch_A_8 = branch_11 ;
assign branch_B_8 = branch_00 ;
assign branch_A_9 = branch_01 ;
assign branch_B_9 = branch_10 ;
assign branch_A_10 = branch_11 ;
assign branch_B_10 = branch_00 ;
assign branch_A_11 = branch_01 ;
assign branch_B_11 = branch_10 ;
assign branch_A_12 = branch_00 ;
assign branch_B_12 = branch_11 ;
assign branch_A_13 = branch_10 ;
assign branch_B_13 = branch_01 ;
assign branch_A_14 = branch_00 ;
assign branch_B_14 = branch_11 ;
assign branch_A_15 = branch_10 ;
assign branch_B_15 = branch_01 ;
assign branch_A_16 = branch_01 ;
assign branch_B_16 = branch_10 ;
assign branch_A_17 = branch_11 ;
assign branch_B_17 = branch_00 ;
assign branch_A_18 = branch_01 ;
assign branch_B_18 = branch_10 ;
assign branch_A_19 = branch_11 ;
assign branch_B_19 = branch_00 ;
assign branch_A_20 = branch_10 ;
assign branch_B_20 = branch_01 ;
assign branch_A_21 = branch_00 ;
assign branch_B_21 = branch_11 ;
assign branch_A_22 = branch_10 ;
assign branch_B_22 = branch_01 ;
assign branch_A_23 = branch_00 ;
assign branch_B_23 = branch_11 ;
assign branch_A_24 = branch_10 ;
assign branch_B_24 = branch_01 ;
assign branch_A_25 = branch_00 ;
assign branch_B_25 = branch_11 ;
assign branch_A_26 = branch_10 ;
assign branch_B_26 = branch_01 ;
assign branch_A_27 = branch_00 ;
assign branch_B_27 = branch_11 ;
assign branch_A_28 = branch_01 ;
assign branch_B_28 = branch_10 ;
assign branch_A_29 = branch_11 ;
assign branch_B_29 = branch_00 ;
assign branch_A_30 = branch_01 ;
assign branch_B_30 = branch_10 ;
assign branch_A_31 = branch_11 ;
assign branch_B_31 = branch_00 ;

assign branch_A_32 = branch_B_0 ;
assign branch_B_32 = branch_A_0 ;
assign branch_A_33 = branch_B_1 ;
assign branch_B_33 = branch_A_1 ;
assign branch_A_34 = branch_B_2 ;
assign branch_B_34 = branch_A_2 ;
assign branch_A_35 = branch_B_3 ;
assign branch_B_35 = branch_A_3 ;
assign branch_A_36 = branch_B_4 ;
assign branch_B_36 = branch_A_4 ;
assign branch_A_37 = branch_B_5 ;
assign branch_B_37 = branch_A_5 ;
assign branch_A_38 = branch_B_6 ;
assign branch_B_38 = branch_A_6 ;
assign branch_A_39 = branch_B_7 ;
assign branch_B_39 = branch_A_7 ;
assign branch_A_40 = branch_B_8 ;
assign branch_B_40 = branch_A_8 ;
assign branch_A_41 = branch_B_9 ;
assign branch_B_41 = branch_A_9 ;
assign branch_A_42 = branch_B_10 ;
assign branch_B_42 = branch_A_10 ;
assign branch_A_43 = branch_B_11 ;
assign branch_B_43 = branch_A_11 ;
assign branch_A_44 = branch_B_12 ;
assign branch_B_44 = branch_A_12 ;
assign branch_A_45 = branch_B_13 ;
assign branch_B_45 = branch_A_13 ;
assign branch_A_46 = branch_B_14 ;
assign branch_B_46 = branch_A_14 ;
assign branch_A_47 = branch_B_15 ;
assign branch_B_47 = branch_A_15 ;
assign branch_A_48 = branch_B_16 ;
assign branch_B_48 = branch_A_16 ;
assign branch_A_49 = branch_B_17 ;
assign branch_B_49 = branch_A_17 ;
assign branch_A_50 = branch_B_18 ;
assign branch_B_50 = branch_A_18 ;
assign branch_A_51 = branch_B_19 ;
assign branch_B_51 = branch_A_19 ;
assign branch_A_52 = branch_B_20 ;
assign branch_B_52 = branch_A_20 ;
assign branch_A_53 = branch_B_21 ;
assign branch_B_53 = branch_A_21 ;
assign branch_A_54 = branch_B_22 ;
assign branch_B_54 = branch_A_22 ;
assign branch_A_55 = branch_B_23 ;
assign branch_B_55 = branch_A_23 ;
assign branch_A_56 = branch_B_24 ;
assign branch_B_56 = branch_A_24 ;
assign branch_A_57 = branch_B_25 ;
assign branch_B_57 = branch_A_25 ;
assign branch_A_58 = branch_B_26 ;
assign branch_B_58 = branch_A_26 ;
assign branch_A_59 = branch_B_27 ;
assign branch_B_59 = branch_A_27 ;
assign branch_A_60 = branch_B_28 ;
assign branch_B_60 = branch_A_28 ;
assign branch_A_61 = branch_B_29 ;
assign branch_B_61 = branch_A_29 ;
assign branch_A_62 = branch_B_30 ;
assign branch_B_62 = branch_A_30 ;
assign branch_A_63 = branch_B_31 ;
assign branch_B_63 = branch_A_31 ;

assign metric_A_0 = metric_0 + {{(M -SW -1){branch_A_0[SW]}}, branch_A_0} ;
assign metric_B_0 = metric_1 + {{(M -SW -1){branch_B_0[SW]}}, branch_B_0} ;
assign metric_A_1 = metric_2 + {{(M -SW -1){branch_A_1[SW]}}, branch_A_1} ;
assign metric_B_1 = metric_3 + {{(M -SW -1){branch_B_1[SW]}}, branch_B_1} ;
assign metric_A_2 = metric_4 + {{(M -SW -1){branch_A_2[SW]}}, branch_A_2} ;
assign metric_B_2 = metric_5 + {{(M -SW -1){branch_B_2[SW]}}, branch_B_2} ;
assign metric_A_3 = metric_6 + {{(M -SW -1){branch_A_3[SW]}}, branch_A_3} ;
assign metric_B_3 = metric_7 + {{(M -SW -1){branch_B_3[SW]}}, branch_B_3} ;
assign metric_A_4 = metric_8 + {{(M -SW -1){branch_A_4[SW]}}, branch_A_4} ;
assign metric_B_4 = metric_9 + {{(M -SW -1){branch_B_4[SW]}}, branch_B_4} ;
assign metric_A_5 = metric_10 + {{(M -SW -1){branch_A_5[SW]}}, branch_A_5} ;
assign metric_B_5 = metric_11 + {{(M -SW -1){branch_B_5[SW]}}, branch_B_5} ;
assign metric_A_6 = metric_12 + {{(M -SW -1){branch_A_6[SW]}}, branch_A_6} ;
assign metric_B_6 = metric_13 + {{(M -SW -1){branch_B_6[SW]}}, branch_B_6} ;
assign metric_A_7 = metric_14 + {{(M -SW -1){branch_A_7[SW]}}, branch_A_7} ;
assign metric_B_7 = metric_15 + {{(M -SW -1){branch_B_7[SW]}}, branch_B_7} ;
assign metric_A_8 = metric_16 + {{(M -SW -1){branch_A_8[SW]}}, branch_A_8} ;
assign metric_B_8 = metric_17 + {{(M -SW -1){branch_B_8[SW]}}, branch_B_8} ;
assign metric_A_9 = metric_18 + {{(M -SW -1){branch_A_9[SW]}}, branch_A_9} ;
assign metric_B_9 = metric_19 + {{(M -SW -1){branch_B_9[SW]}}, branch_B_9} ;
assign metric_A_10 = metric_20 + {{(M -SW -1){branch_A_10[SW]}}, branch_A_10} ;
assign metric_B_10 = metric_21 + {{(M -SW -1){branch_B_10[SW]}}, branch_B_10} ;
assign metric_A_11 = metric_22 + {{(M -SW -1){branch_A_11[SW]}}, branch_A_11} ;
assign metric_B_11 = metric_23 + {{(M -SW -1){branch_B_11[SW]}}, branch_B_11} ;
assign metric_A_12 = metric_24 + {{(M -SW -1){branch_A_12[SW]}}, branch_A_12} ;
assign metric_B_12 = metric_25 + {{(M -SW -1){branch_B_12[SW]}}, branch_B_12} ;
assign metric_A_13 = metric_26 + {{(M -SW -1){branch_A_13[SW]}}, branch_A_13} ;
assign metric_B_13 = metric_27 + {{(M -SW -1){branch_B_13[SW]}}, branch_B_13} ;
assign metric_A_14 = metric_28 + {{(M -SW -1){branch_A_14[SW]}}, branch_A_14} ;
assign metric_B_14 = metric_29 + {{(M -SW -1){branch_B_14[SW]}}, branch_B_14} ;
assign metric_A_15 = metric_30 + {{(M -SW -1){branch_A_15[SW]}}, branch_A_15} ;
assign metric_B_15 = metric_31 + {{(M -SW -1){branch_B_15[SW]}}, branch_B_15} ;
assign metric_A_16 = metric_32 + {{(M -SW -1){branch_A_16[SW]}}, branch_A_16} ;
assign metric_B_16 = metric_33 + {{(M -SW -1){branch_B_16[SW]}}, branch_B_16} ;
assign metric_A_17 = metric_34 + {{(M -SW -1){branch_A_17[SW]}}, branch_A_17} ;
assign metric_B_17 = metric_35 + {{(M -SW -1){branch_B_17[SW]}}, branch_B_17} ;
assign metric_A_18 = metric_36 + {{(M -SW -1){branch_A_18[SW]}}, branch_A_18} ;
assign metric_B_18 = metric_37 + {{(M -SW -1){branch_B_18[SW]}}, branch_B_18} ;
assign metric_A_19 = metric_38 + {{(M -SW -1){branch_A_19[SW]}}, branch_A_19} ;
assign metric_B_19 = metric_39 + {{(M -SW -1){branch_B_19[SW]}}, branch_B_19} ;
assign metric_A_20 = metric_40 + {{(M -SW -1){branch_A_20[SW]}}, branch_A_20} ;
assign metric_B_20 = metric_41 + {{(M -SW -1){branch_B_20[SW]}}, branch_B_20} ;
assign metric_A_21 = metric_42 + {{(M -SW -1){branch_A_21[SW]}}, branch_A_21} ;
assign metric_B_21 = metric_43 + {{(M -SW -1){branch_B_21[SW]}}, branch_B_21} ;
assign metric_A_22 = metric_44 + {{(M -SW -1){branch_A_22[SW]}}, branch_A_22} ;
assign metric_B_22 = metric_45 + {{(M -SW -1){branch_B_22[SW]}}, branch_B_22} ;
assign metric_A_23 = metric_46 + {{(M -SW -1){branch_A_23[SW]}}, branch_A_23} ;
assign metric_B_23 = metric_47 + {{(M -SW -1){branch_B_23[SW]}}, branch_B_23} ;
assign metric_A_24 = metric_48 + {{(M -SW -1){branch_A_24[SW]}}, branch_A_24} ;
assign metric_B_24 = metric_49 + {{(M -SW -1){branch_B_24[SW]}}, branch_B_24} ;
assign metric_A_25 = metric_50 + {{(M -SW -1){branch_A_25[SW]}}, branch_A_25} ;
assign metric_B_25 = metric_51 + {{(M -SW -1){branch_B_25[SW]}}, branch_B_25} ;
assign metric_A_26 = metric_52 + {{(M -SW -1){branch_A_26[SW]}}, branch_A_26} ;
assign metric_B_26 = metric_53 + {{(M -SW -1){branch_B_26[SW]}}, branch_B_26} ;
assign metric_A_27 = metric_54 + {{(M -SW -1){branch_A_27[SW]}}, branch_A_27} ;
assign metric_B_27 = metric_55 + {{(M -SW -1){branch_B_27[SW]}}, branch_B_27} ;
assign metric_A_28 = metric_56 + {{(M -SW -1){branch_A_28[SW]}}, branch_A_28} ;
assign metric_B_28 = metric_57 + {{(M -SW -1){branch_B_28[SW]}}, branch_B_28} ;
assign metric_A_29 = metric_58 + {{(M -SW -1){branch_A_29[SW]}}, branch_A_29} ;
assign metric_B_29 = metric_59 + {{(M -SW -1){branch_B_29[SW]}}, branch_B_29} ;
assign metric_A_30 = metric_60 + {{(M -SW -1){branch_A_30[SW]}}, branch_A_30} ;
assign metric_B_30 = metric_61 + {{(M -SW -1){branch_B_30[SW]}}, branch_B_30} ;
assign metric_A_31 = metric_62 + {{(M -SW -1){branch_A_31[SW]}}, branch_A_31} ;
assign metric_B_31 = metric_63 + {{(M -SW -1){branch_B_31[SW]}}, branch_B_31} ;
assign metric_A_32 = metric_0 + {{(M -SW -1){branch_A_32[SW]}}, branch_A_32} ;
assign metric_B_32 = metric_1 + {{(M -SW -1){branch_B_32[SW]}}, branch_B_32} ;
assign metric_A_33 = metric_2 + {{(M -SW -1){branch_A_33[SW]}}, branch_A_33} ;
assign metric_B_33 = metric_3 + {{(M -SW -1){branch_B_33[SW]}}, branch_B_33} ;
assign metric_A_34 = metric_4 + {{(M -SW -1){branch_A_34[SW]}}, branch_A_34} ;
assign metric_B_34 = metric_5 + {{(M -SW -1){branch_B_34[SW]}}, branch_B_34} ;
assign metric_A_35 = metric_6 + {{(M -SW -1){branch_A_35[SW]}}, branch_A_35} ;
assign metric_B_35 = metric_7 + {{(M -SW -1){branch_B_35[SW]}}, branch_B_35} ;
assign metric_A_36 = metric_8 + {{(M -SW -1){branch_A_36[SW]}}, branch_A_36} ;
assign metric_B_36 = metric_9 + {{(M -SW -1){branch_B_36[SW]}}, branch_B_36} ;
assign metric_A_37 = metric_10 + {{(M -SW -1){branch_A_37[SW]}}, branch_A_37} ;
assign metric_B_37 = metric_11 + {{(M -SW -1){branch_B_37[SW]}}, branch_B_37} ;
assign metric_A_38 = metric_12 + {{(M -SW -1){branch_A_38[SW]}}, branch_A_38} ;
assign metric_B_38 = metric_13 + {{(M -SW -1){branch_B_38[SW]}}, branch_B_38} ;
assign metric_A_39 = metric_14 + {{(M -SW -1){branch_A_39[SW]}}, branch_A_39} ;
assign metric_B_39 = metric_15 + {{(M -SW -1){branch_B_39[SW]}}, branch_B_39} ;
assign metric_A_40 = metric_16 + {{(M -SW -1){branch_A_40[SW]}}, branch_A_40} ;
assign metric_B_40 = metric_17 + {{(M -SW -1){branch_B_40[SW]}}, branch_B_40} ;
assign metric_A_41 = metric_18 + {{(M -SW -1){branch_A_41[SW]}}, branch_A_41} ;
assign metric_B_41 = metric_19 + {{(M -SW -1){branch_B_41[SW]}}, branch_B_41} ;
assign metric_A_42 = metric_20 + {{(M -SW -1){branch_A_42[SW]}}, branch_A_42} ;
assign metric_B_42 = metric_21 + {{(M -SW -1){branch_B_42[SW]}}, branch_B_42} ;
assign metric_A_43 = metric_22 + {{(M -SW -1){branch_A_43[SW]}}, branch_A_43} ;
assign metric_B_43 = metric_23 + {{(M -SW -1){branch_B_43[SW]}}, branch_B_43} ;
assign metric_A_44 = metric_24 + {{(M -SW -1){branch_A_44[SW]}}, branch_A_44} ;
assign metric_B_44 = metric_25 + {{(M -SW -1){branch_B_44[SW]}}, branch_B_44} ;
assign metric_A_45 = metric_26 + {{(M -SW -1){branch_A_45[SW]}}, branch_A_45} ;
assign metric_B_45 = metric_27 + {{(M -SW -1){branch_B_45[SW]}}, branch_B_45} ;
assign metric_A_46 = metric_28 + {{(M -SW -1){branch_A_46[SW]}}, branch_A_46} ;
assign metric_B_46 = metric_29 + {{(M -SW -1){branch_B_46[SW]}}, branch_B_46} ;
assign metric_A_47 = metric_30 + {{(M -SW -1){branch_A_47[SW]}}, branch_A_47} ;
assign metric_B_47 = metric_31 + {{(M -SW -1){branch_B_47[SW]}}, branch_B_47} ;
assign metric_A_48 = metric_32 + {{(M -SW -1){branch_A_48[SW]}}, branch_A_48} ;
assign metric_B_48 = metric_33 + {{(M -SW -1){branch_B_48[SW]}}, branch_B_48} ;
assign metric_A_49 = metric_34 + {{(M -SW -1){branch_A_49[SW]}}, branch_A_49} ;
assign metric_B_49 = metric_35 + {{(M -SW -1){branch_B_49[SW]}}, branch_B_49} ;
assign metric_A_50 = metric_36 + {{(M -SW -1){branch_A_50[SW]}}, branch_A_50} ;
assign metric_B_50 = metric_37 + {{(M -SW -1){branch_B_50[SW]}}, branch_B_50} ;
assign metric_A_51 = metric_38 + {{(M -SW -1){branch_A_51[SW]}}, branch_A_51} ;
assign metric_B_51 = metric_39 + {{(M -SW -1){branch_B_51[SW]}}, branch_B_51} ;
assign metric_A_52 = metric_40 + {{(M -SW -1){branch_A_52[SW]}}, branch_A_52} ;
assign metric_B_52 = metric_41 + {{(M -SW -1){branch_B_52[SW]}}, branch_B_52} ;
assign metric_A_53 = metric_42 + {{(M -SW -1){branch_A_53[SW]}}, branch_A_53} ;
assign metric_B_53 = metric_43 + {{(M -SW -1){branch_B_53[SW]}}, branch_B_53} ;
assign metric_A_54 = metric_44 + {{(M -SW -1){branch_A_54[SW]}}, branch_A_54} ;
assign metric_B_54 = metric_45 + {{(M -SW -1){branch_B_54[SW]}}, branch_B_54} ;
assign metric_A_55 = metric_46 + {{(M -SW -1){branch_A_55[SW]}}, branch_A_55} ;
assign metric_B_55 = metric_47 + {{(M -SW -1){branch_B_55[SW]}}, branch_B_55} ;
assign metric_A_56 = metric_48 + {{(M -SW -1){branch_A_56[SW]}}, branch_A_56} ;
assign metric_B_56 = metric_49 + {{(M -SW -1){branch_B_56[SW]}}, branch_B_56} ;
assign metric_A_57 = metric_50 + {{(M -SW -1){branch_A_57[SW]}}, branch_A_57} ;
assign metric_B_57 = metric_51 + {{(M -SW -1){branch_B_57[SW]}}, branch_B_57} ;
assign metric_A_58 = metric_52 + {{(M -SW -1){branch_A_58[SW]}}, branch_A_58} ;
assign metric_B_58 = metric_53 + {{(M -SW -1){branch_B_58[SW]}}, branch_B_58} ;
assign metric_A_59 = metric_54 + {{(M -SW -1){branch_A_59[SW]}}, branch_A_59} ;
assign metric_B_59 = metric_55 + {{(M -SW -1){branch_B_59[SW]}}, branch_B_59} ;
assign metric_A_60 = metric_56 + {{(M -SW -1){branch_A_60[SW]}}, branch_A_60} ;
assign metric_B_60 = metric_57 + {{(M -SW -1){branch_B_60[SW]}}, branch_B_60} ;
assign metric_A_61 = metric_58 + {{(M -SW -1){branch_A_61[SW]}}, branch_A_61} ;
assign metric_B_61 = metric_59 + {{(M -SW -1){branch_B_61[SW]}}, branch_B_61} ;
assign metric_A_62 = metric_60 + {{(M -SW -1){branch_A_62[SW]}}, branch_A_62} ;
assign metric_B_62 = metric_61 + {{(M -SW -1){branch_B_62[SW]}}, branch_B_62} ;
assign metric_A_63 = metric_62 + {{(M -SW -1){branch_A_63[SW]}}, branch_A_63} ;
assign metric_B_63 = metric_63 + {{(M -SW -1){branch_B_63[SW]}}, branch_B_63} ;

assign diff_0 = metric_A_0 - metric_B_0 ;
assign diff_1 = metric_A_1 - metric_B_1 ;
assign diff_2 = metric_A_2 - metric_B_2 ;
assign diff_3 = metric_A_3 - metric_B_3 ;
assign diff_4 = metric_A_4 - metric_B_4 ;
assign diff_5 = metric_A_5 - metric_B_5 ;
assign diff_6 = metric_A_6 - metric_B_6 ;
assign diff_7 = metric_A_7 - metric_B_7 ;
assign diff_8 = metric_A_8 - metric_B_8 ;
assign diff_9 = metric_A_9 - metric_B_9 ;
assign diff_10 = metric_A_10 - metric_B_10 ;
assign diff_11 = metric_A_11 - metric_B_11 ;
assign diff_12 = metric_A_12 - metric_B_12 ;
assign diff_13 = metric_A_13 - metric_B_13 ;
assign diff_14 = metric_A_14 - metric_B_14 ;
assign diff_15 = metric_A_15 - metric_B_15 ;
assign diff_16 = metric_A_16 - metric_B_16 ;
assign diff_17 = metric_A_17 - metric_B_17 ;
assign diff_18 = metric_A_18 - metric_B_18 ;
assign diff_19 = metric_A_19 - metric_B_19 ;
assign diff_20 = metric_A_20 - metric_B_20 ;
assign diff_21 = metric_A_21 - metric_B_21 ;
assign diff_22 = metric_A_22 - metric_B_22 ;
assign diff_23 = metric_A_23 - metric_B_23 ;
assign diff_24 = metric_A_24 - metric_B_24 ;
assign diff_25 = metric_A_25 - metric_B_25 ;
assign diff_26 = metric_A_26 - metric_B_26 ;
assign diff_27 = metric_A_27 - metric_B_27 ;
assign diff_28 = metric_A_28 - metric_B_28 ;
assign diff_29 = metric_A_29 - metric_B_29 ;
assign diff_30 = metric_A_30 - metric_B_30 ;
assign diff_31 = metric_A_31 - metric_B_31 ;
assign diff_32 = metric_A_32 - metric_B_32 ;
assign diff_33 = metric_A_33 - metric_B_33 ;
assign diff_34 = metric_A_34 - metric_B_34 ;
assign diff_35 = metric_A_35 - metric_B_35 ;
assign diff_36 = metric_A_36 - metric_B_36 ;
assign diff_37 = metric_A_37 - metric_B_37 ;
assign diff_38 = metric_A_38 - metric_B_38 ;
assign diff_39 = metric_A_39 - metric_B_39 ;
assign diff_40 = metric_A_40 - metric_B_40 ;
assign diff_41 = metric_A_41 - metric_B_41 ;
assign diff_42 = metric_A_42 - metric_B_42 ;
assign diff_43 = metric_A_43 - metric_B_43 ;
assign diff_44 = metric_A_44 - metric_B_44 ;
assign diff_45 = metric_A_45 - metric_B_45 ;
assign diff_46 = metric_A_46 - metric_B_46 ;
assign diff_47 = metric_A_47 - metric_B_47 ;
assign diff_48 = metric_A_48 - metric_B_48 ;
assign diff_49 = metric_A_49 - metric_B_49 ;
assign diff_50 = metric_A_50 - metric_B_50 ;
assign diff_51 = metric_A_51 - metric_B_51 ;
assign diff_52 = metric_A_52 - metric_B_52 ;
assign diff_53 = metric_A_53 - metric_B_53 ;
assign diff_54 = metric_A_54 - metric_B_54 ;
assign diff_55 = metric_A_55 - metric_B_55 ;
assign diff_56 = metric_A_56 - metric_B_56 ;
assign diff_57 = metric_A_57 - metric_B_57 ;
assign diff_58 = metric_A_58 - metric_B_58 ;
assign diff_59 = metric_A_59 - metric_B_59 ;
assign diff_60 = metric_A_60 - metric_B_60 ;
assign diff_61 = metric_A_61 - metric_B_61 ;
assign diff_62 = metric_A_62 - metric_B_62 ;
assign diff_63 = metric_A_63 - metric_B_63 ;

assign metric_next_0 = diff_0 [M -1] ? metric_B_0 : metric_A_0 ;
assign metric_next_1 = diff_1 [M -1] ? metric_B_1 : metric_A_1 ;
assign metric_next_2 = diff_2 [M -1] ? metric_B_2 : metric_A_2 ;
assign metric_next_3 = diff_3 [M -1] ? metric_B_3 : metric_A_3 ;
assign metric_next_4 = diff_4 [M -1] ? metric_B_4 : metric_A_4 ;
assign metric_next_5 = diff_5 [M -1] ? metric_B_5 : metric_A_5 ;
assign metric_next_6 = diff_6 [M -1] ? metric_B_6 : metric_A_6 ;
assign metric_next_7 = diff_7 [M -1] ? metric_B_7 : metric_A_7 ;
assign metric_next_8 = diff_8 [M -1] ? metric_B_8 : metric_A_8 ;
assign metric_next_9 = diff_9 [M -1] ? metric_B_9 : metric_A_9 ;
assign metric_next_10 = diff_10 [M -1] ? metric_B_10 : metric_A_10 ;
assign metric_next_11 = diff_11 [M -1] ? metric_B_11 : metric_A_11 ;
assign metric_next_12 = diff_12 [M -1] ? metric_B_12 : metric_A_12 ;
assign metric_next_13 = diff_13 [M -1] ? metric_B_13 : metric_A_13 ;
assign metric_next_14 = diff_14 [M -1] ? metric_B_14 : metric_A_14 ;
assign metric_next_15 = diff_15 [M -1] ? metric_B_15 : metric_A_15 ;
assign metric_next_16 = diff_16 [M -1] ? metric_B_16 : metric_A_16 ;
assign metric_next_17 = diff_17 [M -1] ? metric_B_17 : metric_A_17 ;
assign metric_next_18 = diff_18 [M -1] ? metric_B_18 : metric_A_18 ;
assign metric_next_19 = diff_19 [M -1] ? metric_B_19 : metric_A_19 ;
assign metric_next_20 = diff_20 [M -1] ? metric_B_20 : metric_A_20 ;
assign metric_next_21 = diff_21 [M -1] ? metric_B_21 : metric_A_21 ;
assign metric_next_22 = diff_22 [M -1] ? metric_B_22 : metric_A_22 ;
assign metric_next_23 = diff_23 [M -1] ? metric_B_23 : metric_A_23 ;
assign metric_next_24 = diff_24 [M -1] ? metric_B_24 : metric_A_24 ;
assign metric_next_25 = diff_25 [M -1] ? metric_B_25 : metric_A_25 ;
assign metric_next_26 = diff_26 [M -1] ? metric_B_26 : metric_A_26 ;
assign metric_next_27 = diff_27 [M -1] ? metric_B_27 : metric_A_27 ;
assign metric_next_28 = diff_28 [M -1] ? metric_B_28 : metric_A_28 ;
assign metric_next_29 = diff_29 [M -1] ? metric_B_29 : metric_A_29 ;
assign metric_next_30 = diff_30 [M -1] ? metric_B_30 : metric_A_30 ;
assign metric_next_31 = diff_31 [M -1] ? metric_B_31 : metric_A_31 ;
assign metric_next_32 = diff_32 [M -1] ? metric_B_32 : metric_A_32 ;
assign metric_next_33 = diff_33 [M -1] ? metric_B_33 : metric_A_33 ;
assign metric_next_34 = diff_34 [M -1] ? metric_B_34 : metric_A_34 ;
assign metric_next_35 = diff_35 [M -1] ? metric_B_35 : metric_A_35 ;
assign metric_next_36 = diff_36 [M -1] ? metric_B_36 : metric_A_36 ;
assign metric_next_37 = diff_37 [M -1] ? metric_B_37 : metric_A_37 ;
assign metric_next_38 = diff_38 [M -1] ? metric_B_38 : metric_A_38 ;
assign metric_next_39 = diff_39 [M -1] ? metric_B_39 : metric_A_39 ;
assign metric_next_40 = diff_40 [M -1] ? metric_B_40 : metric_A_40 ;
assign metric_next_41 = diff_41 [M -1] ? metric_B_41 : metric_A_41 ;
assign metric_next_42 = diff_42 [M -1] ? metric_B_42 : metric_A_42 ;
assign metric_next_43 = diff_43 [M -1] ? metric_B_43 : metric_A_43 ;
assign metric_next_44 = diff_44 [M -1] ? metric_B_44 : metric_A_44 ;
assign metric_next_45 = diff_45 [M -1] ? metric_B_45 : metric_A_45 ;
assign metric_next_46 = diff_46 [M -1] ? metric_B_46 : metric_A_46 ;
assign metric_next_47 = diff_47 [M -1] ? metric_B_47 : metric_A_47 ;
assign metric_next_48 = diff_48 [M -1] ? metric_B_48 : metric_A_48 ;
assign metric_next_49 = diff_49 [M -1] ? metric_B_49 : metric_A_49 ;
assign metric_next_50 = diff_50 [M -1] ? metric_B_50 : metric_A_50 ;
assign metric_next_51 = diff_51 [M -1] ? metric_B_51 : metric_A_51 ;
assign metric_next_52 = diff_52 [M -1] ? metric_B_52 : metric_A_52 ;
assign metric_next_53 = diff_53 [M -1] ? metric_B_53 : metric_A_53 ;
assign metric_next_54 = diff_54 [M -1] ? metric_B_54 : metric_A_54 ;
assign metric_next_55 = diff_55 [M -1] ? metric_B_55 : metric_A_55 ;
assign metric_next_56 = diff_56 [M -1] ? metric_B_56 : metric_A_56 ;
assign metric_next_57 = diff_57 [M -1] ? metric_B_57 : metric_A_57 ;
assign metric_next_58 = diff_58 [M -1] ? metric_B_58 : metric_A_58 ;
assign metric_next_59 = diff_59 [M -1] ? metric_B_59 : metric_A_59 ;
assign metric_next_60 = diff_60 [M -1] ? metric_B_60 : metric_A_60 ;
assign metric_next_61 = diff_61 [M -1] ? metric_B_61 : metric_A_61 ;
assign metric_next_62 = diff_62 [M -1] ? metric_B_62 : metric_A_62 ;
assign metric_next_63 = diff_63 [M -1] ? metric_B_63 : metric_A_63 ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
  begin
    metric_0  <= 10 ;
    metric_1  <= 0 ;
    metric_2  <= 0 ;
    metric_3  <= 0 ;
    metric_4  <= 0 ;
    metric_5  <= 0 ;
    metric_6  <= 0 ;
    metric_7  <= 0 ;
    metric_8  <= 0 ;
    metric_9  <= 0 ;
    metric_10 <= 0 ;
    metric_11 <= 0 ;
    metric_12 <= 0 ;
    metric_13 <= 0 ;
    metric_14 <= 0 ;
    metric_15 <= 0 ;
    metric_16 <= 0 ; 
    metric_17 <= 0 ;  
    metric_18 <= 0 ;  
    metric_19 <= 0 ;  
    metric_20 <= 0 ;  
    metric_21 <= 0 ;  
    metric_22 <= 0 ;  
    metric_23 <= 0 ;  
    metric_24 <= 0 ;  
    metric_25 <= 0 ;  
    metric_26 <= 0 ;  
    metric_27 <= 0 ;  
    metric_28 <= 0 ;  
    metric_29 <= 0 ;  
    metric_30 <= 0 ;  
    metric_31 <= 0 ;  
    metric_32 <= 0 ; 
    metric_33 <= 0 ;  
    metric_34 <= 0 ;  
    metric_35 <= 0 ;  
    metric_36 <= 0 ;  
    metric_37 <= 0 ;  
    metric_38 <= 0 ;  
    metric_39 <= 0 ;  
    metric_40 <= 0 ;  
    metric_41 <= 0 ;  
    metric_42 <= 0 ;  
    metric_43 <= 0 ;  
    metric_44 <= 0 ;  
    metric_45 <= 0 ;  
    metric_46 <= 0 ;  
    metric_47 <= 0 ;  
    metric_48 <= 0 ; 
    metric_49 <= 0 ;  
    metric_50 <= 0 ;  
    metric_51 <= 0 ;  
    metric_52 <= 0 ;  
    metric_53 <= 0 ;  
    metric_54 <= 0 ;  
    metric_55 <= 0 ;  
    metric_56 <= 0 ;  
    metric_57 <= 0 ;  
    metric_58 <= 0 ;  
    metric_59 <= 0 ;  
    metric_60 <= 0 ;  
    metric_61 <= 0 ;  
    metric_62 <= 0 ;  
    metric_63 <= 0 ;  
  end
  else if (packet_start)
  begin
    metric_0  <= 10 ;
    metric_1  <= 0 ;
    metric_2  <= 0 ;
    metric_3  <= 0 ;
    metric_4  <= 0 ;
    metric_5  <= 0 ;    
    metric_6  <= 0 ;
    metric_7  <= 0 ;
    metric_8  <= 0 ;
    metric_9  <= 0 ;
    metric_10 <= 0 ;
    metric_11 <= 0 ;    
    metric_12 <= 0 ;
    metric_13 <= 0 ;
    metric_14 <= 0 ;
    metric_15 <= 0 ;
    metric_16 <= 0 ; 
    metric_17 <= 0 ;  
    metric_18 <= 0 ;  
    metric_19 <= 0 ;  
    metric_20 <= 0 ;  
    metric_21 <= 0 ;  
    metric_22 <= 0 ;  
    metric_23 <= 0 ;  
    metric_24 <= 0 ;  
    metric_25 <= 0 ;  
    metric_26 <= 0 ;  
    metric_27 <= 0 ;  
    metric_28 <= 0 ;  
    metric_29 <= 0 ;  
    metric_30 <= 0 ;  
    metric_31 <= 0 ;  
    metric_32 <= 0 ; 
    metric_33 <= 0 ;  
    metric_34 <= 0 ;  
    metric_35 <= 0 ;  
    metric_36 <= 0 ;  
    metric_37 <= 0 ;  
    metric_38 <= 0 ;  
    metric_39 <= 0 ;  
    metric_40 <= 0 ;  
    metric_41 <= 0 ;  
    metric_42 <= 0 ;  
    metric_43 <= 0 ;  
    metric_44 <= 0 ;  
    metric_45 <= 0 ;  
    metric_46 <= 0 ;  
    metric_47 <= 0 ;  
    metric_48 <= 0 ; 
    metric_49 <= 0 ;  
    metric_50 <= 0 ;  
    metric_51 <= 0 ;  
    metric_52 <= 0 ;  
    metric_53 <= 0 ;  
    metric_54 <= 0 ;  
    metric_55 <= 0 ;  
    metric_56 <= 0 ;  
    metric_57 <= 0 ;  
    metric_58 <= 0 ;  
    metric_59 <= 0 ;  
    metric_60 <= 0 ;  
    metric_61 <= 0 ;  
    metric_62 <= 0 ;  
    metric_63 <= 0 ;  
  end
  else if (dv_in_gate)
  begin
    // update metric
    metric_0  <= metric_next_0 ;
    metric_1  <= metric_next_1 ;
    metric_2  <= metric_next_2 ;
    metric_3  <= metric_next_3 ;
    metric_4  <= metric_next_4 ;
    metric_5  <= metric_next_5 ;    
    metric_6  <= metric_next_6 ;
    metric_7  <= metric_next_7 ;
    metric_8  <= metric_next_8 ;
    metric_9  <= metric_next_9 ;
    metric_10 <= metric_next_10;
    metric_11 <= metric_next_11;    
    metric_12 <= metric_next_12;
    metric_13 <= metric_next_13;
    metric_14 <= metric_next_14;
    metric_15 <= metric_next_15;
    metric_16 <= metric_next_16 ;
    metric_17 <= metric_next_17;
    metric_18 <= metric_next_18;
    metric_19 <= metric_next_19;
    metric_20 <= metric_next_20;
    metric_21 <= metric_next_21;    
    metric_22 <= metric_next_22;
    metric_23 <= metric_next_23;
    metric_24 <= metric_next_24;
    metric_25 <= metric_next_25;
    metric_26 <= metric_next_26;
    metric_27 <= metric_next_27;    
    metric_28 <= metric_next_28;
    metric_29 <= metric_next_29;
    metric_30 <= metric_next_30;
    metric_31 <= metric_next_31;
    metric_32 <= metric_next_32 ;
    metric_33 <= metric_next_33;
    metric_34 <= metric_next_34;
    metric_35 <= metric_next_35;
    metric_36 <= metric_next_36;
    metric_37 <= metric_next_37;    
    metric_38 <= metric_next_38;
    metric_39 <= metric_next_39;
    metric_40 <= metric_next_40;
    metric_41 <= metric_next_41;
    metric_42 <= metric_next_42;
    metric_43 <= metric_next_43;    
    metric_44 <= metric_next_44;
    metric_45 <= metric_next_45;
    metric_46 <= metric_next_46;
    metric_47 <= metric_next_47;
    metric_48 <= metric_next_48 ;
    metric_49 <= metric_next_49;
    metric_50 <= metric_next_50;
    metric_51 <= metric_next_51;
    metric_52 <= metric_next_52;
    metric_53 <= metric_next_53;    
    metric_54 <= metric_next_54;
    metric_55 <= metric_next_55;
    metric_56 <= metric_next_56;
    metric_57 <= metric_next_57;
    metric_58 <= metric_next_58;
    metric_59 <= metric_next_59;    
    metric_60 <= metric_next_60;
    metric_61 <= metric_next_61;
    metric_62 <= metric_next_62;
    metric_63 <= metric_next_63;
  end

always @ (posedge clk or negedge nrst)
  if (~nrst)
    wptr <= 0 ;
  else if (packet_start)
    wptr <= 0 ;
  else if (dv_in_gate)
      wptr <= wptr + 1 ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
    last_wptr <= 1'b0 ;
  else if (dv_in_gate)
    last_wptr <= wptr ;
 
always @ (posedge clk)
  if(dv_in_gate)
  begin
    // update transition
    tran_state_0  [wptr] <= diff_0  [M -1] ;
    tran_state_1  [wptr] <= diff_1  [M -1] ;
    tran_state_2  [wptr] <= diff_2  [M -1] ;
    tran_state_3  [wptr] <= diff_3  [M -1] ;
    tran_state_4  [wptr] <= diff_4  [M -1] ;
    tran_state_5  [wptr] <= diff_5  [M -1] ;
    tran_state_6  [wptr] <= diff_6  [M -1] ;
    tran_state_7  [wptr] <= diff_7  [M -1] ;
    tran_state_8  [wptr] <= diff_8  [M -1] ;
    tran_state_9  [wptr] <= diff_9  [M -1] ;
    tran_state_10 [wptr] <= diff_10 [M -1] ;
    tran_state_11 [wptr] <= diff_11 [M -1] ;
    tran_state_12 [wptr] <= diff_12 [M -1] ;
    tran_state_13 [wptr] <= diff_13 [M -1] ;
    tran_state_14 [wptr] <= diff_14 [M -1] ;
    tran_state_15 [wptr] <= diff_15 [M -1] ;
    tran_state_16 [wptr] <= diff_16 [M -1] ;
    tran_state_17 [wptr] <= diff_17 [M -1] ;
    tran_state_18 [wptr] <= diff_18 [M -1] ;
    tran_state_19 [wptr] <= diff_19 [M -1] ;
    tran_state_20 [wptr] <= diff_20 [M -1] ;
    tran_state_21 [wptr] <= diff_21 [M -1] ;
    tran_state_22 [wptr] <= diff_22 [M -1] ;
    tran_state_23 [wptr] <= diff_23 [M -1] ;
    tran_state_24 [wptr] <= diff_24 [M -1] ;
    tran_state_25 [wptr] <= diff_25 [M -1] ;
    tran_state_26 [wptr] <= diff_26 [M -1] ;
    tran_state_27 [wptr] <= diff_27 [M -1] ;
    tran_state_28 [wptr] <= diff_28 [M -1] ;
    tran_state_29 [wptr] <= diff_29 [M -1] ;
    tran_state_30 [wptr] <= diff_30 [M -1] ;
    tran_state_31 [wptr] <= diff_31 [M -1] ;
    tran_state_32 [wptr] <= diff_32 [M -1] ;
    tran_state_33 [wptr] <= diff_33 [M -1] ;
    tran_state_34 [wptr] <= diff_34 [M -1] ;
    tran_state_35 [wptr] <= diff_35 [M -1] ;
    tran_state_36 [wptr] <= diff_36 [M -1] ;
    tran_state_37 [wptr] <= diff_37 [M -1] ;
    tran_state_38 [wptr] <= diff_38 [M -1] ;
    tran_state_39 [wptr] <= diff_39 [M -1] ;
    tran_state_40 [wptr] <= diff_40 [M -1] ;
    tran_state_41 [wptr] <= diff_41 [M -1] ;
    tran_state_42 [wptr] <= diff_42 [M -1] ;
    tran_state_43 [wptr] <= diff_43 [M -1] ;
    tran_state_44 [wptr] <= diff_44 [M -1] ;
    tran_state_45 [wptr] <= diff_45 [M -1] ;
    tran_state_46 [wptr] <= diff_46 [M -1] ;
    tran_state_47 [wptr] <= diff_47 [M -1] ;
    tran_state_48 [wptr] <= diff_48 [M -1] ;
    tran_state_49 [wptr] <= diff_49 [M -1] ;
    tran_state_50 [wptr] <= diff_50 [M -1] ;
    tran_state_51 [wptr] <= diff_51 [M -1] ;
    tran_state_52 [wptr] <= diff_52 [M -1] ;
    tran_state_53 [wptr] <= diff_53 [M -1] ;
    tran_state_54 [wptr] <= diff_54 [M -1] ;
    tran_state_55 [wptr] <= diff_55 [M -1] ;
    tran_state_56 [wptr] <= diff_56 [M -1] ;
    tran_state_57 [wptr] <= diff_57 [M -1] ;
    tran_state_58 [wptr] <= diff_58 [M -1] ;
    tran_state_59 [wptr] <= diff_59 [M -1] ;
    tran_state_60 [wptr] <= diff_60 [M -1] ;
    tran_state_61 [wptr] <= diff_61 [M -1] ;
    tran_state_62 [wptr] <= diff_62 [M -1] ;
    tran_state_63 [wptr] <= diff_63 [M -1] ;
  end
  
always @ (posedge clk or negedge nrst)
  if (~nrst)
  begin
    trace <= 1'b0 ;
    cnt <= 0 ;
    trace_start_wptr <= 0 ;
  end
  else if (packet_start)
  begin
    trace <= 1'b0 ;
    cnt <= 0 ;
  end
  else if (dv_in_gate)
  begin
    if (cnt == L-1)
    begin
      trace <= 1'b1 ;
      trace_start_wptr <= wptr ;
      cnt <= C ;
    end
    else
    begin
      trace <= 1'b0 ;
      cnt <= cnt + 1 ;
    end
  end
  else if (trace2)
    trace_start_wptr <= last_wptr ;
  else
    trace <= 1'b0 ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
  begin
    flush_en <= 1'b0 ;
    flush_cnt <= 0 ;
  end
  else if (packet_end)
  begin
    flush_en <= 1 ;
    flush_cnt <= 0 ;
  end
  else if (flush_en)
  begin
    if (flush_cnt == 63)
      flush_en <= 1'b0 ;
    else
      flush_cnt <= flush_cnt + 1 ; 
  end

assign flush = flush_cnt == 60 ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
    done_i <= 1'b0 ;
  else if (packet_start)
    done_i <= 1'b0 ;
  //else if (packet_end && cnt == L-1)
  else if (trace2 & last_cnt_next[LW-1])
    done_i <= 1'b1 ;
  else if (last_trace_d3)
    done_i <= 1'b1 ;


always @ (posedge clk or negedge nrst)
  if (~nrst)
    last_trace <= 1'b0 ;
  else if (packet_start)
    last_trace <= 1'b0 ;
  else if (flush && trace_done && cnt !=L-1 )
    last_trace <= 1'b1 ;

always @ (posedge clk)
  last_trace_s0 <= last_trace ;

assign trace2 = ~last_trace_s0 & last_trace ;
assign trace_pos_i = trace | trace2 ;

always @ (posedge clk or negedge nrst)
  if (~nrst)
  begin
    trace2_s1 <= 1'b0 ;
    trace2_s2 <= 1'b0 ;
  end
  else
  begin
    trace2_s1 <= trace2 ;
    trace2_s2 <= trace2_s1 ;
  end


always @ (posedge clk)
begin
  trace_pos_s0 <= trace_pos_i ;
  trace_pos <= trace_pos_s0 ;
end

always @ (posedge clk or negedge nrst)
  if(~nrst)
    last_trace_num <= 0 ;
  else
  begin
    if (packet_start)
      last_trace_num <= 0 ;
    else if (trace2)
      last_trace_num <= L -cnt  ;
    else if (last_trace_d0)
      last_trace_num <= last_trace_num + R ;
  end

always @ (posedge clk)
begin
  last_trace_d0 <= last_trace & trace_done_pos ;
  last_trace_d1 <= last_trace_d0 ;
  last_trace_d2 <= last_trace_d1 ;
  last_trace_d3 <= last_trace_d2 ;
  last_trace_d4 <= last_trace_d3 ;
  last_trace_d5 <= last_trace_d4 ;
end

assign last_cnt_next = last_cnt - R ;

always @ (posedge clk or negedge nrst)
  if(~nrst)
  begin
    one_more_out <= 1'b0 ;
    last_cnt <= 0 ;
  end
  else
  begin
    if (packet_start)
    begin
      one_more_out <= 1'b0 ;
      last_cnt <= 0 ;
    end
    else if (flush)
      last_cnt <= cnt ;
    else if (last_trace_d5)
    begin
      if (~last_cnt_next[LW-1])
      begin
        last_cnt <= last_cnt_next ;
        one_more_out <= 1'b1 ;
      end
    end
    else
      one_more_out <= 1'b0 ;
  end

always @ (posedge clk or negedge nrst)
  if (~nrst)
    trace_en <= 0 ;
  else if (packet_start)
    trace_en <= 0 ;
  else if (trace_pos)
    trace_en <= 1'b1 ;
  else if (trace_cnt == L-2)
    trace_en <= 1'b0 ;
    
always @ (posedge clk or negedge nrst)
  if (~nrst)
    trace_cnt <= 0 ;
  else if (trace_pos)
    trace_cnt <= 0 ;
  else if (trace_en)
    trace_cnt <= trace_cnt + 2; 
    
assign trace_done = trace_cnt == L ;

always @ (posedge clk)
  trace_done_s0 <= trace_done ;
assign trace_done_pos = ~trace_done_s0 & trace_done ;

//==============================
// Get max metric
//==============================
max_metric #(M, K) max_metric_0 (
        .clk    (clk        ),
        .a      (metric_0   ), 
        .b      (metric_1   ), 
        .c      (metric_2   ), 
        .d      (metric_3   ), 
        .sa     (6'd0       ), 
        .sb     (6'd1       ), 
        .sc     (6'd2       ), 
        .sd     (6'd3       ), 
        .state  (state_0    ), 
        .max    (max_0      )
        ) ;
        
//==============================
// Get max metric
//==============================
max_metric #(M, K) max_metric_1 (
        .clk    (clk        ),
        .a      (metric_4   ), 
        .b      (metric_5   ), 
        .c      (metric_6   ), 
        .d      (metric_7   ), 
        .sa     (6'd4       ), 
        .sb     (6'd5       ), 
        .sc     (6'd6       ), 
        .sd     (6'd7       ), 
        .state  (state_1    ), 
        .max    (max_1      )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_2 (
        .clk    (clk        ),
        .a      (metric_8   ), 
        .b      (metric_9   ), 
        .c      (metric_10  ), 
        .d      (metric_11  ), 
        .sa     (6'd8       ), 
        .sb     (6'd9       ), 
        .sc     (6'd10      ), 
        .sd     (6'd11      ), 
        .state  (state_2    ), 
        .max    (max_2      )
        ) ;   

//==============================
// Get max metric
//==============================
max_metric #(M, K) max_metric_3 (
        .clk    (clk        ),
        .a      (metric_12  ), 
        .b      (metric_13  ), 
        .c      (metric_14  ), 
        .d      (metric_15  ), 
        .sa     (6'd12      ), 
        .sb     (6'd13      ), 
        .sc     (6'd14      ), 
        .sd     (6'd15      ), 
        .state  (state_3    ), 
        .max    (max_3      )
        ) ;

//==============================
// Get max metric
//==============================
max_metric #(M, K) max_metric_4 (
        .clk    (clk        ),
        .a      (metric_16  ), 
        .b      (metric_17  ), 
        .c      (metric_18  ), 
        .d      (metric_19  ), 
        .sa     (6'd16      ), 
        .sb     (6'd17      ), 
        .sc     (6'd18      ), 
        .sd     (6'd19      ), 
        .state  (state_4    ), 
        .max    (max_4      )
        ) ;

//==============================
// Get max metric
//==============================
max_metric #(M, K) max_metric_5 (
        .clk    (clk        ),
        .a      (metric_20  ), 
        .b      (metric_21  ), 
        .c      (metric_22  ), 
        .d      (metric_23  ), 
        .sa     (6'd20      ), 
        .sb     (6'd21      ), 
        .sc     (6'd22      ), 
        .sd     (6'd23      ), 
        .state  (state_5    ), 
        .max    (max_5      )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_6 (
        .clk    (clk        ),
        .a      (metric_24  ), 
        .b      (metric_25  ), 
        .c      (metric_26  ), 
        .d      (metric_27  ), 
        .sa     (6'd24      ), 
        .sb     (6'd25      ), 
        .sc     (6'd26      ), 
        .sd     (6'd27      ), 
        .state  (state_6    ), 
        .max    (max_6      )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_7 (
        .clk    (clk        ),
        .a      (metric_28  ), 
        .b      (metric_29  ), 
        .c      (metric_30  ), 
        .d      (metric_31  ), 
        .sa     (6'd28      ), 
        .sb     (6'd29      ), 
        .sc     (6'd30      ), 
        .sd     (6'd31      ), 
        .state  (state_7    ), 
        .max    (max_7      )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_8 (
        .clk    (clk        ),
        .a      (metric_32  ), 
        .b      (metric_33  ), 
        .c      (metric_34  ), 
        .d      (metric_35  ), 
        .sa     (6'd32      ), 
        .sb     (6'd33      ), 
        .sc     (6'd34      ), 
        .sd     (6'd35      ), 
        .state  (state_8    ), 
        .max    (max_8      )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_9 (
        .clk    (clk        ),
        .a      (metric_36  ), 
        .b      (metric_37  ), 
        .c      (metric_38  ), 
        .d      (metric_39  ), 
        .sa     (6'd36      ), 
        .sb     (6'd37      ), 
        .sc     (6'd38      ), 
        .sd     (6'd39      ), 
        .state  (state_9    ), 
        .max    (max_9      )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_10 (
        .clk    (clk        ),
        .a      (metric_40  ), 
        .b      (metric_41  ), 
        .c      (metric_42  ), 
        .d      (metric_43  ), 
        .sa     (6'd40      ), 
        .sb     (6'd41      ), 
        .sc     (6'd42      ), 
        .sd     (6'd43      ), 
        .state  (state_10   ), 
        .max    (max_10     )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_11 (
        .clk    (clk        ),
        .a      (metric_44  ), 
        .b      (metric_45  ), 
        .c      (metric_46  ), 
        .d      (metric_47  ), 
        .sa     (6'd44      ), 
        .sb     (6'd45      ), 
        .sc     (6'd46      ), 
        .sd     (6'd47      ), 
        .state  (state_11   ), 
        .max    (max_11     )
        ) ;

//==============================
// Get max metric
//==============================
max_metric #(M, K) max_metric_12 (
        .clk    (clk        ),
        .a      (metric_48  ), 
        .b      (metric_49  ), 
        .c      (metric_50  ), 
        .d      (metric_51  ), 
        .sa     (6'd48      ), 
        .sb     (6'd49      ), 
        .sc     (6'd50      ), 
        .sd     (6'd51      ), 
        .state  (state_12   ), 
        .max    (max_12     )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_13 (
        .clk    (clk        ),
        .a      (metric_52  ), 
        .b      (metric_53  ), 
        .c      (metric_54  ), 
        .d      (metric_55  ), 
        .sa     (6'd52      ), 
        .sb     (6'd53      ), 
        .sc     (6'd54      ), 
        .sd     (6'd55      ), 
        .state  (state_13   ), 
        .max    (max_13     )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_14 (
        .clk    (clk        ),
        .a      (metric_56  ), 
        .b      (metric_57  ), 
        .c      (metric_58  ), 
        .d      (metric_59  ), 
        .sa     (6'd56      ), 
        .sb     (6'd57      ), 
        .sc     (6'd58      ), 
        .sd     (6'd59      ), 
        .state  (state_14   ), 
        .max    (max_14     )
        ) ;        

//==============================
// Get max metric
//==============================
max_metric #(M, K) max_metric_15 (
        .clk    (clk        ),
        .a      (metric_60  ), 
        .b      (metric_61  ), 
        .c      (metric_62  ), 
        .d      (metric_63  ), 
        .sa     (6'd60      ), 
        .sb     (6'd61      ), 
        .sc     (6'd62      ), 
        .sd     (6'd63      ), 
        .state  (state_15    ), 
        .max    (max_15      )
        ) ;
        
//==============================
// Get max metric
//==============================
max_metric #(M, K) max_metric_s1_0 (
        .clk    (clk        ),
        .a      (max_0      ), 
        .b      (max_1      ), 
        .c      (max_2      ), 
        .d      (max_3      ), 
        .sa     (state_0    ), 
        .sb     (state_1    ), 
        .sc     (state_2    ), 
        .sd     (state_3    ), 
        .state  (state_s1_0 ), 
        .max    (max_s1_0   )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_s1_1 (
        .clk    (clk        ),
        .a      (max_4      ), 
        .b      (max_5      ), 
        .c      (max_6      ), 
        .d      (max_7      ), 
        .sa     (state_4    ), 
        .sb     (state_5    ), 
        .sc     (state_6    ), 
        .sd     (state_7    ), 
        .state  (state_s1_1 ), 
        .max    (max_s1_1   )
        ) ;

//==============================
// Get max metric
//==============================
max_metric #(M, K) max_metric_s1_2 (
        .clk    (clk        ),
        .a      (max_8      ), 
        .b      (max_9      ), 
        .c      (max_10     ), 
        .d      (max_11     ), 
        .sa     (state_8    ), 
        .sb     (state_9    ), 
        .sc     (state_10   ), 
        .sd     (state_11   ), 
        .state  (state_s1_2 ), 
        .max    (max_s1_2   )
        ) ;

//==============================
// Get max metric
//==============================        
max_metric #(M, K) max_metric_s1_3 (
        .clk    (clk        ),
        .a      (max_12     ), 
        .b      (max_13     ), 
        .c      (max_14     ), 
        .d      (max_15     ), 
        .sa     (state_12   ), 
        .sb     (state_13   ), 
        .sc     (state_14   ), 
        .sd     (state_15   ), 
        .state  (state_s1_3 ), 
        .max    (max_s1_3   )
        ) ;

//==============================
// Get max metric
//==============================
max_metric_logic #(M, K) max_metric_s2_0 (
        .a      (max_s1_0    ), 
        .b      (max_s1_1    ), 
        .c      (max_s1_2    ), 
        .d      (max_s1_3    ), 
        .sa     (state_s1_0  ), 
        .sb     (state_s1_1  ), 
        .sc     (state_s1_2  ), 
        .sd     (state_s1_3  ), 
        .state  (state_s2_0  ), 
        .max    (            )
        ) ;

assign init_state_i = state_s2_0 ;

always @ (posedge clk or negedge nrst)
  if(~nrst)
    trace_state <= 0 ;
  else
  begin
    if (trace_pos)
    begin
      if(zero_tail & trace2_s2)
        trace_state <= 0 ;
      else
        trace_state <= init_state_i ;
    end
    else if (trace_en)
      trace_state <= next_state ;
  end

assign  trace_start_pos = trace_start_wptr ;

assign trace_start_pos0 = trace_start_pos - trace_cnt ;
assign trace_start_pos1 = trace_start_pos - trace_cnt -1 ;

assign cur_state0 = trace_state ;

assign tran_all_0 = {
                     tran_state_63[trace_start_pos0], tran_state_62[trace_start_pos0], tran_state_61[trace_start_pos0], tran_state_60[trace_start_pos0], 
                     tran_state_59[trace_start_pos0], tran_state_58[trace_start_pos0], tran_state_57[trace_start_pos0], tran_state_56[trace_start_pos0], 
                     tran_state_55[trace_start_pos0], tran_state_54[trace_start_pos0], tran_state_53[trace_start_pos0], tran_state_52[trace_start_pos0], 
                     tran_state_51[trace_start_pos0], tran_state_50[trace_start_pos0], tran_state_49[trace_start_pos0], tran_state_48[trace_start_pos0],
                     
                     tran_state_47[trace_start_pos0], tran_state_46[trace_start_pos0], tran_state_45[trace_start_pos0], tran_state_44[trace_start_pos0], 
                     tran_state_43[trace_start_pos0], tran_state_42[trace_start_pos0], tran_state_41[trace_start_pos0], tran_state_40[trace_start_pos0], 
                     tran_state_39[trace_start_pos0], tran_state_38[trace_start_pos0], tran_state_37[trace_start_pos0], tran_state_36[trace_start_pos0], 
                     tran_state_35[trace_start_pos0], tran_state_34[trace_start_pos0], tran_state_33[trace_start_pos0], tran_state_32[trace_start_pos0],
                     
                     tran_state_31[trace_start_pos0], tran_state_30[trace_start_pos0], tran_state_29[trace_start_pos0], tran_state_28[trace_start_pos0], 
                     tran_state_27[trace_start_pos0], tran_state_26[trace_start_pos0], tran_state_25[trace_start_pos0], tran_state_24[trace_start_pos0], 
                     tran_state_23[trace_start_pos0], tran_state_22[trace_start_pos0], tran_state_21[trace_start_pos0], tran_state_20[trace_start_pos0], 
                     tran_state_19[trace_start_pos0], tran_state_18[trace_start_pos0], tran_state_17[trace_start_pos0], tran_state_16[trace_start_pos0],

                     tran_state_15[trace_start_pos0], tran_state_14[trace_start_pos0], tran_state_13[trace_start_pos0], tran_state_12[trace_start_pos0], 
                     tran_state_11[trace_start_pos0], tran_state_10[trace_start_pos0], tran_state_9[trace_start_pos0], tran_state_8[trace_start_pos0], 
                     tran_state_7[trace_start_pos0], tran_state_6[trace_start_pos0], tran_state_5[trace_start_pos0], tran_state_4[trace_start_pos0], 
                     tran_state_3[trace_start_pos0], tran_state_2[trace_start_pos0], tran_state_1[trace_start_pos0], tran_state_0[trace_start_pos0]} ;

assign tran_all_1 =  {
                     tran_state_63[trace_start_pos1], tran_state_62[trace_start_pos1], tran_state_61[trace_start_pos1], tran_state_60[trace_start_pos1], 
                     tran_state_59[trace_start_pos1], tran_state_58[trace_start_pos1], tran_state_57[trace_start_pos1], tran_state_56[trace_start_pos1], 
                     tran_state_55[trace_start_pos1], tran_state_54[trace_start_pos1], tran_state_53[trace_start_pos1], tran_state_52[trace_start_pos1], 
                     tran_state_51[trace_start_pos1], tran_state_50[trace_start_pos1], tran_state_49[trace_start_pos1], tran_state_48[trace_start_pos1],
                     
                     tran_state_47[trace_start_pos1], tran_state_46[trace_start_pos1], tran_state_45[trace_start_pos1], tran_state_44[trace_start_pos1], 
                     tran_state_43[trace_start_pos1], tran_state_42[trace_start_pos1], tran_state_41[trace_start_pos1], tran_state_40[trace_start_pos1], 
                     tran_state_39[trace_start_pos1], tran_state_38[trace_start_pos1], tran_state_37[trace_start_pos1], tran_state_36[trace_start_pos1], 
                     tran_state_35[trace_start_pos1], tran_state_34[trace_start_pos1], tran_state_33[trace_start_pos1], tran_state_32[trace_start_pos1],
                     
                     tran_state_31[trace_start_pos1], tran_state_30[trace_start_pos1], tran_state_29[trace_start_pos1], tran_state_28[trace_start_pos1], 
                     tran_state_27[trace_start_pos1], tran_state_26[trace_start_pos1], tran_state_25[trace_start_pos1], tran_state_24[trace_start_pos1], 
                     tran_state_23[trace_start_pos1], tran_state_22[trace_start_pos1], tran_state_21[trace_start_pos1], tran_state_20[trace_start_pos1], 
                     tran_state_19[trace_start_pos1], tran_state_18[trace_start_pos1], tran_state_17[trace_start_pos1], tran_state_16[trace_start_pos1],

                     tran_state_15[trace_start_pos1], tran_state_14[trace_start_pos1], tran_state_13[trace_start_pos1], tran_state_12[trace_start_pos1], 
                     tran_state_11[trace_start_pos1], tran_state_10[trace_start_pos1], tran_state_9[trace_start_pos1], tran_state_8[trace_start_pos1], 
                     tran_state_7[trace_start_pos1], tran_state_6[trace_start_pos1], tran_state_5[trace_start_pos1], tran_state_4[trace_start_pos1], 
                     tran_state_3[trace_start_pos1], tran_state_2[trace_start_pos1], tran_state_1[trace_start_pos1], tran_state_0[trace_start_pos1]} ;


assign cur_state1 = get_next_trace_state (cur_state0, tran_all_0) ;
assign next_state = get_next_trace_state (cur_state1, tran_all_1) ;

assign state0_bit = cur_state0 [K -2] ;
assign state1_bit = cur_state1 [K -2] ;

always @ (posedge clk or negedge nrst)
  if(~nrst)
    res <= 0 ;
  else
  begin
    if (trace_pos)
      res <= 0 ;
    else if (trace_en)
    begin
      res <= {state1_bit, state0_bit, res [L-1:2]} ;
    end
  end

//======================================
// function: get_next_trace_state
//====================================== 
function [K-2:0] get_next_trace_state ;
input   [K-2:0]     cur_state_in ;
input   [N -1:0]    tran_state_in ;
reg     [N -1:0]    tmp ;
begin
  tmp = tran_state_in >> cur_state_in ;
  get_next_trace_state = {cur_state_in [K-3:0], tmp[0]} ;
end
endfunction

endmodule


