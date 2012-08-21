library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;									 

Library XilinxCoreLib;
use XilinxCoreLib.all;

library unisim ;
use unisim.vcomponents.all ;


entity linkport is
	port(
		-- TX port
		tx_data :in std_logic_vector(15 downto 0);
		tx_clk  :in std_logic;
		tx_wr :in std_logic;
		tx_first :in std_logic;
		tx_last :in std_logic;
		tx_rdy :out std_logic;
		link_en :in std_logic;
		
		-- RX port
		rx_clk :in std_logic;
		rx_drdy :out std_logic;
		rx_first :out std_logic;
		rx_last :out std_logic;
		rx_data :out std_logic_vector(15 downto 0);
		
		-- Flow control port
		fc_req :in std_logic;
		fc_nb :in std_logic_vector(3 downto 0);
		fc_ack :out std_logic;
		
		-- MGT clk source
		top_ref_clk_i :in std_logic;
		user_clk_i :in std_logic;
		
		-- MGT port
		mgt_rxp :in std_logic;
		mgt_rxn :in std_logic;
		mgt_txp :out std_logic;
		mgt_txn :out std_logic;
		
		-- System input
		grst :in std_logic;
		mgt_pwdn :in std_logic);
End Entity;


architecture linkport_b1 of linkport is						 
	
	-- Native Flow Control Interface
	signal            nfc_req_n_i	:std_logic;
	signal		    nfc_nb_i		:std_logic_vector(3 downto 0);
	signal            nfc_ack_n_i	:std_logic;
	
	-- MGT Reference Clock Interface

	
	-- Error Detection Interface
	signal            hard_error_i :std_logic;
	signal            soft_error_i :std_logic;
	signal            frame_error_i :std_logic;
	
	-- Status
	signal            channel_up_i :std_logic;
	signal            lane_up_i :std_logic;
	
	-- Clock Compensation Control Interface
	signal            warn_cc_i :std_logic;
	signal            do_cc_i :std_logic;
	
	-- System Interface
	signal            dcm_not_locked_i:std_logic;

	signal            power_down_i:std_logic;
	signal     		loopback_i:std_logic_vector(1 downto 0);
	
	signal            tx_ff_rd:std_logic ;     
	signal            tx_ff_wr :std_logic;    
	signal            tx_ff_almost_empty:std_logic ;
	signal            tx_ff_almost_full :std_logic; 
	signal     		tx_ff_wdata:std_logic_vector(17 downto 0) ;
	signal   			tx_ff_rdata:std_logic_vector(17 downto  0) ;        
	signal            tx_ff_empty:std_logic ;       
	signal            tx_ff_full :std_logic;       
	
	signal     		rx_ff_wdata:std_logic_vector(17 downto 0) ;
	signal     		rx_ff_rdata:std_logic_vector(17 downto 0) ;
	signal            rx_ff_wr :std_logic;           
	signal            rx_ff_rd:std_logic ;           
	signal            rx_ff_almost_empty:std_logic ; 
	signal            rx_ff_almost_full:std_logic ;  
	signal            rx_ff_empty:std_logic ;       
	signal            rx_ff_full:std_logic ;         
	
	signal            mgt_reset:std_logic ;
	signal            tx_reset:std_logic;
	
	signal            aur_tx_sof_1:std_logic;    
	signal            aur_tx_eof_1:std_logic ;    
	signal   			aur_tx_data:std_logic_vector(15 downto 0) ;    
	signal            aur_tx_rem:std_logic ;     
	signal            aur_tx_src_rdy_1:std_logic ;
	signal            aur_tx_dst_rdy_1:std_logic ;
	
	signal 			aur_rx_data :std_logic_vector(15 downto 0);
	signal            aur_rx_sof_1:std_logic ;    
	signal            aur_rx_eof_1 :std_logic;    
	signal            aur_rx_src_rdy_1:std_logic ;
	signal            aur_rx_rem:std_logic ;     																				  															 
	
	
	
	component fifo_64x18 IS
		port (
			din: IN std_logic_VECTOR(17 downto 0);
			rd_clk: IN std_logic;
			rd_en: IN std_logic;
			rst: IN std_logic;
			wr_clk: IN std_logic;
			wr_en: IN std_logic;
			almost_empty: OUT std_logic;
			almost_full: OUT std_logic;
			dout: OUT std_logic_VECTOR(17 downto 0);
			empty: OUT std_logic;
			full: OUT std_logic);
	END component;	 
	
	component tx_ff_ctrl is
		port (
			tx_wr : in std_logic;
			tx_wdata  :in std_logic_vector(15 downto 0);
			tx_rdy :out std_logic ;
			tx_first  :in std_logic;
			tx_last :in std_logic ;
			tx_en :in std_logic ;
			
			tx_ff_wr  :out std_logic;
			tx_ff_full :in std_logic ;       
			tx_ff_wdata :out std_logic_vector(17 downto 0) ;
			tx_ff_almost_full : in std_logic;
			aur_lane_up :in std_logic 
			);
	end component;						 
	
	
	
	component rx_ff_ctrl is
		port (
			
			rx_en : in std_logic;
			aur_rx_src_rdy_1  : in std_logic;
			aur_rx_data  :in std_logic_vector(15 downto 0);
			aur_rx_sof_1 :in std_logic;
			aur_rx_eof_1:in std_logic;
			rx_ff_wr  :out std_logic;
			rx_ff_wdata :out std_logic_vector(17 downto 0);
			
			rx_ff_empty :in std_logic; 
			rx_ff_rdata :in std_logic_vector(17 downto 0); 
			rx_drdy :out std_logic;     
			rx_first  :out std_logic;
			rx_last  :out std_logic;    
			rx_data : out std_logic_vector(15 downto 0);     
			rx_ff_rd :out std_logic
			);
	end component;
	
	
	component aurora_tx_ctrl is
		port (					 
			tx_ff_empty: in std_logic;
			tx_ff_rd :out std_logic;
			tx_ff_rdata : in std_logic_vector(17 downto 0);
			
			aur_tx_sof_1 : out std_logic;
			aur_tx_eof_1: out std_logic ;
			aur_tx_data : out std_logic_vector(15 downto 0);
			aur_tx_rem: out std_logic ;
			aur_tx_src_rdy_1: out std_logic ;
			aur_tx_dst_rdy_1: in std_logic 
			
			);
	end component;
	
	
	component aurora_16b is
		generic (                    
			EXTEND_WATCHDOGS   : boolean := FALSE
			);
		port (
			
			-- LocalLink TX Interface
			
			TX_D             : in std_logic_vector(0 to 15);
			TX_REM           : in std_logic;
			TX_SRC_RDY_N     : in std_logic;
			TX_SOF_N         : in std_logic;
			TX_EOF_N         : in std_logic;
			TX_DST_RDY_N     : out std_logic;
			
			-- LocalLink RX Interface
			
			RX_D             : out std_logic_vector(0 to 15);
			RX_REM           : out std_logic;
			RX_SRC_RDY_N     : out std_logic;
			RX_SOF_N         : out std_logic;
			RX_EOF_N         : out std_logic;
			
			-- Native Flow Control Interface
			
			NFC_REQ_N        : in std_logic;
			NFC_NB           : in std_logic_vector(0 to 3);
			NFC_ACK_N        : out std_logic;
			
			-- MGT Serial I/O
			
			RXP              : in std_logic;
			RXN              : in std_logic;
			
			TXP              : out std_logic;
			TXN              : out std_logic;
			
			-- MGT Reference Clock Interface
			
			TOP_BREF_CLK     : in std_logic;
			
			-- Error Detection Interface
			
			HARD_ERROR       : out std_logic;
			SOFT_ERROR       : out std_logic;
			FRAME_ERROR      : out std_logic;
			
			-- Status
			
			CHANNEL_UP       : out std_logic;
			LANE_UP          : out std_logic;
			
			-- Clock Compensation Control Interface
			
			WARN_CC          : in std_logic;
			DO_CC            : in std_logic;
			
			-- System Interface
			
			DCM_NOT_LOCKED   : in std_logic;
			USER_CLK         : in std_logic;
			RESET            : in std_logic;
			POWER_DOWN       : in std_logic;
			LOOPBACK         : in std_logic_vector(1 downto 0)
			
			);
		
	end component;
	
	
	component reset_gen is
		port (
			
			reset_in : in std_logic;
			clk : in std_logic;
			reset_out : out std_logic
			
			);
	end component;		   
	
	
	component STANDARD_CC_MODULE is
		port
			(    
			-- Clock Compensation Control Interface
			WARN_CC        : out std_logic;
			DO_CC          : out std_logic;
			
			
			-- System Interface
			DCM_NOT_LOCKED : in std_logic;
			USER_CLK       : in std_logic;
			CHANNEL_UP     : in std_logic
			
			);				   
	end component;			  
	
	component aurora_ctrl is
		port (					 
			pwdn_in : in std_logic ;
			user_clk : in std_logic ;
			dcm_not_locked  : out std_logic;
			loopback : out std_logic_vector(1 downto 0);
			power_down : out std_logic;
			nfc_req_1 : out std_logic ;
			nfc_nb  : out std_logic_vector(3 downto 0)
			);
	end component;
	
