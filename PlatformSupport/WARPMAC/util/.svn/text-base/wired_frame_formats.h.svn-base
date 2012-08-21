typedef struct {
	unsigned char	version;
    unsigned char	typeOfService;
    unsigned short	length;
    unsigned short	identification;
    unsigned short	frag_offset;
    unsigned char	ttl;
    unsigned char	protocol;
    unsigned short	checksum;
    unsigned int	src_addr_ip;
    unsigned int	dest_addr_ip;
} __attribute__((packed)) ipv4_header;

typedef struct {
	unsigned short	hardware_type;
	unsigned short	protocol_type;
	unsigned char	hard_addr_len;
	unsigned char	prot_addr_len;
	unsigned short	opcode;
//	unsigned char	src_addr_mac[6];
	unsigned int	src_addr_mac_hi;
	unsigned short	src_addr_mac_lo;
	unsigned int	src_addr_ip;
//	unsigned char	dest_addr_mac[6];
	unsigned int	dest_addr_mac_hi;
	unsigned short	dest_addr_mac_lo;
	unsigned int	dest_addr_ip;
} __attribute__((packed)) arp_header;

typedef struct {
	unsigned char dest_addr_mac[6]; 
	unsigned char src_addr_mac[6];
	unsigned short ethertype;
} __attribute__((packed)) ethernet_header;

#define ETHERTYPE_ARP	0x0806
#define ETHERTYPE_IP	0x0800
