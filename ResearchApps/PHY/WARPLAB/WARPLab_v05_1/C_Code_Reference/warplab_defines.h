// Command definitions
#define ACK 1
#define NOACK 2
#define INITIALIZE 100

//Individual radio commands start at 1000
#define RADIO1_TXEN 1001
#define RADIO2_TXEN 1002
#define RADIO3_TXEN 1003
#define RADIO4_TXEN 1004
#define RADIO1_TXDIS 1005
#define RADIO2_TXDIS 1006
#define RADIO3_TXDIS 1007
#define RADIO4_TXDIS 1008

#define RADIO1_RXEN 1009
#define RADIO2_RXEN 1010
#define RADIO3_RXEN 1011
#define RADIO4_RXEN 1012
#define RADIO1_RXDIS 1013
#define RADIO2_RXDIS 1014
#define RADIO3_RXDIS 1015
#define RADIO4_RXDIS 1016

#define RADIO1_TXDATA 1101
#define RADIO2_TXDATA 1102
#define RADIO3_TXDATA 1103
#define RADIO4_TXDATA 1104

#define RADIO1_RXDATA 1105
#define RADIO2_RXDATA 1106
#define RADIO3_RXDATA 1107
#define RADIO4_RXDATA 1108

//#define RADIO1_RSSIDATA 1109
#define RADIO2_RSSIDATA 1110
#define RADIO3_RSSIDATA 1111
//#define RADIO4_RSSIDATA 1112

#define RADIO1TXBUFF_TXEN 1113
#define RADIO2TXBUFF_TXEN 1114
#define RADIO3TXBUFF_TXEN 1115
#define RADIO4TXBUFF_TXEN 1116
#define RADIO1TXBUFF_TXDIS 1117
#define RADIO2TXBUFF_TXDIS 1118
#define RADIO3TXBUFF_TXDIS 1119
#define RADIO4TXBUFF_TXDIS 1120

#define RADIO1RXBUFF_RXEN 1121
#define RADIO2RXBUFF_RXEN 1122
#define RADIO3RXBUFF_RXEN 1123
#define RADIO4RXBUFF_RXEN 1124
#define RADIO1RXBUFF_RXDIS 1125
#define RADIO2RXBUFF_RXDIS 1126
#define RADIO3RXBUFF_RXDIS 1127
#define RADIO4RXBUFF_RXDIS 1128


//WARPLab Engine commands start at 2000
#define TX_START 2000
#define RX_START 2001
#define RX_DONEREADING 2002
#define RX_DONECHECK 2003
#define TX_STOP 2004
#define TXRX_START 2005

// AGC commands and parameters start at 3000
#define READ_AGC_DONE_ADDR 3000
#define READ_AGC_GAINS 3010
#define AGC_RESET 3020
#define SET_AGC_TARGET_dBm 3030
#define SET_AGC_NOISEEST_dBm 3040
#define SET_AGC_THRESHOLDS 3050
#define READ_AGC_THRESHOLDS 3060
#define SET_AGC_TRIG_DELAY 3070
#define SET_AGC_DCO_EN_DIS 3080
#define READ_RADIO1AGCDONERSSI 3090
#define READ_RADIO2AGCDONERSSI 3091
#define READ_RADIO3AGCDONERSSI 3092
#define READ_RADIO4AGCDONERSSI 3093


// WARPLab parameters start at 4000
//#define CAPT_OFFSET 4001
#define TX_DELAY 4001
#define TX_LENGTH 4002
#define TX_MODE 4003
#define CARRIER_CHANNEL 4004
#define RADIO1_TXGAINS 4005
#define RADIO1_RXGAINS 4006
#define RADIO2_TXGAINS 4007
#define RADIO2_RXGAINS 4008
#define RADIO3_TXGAINS 4009
#define RADIO3_RXGAINS 4010
#define RADIO4_TXGAINS 4011
#define RADIO4_RXGAINS 4012
#define MGC_AGC_SEL 4013
#define TX_LPF_CORN_FREQ 4014
#define RX_LPF_CORN_FREQ 4015



//Misc
#define TX_TEST 6000
#define RX1BUFFERS_DEBUG 6001
#define RX2BUFFERS_DEBUG 6002
#define RX3BUFFERS_DEBUG 6003
#define RX4BUFFERS_DEBUG 6004

#define CLOSE 99999
