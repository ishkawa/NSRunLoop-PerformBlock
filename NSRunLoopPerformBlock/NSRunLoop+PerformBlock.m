#import "NSRunLoop+PerformBlock.h"

@implementation NSRunLoop (PerformBlock)

- (void)performBlockAndWait:(void (^)(BOOL *))block
{
    [self performBlockAndWait:block timeoutInterval:10.0];
}

- (void)performBlockAndWait:(void (^)(BOOL *))block timeoutInterval:(NSTimeInterval)timeoutInterval
{
    if (timeoutInterval < 0.0) {
        [NSException raise:NSInvalidArgumentException format:@"%lf is invalid for timeout interval", timeoutInterval];
    }

    NSDate *startedDate = [NSDate date];
    BOOL finish = NO;

    block(&finish);

    while (!finish && [[NSDate date] timeIntervalSinceDate:startedDate] < timeoutInterval) {
        NSLog(@"%lf", [[NSDate date] timeIntervalSinceDate:startedDate]);
        @autoreleasepool {
            [self runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.1]];
        }
    }
}

@end
