TARGET := iphone:clang:latest:latest
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64 arm64e

THEOS_DEVICE_IP = 192.168.68.102

Haptico_FRAMEWORKS = AudioToolbox
Haptico_EXTRA_FRAMEWORKS += Cephei

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Haptico

Haptico_FILES = Tweak.x
Haptico_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += hapticoprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
