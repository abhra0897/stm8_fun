TARGET=main

# toolchain
TOOLCHAIN_PREFIX=sdcc

CC=$(TOOLCHAIN_PREFIX)

PROGRAMMER = stlinkv2
DEVICE = stm8s003f3
MCU = stm8
MCFLAGS = -m$(MCU)


################## User Sources ####################
SRCS = src/main.c
SRCS += src/flash_driver.c
SRCS += src/spi.c

################## Objects ####################
OBJS = build/main.rel
OBJS += build/flash_driver.rel
OBJS += build/spi.rel

################## Includes ########################
INCLS = -I. -Iinc

################## Libs ########################
LDFLAGS =	-lstm8 --out-fmt-ihx
LDFLAGS += $(MCFLAGS)

################ Compiler Flags ######################
CFLAGS = --std-sdcc11
CFLAGS += $(MCFLAGS)

############# CFLAGS for Optimization ##################
#CFLAGS += -v #verbose


################### Recipe to make all (build and burn) ####################
.PHONY: all
all: build

################### Recipe to build ####################
.PHONY: build
build: build/$(TARGET).hex


################### Recipe to burn ####################
.PHONY: burn
burn:
	@echo "[Flashing] build/$(TARGET).hex"
	@stm8flash -c $(PROGRAMMER) -p $(DEVICE) -w build/$(TARGET).hex
		

################### Recipe to make .hex ####################
build/$(TARGET).hex: $(OBJS)
	@echo "[Linking] $@"
	@$(CC) $(LDFLAGS)  $^ -o $@


################### Recipe to make .rel ####################
build/%.rel: src/%.c
	@echo "[Building] $@"
	@$(CC) $(INCLS) $(CFLAGS) -c -o $@ $<

################### Recipe to clean all ####################
.PHONY: clean
clean:
	@echo "[Cleaning]"
	@rm -rf build/*