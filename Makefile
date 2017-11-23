BUILD_MAKER_PATH ?= .
OS ?= $(shell uname -s | tr '[:upper:]' '[:lower:]')
SELF ?= make

include $(BUILD_MAKER_PATH)/Makefile.*
include $(BUILD_MAKER_PATH)/modules/*/*
