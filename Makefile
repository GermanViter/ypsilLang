# Makefile for parsing project

# Compiler, flags, and libraries
CC = cc
CFLAGS = -std=c99 -Wall
LIBS = -ledit -lm

# Target executable
TARGET = parsing

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
	@# Start compilation in the background
	@$(CC) $(CFLAGS) $(SRCS) $(LIBS) -o $(TARGET) & \
	pid=$$!; \
	\
	# Progress bar animation
	@width=20; \
	spin='-\|/'; \
	i=0; \
	while kill -0 $$pid 2>/dev/null; do \
		i=$$(($$i+1)); \
		progress=$$(($$i % ($$width + 1))); \
		printf "\r["; \
		for j in $$(seq 1 $$width); do \
			if [ $$j -le $$progress ]; then \
				printf "#"; \
			else \
				printf " "; \
			fi; \
		done; \
		printf "] %c" "$${spin:$$(($$i % 4)):1}"; \
		sleep 0.1; \
	done; \
	\
	# Wait for compilation and check result
	@wait $$pid; \
	result=$$?; \
	printf "\r"; \
	if [ $$result -eq 0 ]; then \
		printf "["; \
		for j in $$(seq 1 $$width); do printf "#"; done; \
		printf "]  \n"; \
		echo "$(GREEN)Success: '$(TARGET)' has been compiled.$(NC)"; \
	else \
		printf "%*s\n" $$((width+5)) " "; \
		echo "$(RED)Error: Compilation failed.$(NC)"; \
		exit 1; \
	fi

# Rule to clean up build artifacts
clean:
	@echo "Cleaning up..."
	@rm -f $(TARGET)
	@echo "Done."
