//
//  NSMutableArray+Shuffle.m
//  MasterFretboard
//
//  Created by Xinrong Guo on 12-12-23.
//
//

#import "NSMutableArray+Shuffle.h"

@implementation NSMutableArray (Shuffle)

- (void)shuffle {
    for (unsigned i = 0; i < self.count; ++i)
    {
        // Select a random element between i and end of array to swap with.
        unsigned nElements = (unsigned)self.count - i;
        unsigned n = arc4random_uniform(nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end
