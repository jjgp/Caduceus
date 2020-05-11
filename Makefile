PODS_ROOT=Pods/
ZOOM_SDK_VERSION=4.6.21666.0428

define pushd 
	command pushd $1 > /dev/null
endef

define popd
	command popd > /dev/null
endef

.PHONY:
lint:
	${PODS_ROOT}/SwiftLint/swiftlint
.PHONY:
lint_autocorrect:
	${PODS_ROOT}/SwiftLint/swiftlint autocorrect

.PHONY:
download_zoom_sdk:
	$(call pushd,vendor); \
	rm -rf zoom-sdk-*; \
	curl -sL https://github.com/zoom/zoom-sdk-ios/releases/download/v${ZOOM_SDK_VERSION}/ios-mobilertc-all-${ZOOM_SDK_VERSION}-n.zip -o zoom-sdk-simulator.zip; \
	curl -sL https://github.com/zoom/zoom-sdk-ios/archive/v${ZOOM_SDK_VERSION}.zip -o zoom-sdk-device.zip; \
	unzip -qq zoom-sdk-simulator.zip -d zoom-sdk-simulator; \
	unzip -qq zoom-sdk-device.zip 'zoom-sdk-ios-${ZOOM_SDK_VERSION}/*' -d zoom-sdk-device; \
	$(call popd);

