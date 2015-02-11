#import "KODRegistrationResult.h"

SPEC_BEGIN(KODRegistrationResultSpec)

describe(@"KODRegistrationResultSpec", ^{
 describe(@"isEqual", ^{
   it(@"should return true when the tokens, phone numbers and user details are equal", ^{
     KODRegistrationResult *resultA =[[KODRegistrationResult alloc] initWithToken:@"same_token" andPhoneNumber:@"same_phoneNumber" andUserDetails:@{@"a":@1}];
     KODRegistrationResult *resultB =[[KODRegistrationResult alloc] initWithToken:@"same_token" andPhoneNumber:@"same_phoneNumber" andUserDetails:@{@"a":@1}];
     [[theValue([resultA isEqual:resultB]) should] beTrue];
   });
   
   it(@"should return false when tokens are not equal", ^{
     KODRegistrationResult *resultA =[[KODRegistrationResult alloc] initWithToken:@"same_token" andPhoneNumber:@"same_phoneNumber" andUserDetails:@{@"a":@1}];
     KODRegistrationResult *resultB =[[KODRegistrationResult alloc] initWithToken:@"not_the_same_token" andPhoneNumber:@"same_phoneNumber" andUserDetails:@{@"a":@1}];
     [[theValue([resultA isEqual:resultB]) should] beFalse];
   });
   
   it(@"should return false when the phone numbers are not equal", ^{
     KODRegistrationResult *resultA =[[KODRegistrationResult alloc] initWithToken:@"same_token" andPhoneNumber:@"same_phoneNumber" andUserDetails:@{@"a":@1}];
     KODRegistrationResult *resultB =[[KODRegistrationResult alloc] initWithToken:@"same_token" andPhoneNumber:@"not_the_same_phoneNumber" andUserDetails:@{@"a":@1}];
     [[theValue([resultA isEqual:resultB]) should] beFalse];
   });
   
   it(@"should return false when the user details are not equal", ^{
     KODRegistrationResult *resultA =[[KODRegistrationResult alloc] initWithToken:@"same_token" andPhoneNumber:@"same_phoneNumber" andUserDetails:@{@"a":@1}];
     KODRegistrationResult *resultB =[[KODRegistrationResult alloc] initWithToken:@"same_token" andPhoneNumber:@"same_phoneNumber" andUserDetails:@{@"a":@2}];
     [[theValue([resultA isEqual:resultB]) should] beFalse];
   });
 });
});

SPEC_END