TARGET := iphone:clang:latest:latest
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64 arm64e

THEOS_DEVICE_IP = 192.168.68.102

$(TWEAK_NAME)_FRAMEWORKS = AudioToolbox
$(TWEAK_NAME)_EXTRA_FRAMEWORKS += Cephei

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = vibrationsplus

vibrationsplus_FILES = Tweak.x
vibrationsplus_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += vibrationsplusprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
