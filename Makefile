PODS_ROOT=Pods/

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
	curl -sL https://github.com/zoom/zoom-sdk-ios/releases/download/v4.6.21666.0428/ios-mobilertc-all-4.6.21666.0428-n.zip -o zoom-sdk-simulator.zip; \
	curl -sL https://api.github.com/repos/zoom/zoom-sdk-ios/zipball/v4.6.21666.0428 -o zoom-sdk-device.zip; \
	unzip -qq zoom-sdk-simulator.zip -d zoom-sdk-simulator; \
	unzip -qq zoom-sdk-device.zip -d zoom-sdk-device; \
	$(call popd);

