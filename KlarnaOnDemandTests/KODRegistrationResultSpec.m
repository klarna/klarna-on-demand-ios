#import "KODRegistrationResult.h"

SPEC_BEGIN(KODRegistrationResultSpec)

describe(@"KODRegistrationResultSpec", ^{
 describe(@"isEqual", ^{
   it(@"should return true when tokens are equal", ^{
     KODRegistrationResult *resultA =[[KODRegistrationResult alloc] initWithToken:@"same_token"];
     KODRegistrationResult *resultB =[[KODRegistrationResult alloc] initWithToken:@"same_token"];
     [[theValue([resultA isEqual:resultB]) should] beTrue];
   });
   
   it(@"should return false when tokens are not equal", ^{
     KODRegistrationResult *resultA =[[KODRegistrationResult alloc] initWithToken:@"same_token"];
     KODRegistrationResult *resultB =[[KODRegistrationResult alloc] initWithToken:@"not_the_same_token"];
     [[theValue([resultA isEqual:resultB]) should] beFalse];
   });
 });
});

SPEC_END