test:
	xcodebuild clean build test \
		-sdk iphonesimulator \
		-workspace NSRunLoopPerformBlock.xcworkspace \
		-scheme NSRunLoopPerformBlock \
		-configuration Debug \
		OBJROOT=build \
		GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES \
		GCC_GENERATE_TEST_COVERAGE_FILES=YES
	xcodebuild clean build test \
		-sdk macosx \
		-workspace NSRunLoopPerformBlock.xcworkspace \
		-scheme NSRunLoopPerformBlock-Mac \
		-configuration Debug \
		TEST_AFTER_BUILD=YES \
		GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES \
		GCC_GENERATE_TEST_COVERAGE_FILES=YES

coveralls:
	coveralls -e NSRunLoopPerformBlockTests -e Pods

