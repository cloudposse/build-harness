BUILD_HARNESS_PATH ?= .
OS ?= $(shell uname -s | tr '[:upper:]' '[:lower:]')

include $(BUILD_HARNESS_PATH)/Makefile.*
include $(BUILD_HARNESS_PATH)/modules/*/*
