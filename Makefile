TARGET := iphone:clang:latest:latest
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64 arm64e

THEOS_DEVICE_IP = 192.168.68.121

$(TWEAK_NAME)_FRAMEWORKS = AudioToolbox

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = vibrationsplus

vibrationsplus_FILES = Tweak.x
vibrationsplus_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