begin
	
	
	
	-- TX FIFO 64x18 bit				 
	TX_FIFO_64x18_I : fifo_64x18
	port map
		(
		
		-- write port
		wr_clk           => tx_clk               ,  --IN
		wr_en            => tx_ff_wr             ,  --IN
		din              => tx_ff_wdata          ,  --IN[17:0]
		-- read port
		rd_clk           => user_clk_i          ,  --IN
		rd_en            => tx_ff_rd             ,  --IN
		dout             => tx_ff_rdata          ,  --OUT[17:0]
		-- flag
		almost_empty     => tx_ff_almost_empty   ,  --OUT
		almost_full      => tx_ff_almost_full    ,  --OUT
		empty            => tx_ff_empty          ,  --OUT
		full            =>tx_ff_full           ,  --OUT
		-- reset
		rst              =>grst                    --IN
		);
	
	
	
	
	-- TX FIFO control
	TX_FF_CTRL_I : tx_ff_ctrl 
	port map(
		tx_wr              =>tx_wr              ,  --IN
		tx_wdata           =>tx_data            ,  --IN[15:0]
		tx_rdy             =>tx_rdy             ,  --OUT
		tx_first           =>tx_first           ,  --IN
		tx_last            =>tx_last            ,  --IN
		tx_en              =>link_en            ,  --IN
		
		tx_ff_wr           =>tx_ff_wr           ,  --IN
		tx_ff_full         =>tx_ff_full         ,  --IN
		tx_ff_almost_full  =>tx_ff_almost_full  ,  --IN
		tx_ff_wdata        =>tx_ff_wdata        ,  --OUT[17:0]
		aur_lane_up        =>lane_up_i             --IN
		) ;
	
	-- RX FIFO 64x18 bit
	RX_FIFO_64x18_I:	fifo_64x18 
	port map (
		-- write port
		wr_clk           => user_clk_i           ,  --IN
		wr_en            => rx_ff_wr             ,  --IN
		din              => rx_ff_wdata          ,  --IN[17:0]
		-- read port
		rd_clk           => rx_clk               ,  --IN
		rd_en            => rx_ff_rd             ,  --IN
		dout             =>rx_ff_rdata          ,  --OUT[17:0]
		-- flag
		almost_empty     =>rx_ff_almost_empty   ,  --OUT
		almost_full      =>rx_ff_almost_full    ,  --OUT
		empty            =>rx_ff_empty          ,  --OUT
		full             =>rx_ff_full           ,  --OUT
		-- reset
		rst              =>grst                 --IN
		);
	
	-- RX FIFO control
	RX_FF_CTRL_I : rx_ff_ctrl
	port map(
		rx_en          =>link_en        ,  --IN
		aur_rx_src_rdy_1=>aur_rx_src_rdy_1,  --IN
		aur_rx_sof_1    =>aur_rx_sof_1    ,  --IN
		aur_rx_eof_1    =>aur_rx_eof_1    ,  --IN 
		aur_rx_data    =>aur_rx_data    ,  --IN[15:0]
		rx_ff_wdata    =>rx_ff_wdata    ,  --OUT[17:0]
		rx_ff_wr       =>rx_ff_wr       ,  --OUT
		
		rx_drdy        =>rx_drdy        ,  --OUT
		rx_data        =>rx_data        ,  --OUT[15:0]
		rx_first       =>rx_first       ,  --OUT
		rx_last        =>rx_last        ,  --OUT
		rx_ff_rd       =>rx_ff_rd       ,  --OUT 
		rx_ff_empty    =>rx_ff_empty    ,  --IN
		rx_ff_rdata    =>rx_ff_rdata    --IN[17:0]
		) ;
	
	
	-- Aurora TX ctrl
	AURORA_TX_CTRL_I :  aurora_tx_ctrl 
	port map(
		tx_ff_rd       =>tx_ff_rd       ,  --IN 
		tx_ff_rdata    =>tx_ff_rdata    ,  --IN[17:0]
		tx_ff_empty    =>tx_ff_empty    ,  --IN
		
		aur_tx_sof_1    =>aur_tx_sof_1    ,  --OUT 
		aur_tx_eof_1    =>aur_tx_eof_1    ,  --OUT
		aur_tx_data    =>aur_tx_data    ,  --OUT[15:0] 
		aur_tx_rem     =>aur_tx_rem     ,  --OUT 
		aur_tx_src_rdy_1=>aur_tx_src_rdy_1,  --OUT 
		aur_tx_dst_rdy_1=>aur_tx_dst_rdy_1  --IN
		) ;
	
	AURORA_16B_I : aurora_16b 
	generic map(								  
		EXTEND_WATCHDOGS => FALSE
		)
	port map(
		-- LocalLink TX Interface
		TX_D           =>aur_tx_data        ,  --IN[15:0]
		TX_REM         =>aur_tx_rem         ,  --IN
		TX_SRC_RDY_N   =>aur_tx_src_rdy_1    ,  --IN
		TX_SOF_N       =>aur_tx_sof_1        ,  --IN
		TX_EOF_N       =>aur_tx_eof_1        ,  --IN
		
		TX_DST_RDY_N   =>aur_tx_dst_rdy_1    ,  --OUT
		
		
		-- LocalLink RX Interface
		RX_D           =>aur_rx_data        ,  --OUT[15:0]
		RX_REM         =>aur_rx_rem         ,  --OUT
		RX_SRC_RDY_N   =>aur_rx_src_rdy_1    ,  --OUT
		RX_SOF_N       =>aur_rx_sof_1        ,  --OUT
		RX_EOF_N       =>aur_rx_eof_1        ,  --OUT
		
		-- Native Flow Control Interface
		nfc_req_N      =>nfc_req_n_i        ,  --IN
		NFC_NB         =>nfc_nb_i           ,  --IN[3:0]
		NFC_ACK_N      =>nfc_ack_n_i        ,  --OUT
		
		-- MGT Serial I/O
		RXP            =>mgt_rxp            ,  --OUT
		RXN            =>mgt_rxn            ,  --OUT
		
		TXP            =>mgt_txp            ,  --IN
		TXN            =>mgt_txn            ,  --IN
		
		-- MGT Reference Clock Interface
		TOP_BREF_CLK   =>top_ref_clk_i      ,  --IN
		
		-- Error Detection Interface
		HARD_ERROR     =>hard_error_i       ,  --OUT
		SOFT_ERROR     =>soft_error_i       ,  --OUT
		FRAME_ERROR    =>frame_error_i      ,  --OUT
		
		-- Status
		CHANNEL_UP     =>channel_up_i       ,  --OUT
		LANE_UP        =>lane_up_i          ,  --OUT
		
		-- Clock Compensation Control Interface
		WARN_CC        =>warn_cc_i          ,  --IN
		DO_CC          =>do_cc_i            ,  --IN
		
		-- System Interface
		DCM_NOT_LOCKED =>dcm_not_locked_i   ,  --IN
		USER_CLK       =>user_clk_i         ,  --IN
		RESET          =>mgt_reset          ,  --IN
		POWER_DOWN     =>power_down_i       ,  --IN
		LOOPBACK       =>loopback_i           --IN
		);
	
	STANDARD_CC_MODULE_I :STANDARD_CC_MODULE
	port map(
		-- Clock Compensation Control Interface
		WARN_CC        =>warn_cc_i        ,  --OUT
		DO_CC          =>do_cc_i          ,  --OUT
		
		-- System Interface
		DCM_NOT_LOCKED =>dcm_not_locked_i , --IN
		USER_CLK       =>user_clk_i       , --IN
		CHANNEL_UP     =>channel_up_i       --IN
		);
	
	-- Reset generation
	RESET_GEN_I1 : reset_gen 
	port map(
		reset_in   =>grst       ,  --IN 
		reset_out  =>mgt_reset  ,  --OUT
		clk        =>user_clk_i   --IN
		) ;
	
	-- Reset generation
	RESET_GEN_TXCLK : reset_gen
	port map(
		reset_in   =>grst       ,  --IN 
		reset_out  =>tx_reset   ,  --OUT
		clk        =>tx_clk        --IN
		) ;
	
	
	AURORA_CTRL_I: aurora_ctrl
	port map(
		user_clk       =>user_clk_i         ,  --IN
		pwdn_in        =>mgt_pwdn           ,  --IN
		power_down     =>power_down_i       ,  --OUT
		dcm_not_locked =>dcm_not_locked_i   ,  --OUT
		loopback       =>loopback_i         ,  --OUT
		nfc_req_1       =>nfc_req_n_i        ,  --OUT
		nfc_nb         =>nfc_nb_i            --OUT[3:0]
		) ;
	
end linkport_b1;