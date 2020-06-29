TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = hapticoprefs

hapticoprefs_FILES = V8PRootListController.m
hapticoprefs_FRAMEWORKS = UIKit
hapticoprefs_PRIVATE_FRAMEWORKS = Preferences
hapticoprefs_INSTALL_PATH = /Library/PreferenceBundles
hapticoprefs_CFLAGS = -fobjc-arc
$(BUNDLE_NAME)_EXTRA_FRAMEWORKS += Cephei CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk
