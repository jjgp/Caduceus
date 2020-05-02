PODS_ROOT=Pods/

.PHONY:
lint:
	${PODS_ROOT}/SwiftLint/swiftlint
.PHONY:
lint-autocorrect:
	${PODS_ROOT}/SwiftLint/swiftlint autocorrect
