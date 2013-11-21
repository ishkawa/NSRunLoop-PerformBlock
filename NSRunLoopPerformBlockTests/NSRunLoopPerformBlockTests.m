#import <XCTest/XCTest.h>
#import "NSRunLoop+PerformBlock.h"

@interface NSRunLoopPerformBlockTests : XCTestCase

@end

@implementation NSRunLoopPerformBlockTests

- (void)testPerformBlockAndWait
{
    __block BOOL flag = NO;

    [[NSRunLoop currentRunLoop] performBlockAndWait:^(BOOL *finish) {
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_after(popTime, queue, ^(void){
            flag = YES;
            *finish = YES;
        });
    }];

    XCTAssertTrue(flag, @"flag was not set.");
}

- (void)testTimeout
{
    __block BOOL flag = NO;

    [[NSRunLoop currentRunLoop] performBlockAndWait:^(BOOL *finish) {
        double delayInSeconds = 11.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_after(popTime, queue, ^(void){
            flag = YES;
            *finish = YES;
        });
    }];

    XCTAssertFalse(flag, @"flag should not set.");
}

- (void)testInvalidTimeoutInterval
{
    XCTAssertThrows([[NSRunLoop currentRunLoop] performBlockAndWait:^(BOOL *finish) {} timeoutInterval:-10.f],
                    @"should throw invalid argument exception if timeout interval is negative value.");
}

@end
