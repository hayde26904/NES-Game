# Makefile for building NES game

# Compiler and linker
CC = ca65
LD = ld65

# Compiler and linker flags
CFLAGS =
LDFLAGS = -t nes

# Source file
SRC = game.s

# Target executable
TARGET = game.nes

# Build target
.PHONY: all
all: clean $(TARGET)

$(TARGET):
	$(CC) $(CFLAGS) -o $(SRC:.s=.o) $(SRC)
	$(LD) $(SRC:.s=.o) -o $(TARGET) $(LDFLAGS)

# Clean up
.PHONY: clean
clean:
	rm -f $(SRC:.s=.o) $(TARGET)
