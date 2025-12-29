# Makefile for parsing project

# Compiler, flags, and libraries
CC = cc
CFLAGS = -std=c99 -Wall -g
LIBS = -ledit -lm

# Target executable
TARGET = ypsil

# Source files
SRCS = parsing.c mpc.c

# ANSI escape codes for colors
GREEN = \033[0;32m
RED   = \033[0;31m
NC    = \033[0m

# Phony targets
.PHONY: all clean

# Default target
all: $(TARGET)

# Rule to build the target executable
$(TARGET): $(SRCS)
	@echo "Compiling..."
	@$(CC) $(CFLAGS) $(SRCS) -o $(TARGET) $(LIBS) || { \
		echo "$(RED)Error: compilation failed.$(NC)"; \
		exit 1; \
	}
	@echo "$(GREEN)Success: '$(TARGET)' has been compiled.$(NC)"

# Rule to clean up build artifacts
clean:
	@echo "Cleaning up..."
	@rm -f $(TARGET)
	@echo "Done."

run:
	@./ypsil
