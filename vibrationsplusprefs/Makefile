TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = vibrationsplusprefs

vibrationsplusprefs_FILES = V8PRootListController.m
vibrationsplusprefs_FRAMEWORKS = UIKit
vibrationsplusprefs_PRIVATE_FRAMEWORKS = Preferences
vibrationsplusprefs_INSTALL_PATH = /Library/PreferenceBundles
vibrationsplusprefs_CFLAGS = -fobjc-arc
$(BUNDLE_NAME)_EXTRA_FRAMEWORKS += Cephei CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk
