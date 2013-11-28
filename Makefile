test:
	xcodebuild \
		-sdk iphonesimulator \
		-scheme NSRunLoopPerformBlock \
		-configuration Debug \
		clean build test \
		GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES \
		GCC_GENERATE_TEST_COVERAGE_FILES=YES
	xcodebuild \
		-sdk macosx \
		-scheme NSRunLoopPerformBlock-Mac \
		-configuration Debug \
		clean build test \
		TEST_AFTER_BUILD=YES \
		GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES \
		GCC_GENERATE_TEST_COVERAGE_FILES=YES

coveralls:
	coveralls -e NSRunLoopPerformBlockTests

