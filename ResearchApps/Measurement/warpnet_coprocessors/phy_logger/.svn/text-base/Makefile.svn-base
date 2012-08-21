CC=gcc
CFLAGS=-c -Wall
LDFLAGS=-lpcap
SOURCES=phy_logger.c
INCLUDES=phy_logger.h
OBJECTS=$(SOURCES:.c=.o)
EXECUTABLE=phy_logger

all: $(SOURCES) $(EXECUTABLE) $(INCLUDES)
	
$(EXECUTABLE): $(OBJECTS) $(INCLUDES)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@
.c.o: $(INCLUDES)
	$(CC) $(CFLAGS) $< -o $@
