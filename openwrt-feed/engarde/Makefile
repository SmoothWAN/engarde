include $(TOPDIR)/rules.mk

PKG_NAME:=engarde
PKG_VERSION:=ea25ee43
PKG_RELEASE:=1.0

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=cf9b487167c826cbdcfa2fa6ae39d04fac5e9ba0
PKG_SOURCE_URL:=https://github.com/porech/engarde

PKG_BUILD_DEPENDS:=golang/host node/host
PKG_BUILD_PARALLEL:=1
MAKE_VARS += \
	GOARCH="$(GO_ARCH)"

include $(INCLUDE_DIR)/package.mk

define Package/engarde
	SECTION:=VPN
	CATEGORY:=Network
	TITLE:=A go network utility to create a reliable IP tunnel over multiple connections
	URL:=https://github.com/porech/engarde
	PKGARCH=all
endef

define Package/engarde/description
A go network utility to create a reliable IP tunnel over multiple connections
endef

#Requires packr2 and node/npm to be installed on host
define Build/Compile
	( \
		pushd $(PKG_BUILD_DIR) ; \
		cd webmanager ; \
		npm install ; \
		npm run build ; \
		cd .. ; \
		make packr ; \
		CGO_ENABLED=0 GOOS=linux ./build-scripts/build.sh server ; \
		CGO_ENABLED=0 GOOS=linux ./build-scripts/build.sh client ; \
		popd ; \
	)
endef

define Package/engarde/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/dist/linux/$(GOARCH)/engarde-client $(1)/usr/bin/engarde-client
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/dist/linux/$(GOARCH)/engarde-server $(1)/usr/bin/engarde-server
endef

$(eval $(call BuildPackage,engarde))
