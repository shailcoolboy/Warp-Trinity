CC=gcc
CFLAGS=-c -Wall
LDFLAGS=-lpcap
SOURCES=ber_processor.c
INCLUDES=ber_processor.h
OBJECTS=$(SOURCES:.c=.o)
EXECUTABLE=ber_processor

all: $(SOURCES) $(EXECUTABLE) $(INCLUDES)
	
$(EXECUTABLE): $(OBJECTS) $(INCLUDES)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@
.c.o: $(INCLUDES)
	$(CC) $(CFLAGS) $< -o $@
