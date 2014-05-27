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

    XCTAssertTrue(flag);
}

- (void)testTimeout
{
    NSTimeInterval timeoutInterval = 1.0;
    
    XCTAssertThrows([[NSRunLoop currentRunLoop] performBlockAndWait:^(BOOL *finish) {
        double delayInSeconds = timeoutInterval + 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_after(popTime, queue, ^(void){
            *finish = YES;
        });
    } timeoutInterval:timeoutInterval]);
    
    XCTAssertNoThrow([[NSRunLoop currentRunLoop] performBlockAndWait:^(BOOL *finish) {
        double delayInSeconds = timeoutInterval - 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_after(popTime, queue, ^(void){
            *finish = YES;
        });
    } timeoutInterval:timeoutInterval]);
}

- (void)testInvalidTimeoutInterval
{
    XCTAssertThrows([[NSRunLoop currentRunLoop] performBlockAndWait:^(BOOL *finish) {} timeoutInterval:-1.0]);
}

- (void)testInvalidArgumentException
{
    XCTAssertThrows([[NSRunLoop currentRunLoop] performBlockAndWait:nil timeoutInterval:1.0]);
}

@end
