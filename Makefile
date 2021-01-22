install:
	swift build -c release
	install .build/release/xcscli /usr/local/bin/xcscli
