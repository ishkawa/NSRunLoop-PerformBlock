# NSRunLoop+PerformBlock [![Build Status](https://travis-ci.org/ishkawa/NSRunLoop-PerformBlock.png?branch=master)](https://travis-ci.org/ishkawa/NSRunLoop-PerformBlock) [![Coverage Status](https://coveralls.io/repos/ishkawa/NSRunLoop-PerformBlock/badge.png?branch=master)](https://coveralls.io/r/ishkawa/NSRunLoop-PerformBlock?branch=master)

category on NSRunLoop that adds performBlockAntWait: method.

## Requirements

- iOS 4.3 or later
- Mac OS 10.6 (Snow Leopard) or later
- ARC

## Usage

```objectivec
- (void)testPerformBlockAndWait
{
    // 1

    [[NSRunLoop currentRunLoop] performBlockAndWait:^(BOOL *finish) {
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_after(popTime, queue, ^(void){
            // 2
            *finish = YES;
        });
    }];

    // 3
}
```

## Installing

Add files under `NSRunLoopPerformBlock/` to your Xcode project.

### CocoaPods

If you use CocoaPods, you can install NSRunLoop-PerformBlock by inserting config below.

```
pod 'NSRunLoop+PerformBlock', :git => 'https://github.com/ishkawa/NSRunLoop-PerformBlock.git'
```

## License

Copyright (c) 2013-2014 Yosuke Ishikawa

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
