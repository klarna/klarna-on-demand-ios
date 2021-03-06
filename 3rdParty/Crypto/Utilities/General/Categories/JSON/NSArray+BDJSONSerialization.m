//
//  Created by Patrick Hogan/Manuel Zamora 2012
//


////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Interface
////////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "NSArray+BDJSONSerialization.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Utilities
////////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "BDJSONError.h"


////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Implementation
////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NSArray (BDJSONSerialization)


////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Serialization
////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)stringValue:(BDError *)error
{
    NSData *data = [self dataValue:error];
    return [[NSString alloc] initWithData:data
                                 encoding:NSUTF8StringEncoding];
}


- (NSData *)dataValue:(BDError *)error
{
    NSError *JSONError = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:kNilOptions
                                                     error:&JSONError];
    
    if (!data)
    {
        [error addErrorWithType:BDJSONErrorParse
                          errorClass:[BDJSONError class]];
    }
    
    return data;
}


@end
