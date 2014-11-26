//
//  InAppTests.m
//  InAppTests
//
//  Created by Guy Rozen on 11/17/2014.
//  Copyright (c) 2014 Guy Rozen. All rights reserved.
//
/*
#import "KIAContext.h"
#import "KIAUrl.h"


SHARED_EXAMPLES_BEGIN(LocaleAwareUrl)

  sharedExampleFor(@"Locale aware url",^(Class describedClass) {});
  
SHARED_EXAMPLES_END

  
SPEC_BEGIN(KIAUrlTest)

  context(@"When locale is Swedish", ^{
    beforeEach(^{
      id mainBundleMock = OCMPartialMock([NSBundle mainBundle]);
      OCMStub([mainBundleMock preferredLocalizations]).andReturn(@[@"sv"]);
    });
    
    it(@"should return a url with Swedish locale", ^{
      expect([KIAUrl registrationUrl].absoluteString).to.contain(@"locale=sv");
    });
  });
});
                  
describe(@".registrationUrl", ^{

  context(@"when token is on playground", ^{
    beforeEach(^{
      [KIAContext stub:@selector(getApiKey) andReturn:@"test_skadoo"];
    });
        
    it(@"should return a playground registration url", ^{
      [[[KIAUrl registrationUrl].absoluteString should] equal:@"https://inapp.playground.klarna.com/registration/new?api_key=test_skadoo&locale=en"];
    });
  });
    
  context(@"when token is on production", ^{
    beforeEach(^{
      [KIAContext stub:@selector(getApiKey) andReturn:@"skadoo"];
    });
        
    it(@"should return a production registration url", ^{
      [[[KIAUrl registrationUrl].absoluteString should] equal:@"https://inapp.klarna.com/registration/new?api_key=skadoo&locale=en"];
    });
  });
    
  itBehavesLike(@"Locale aware url", nil);
});

SPEC_END
*/

//
//  InAppTests.m
//  InAppTests
//
//  Created by Guy Rozen on 11/17/2014.
//  Copyright (c) 2014 Guy Rozen. All rights reserved.
//

#import "KIAContext.h"
#import "KIAUrl.h"

#define EXP_SHORTHAND
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

SpecBegin(KIAUrl)

sharedExamplesFor(@"Locale aware url", ^(NSDictionary *data) {
  
  context(@"When locale is Swedish", ^{
    beforeEach(^{
      id kiaContextMock = OCMClassMock([KIAContext class]);
      OCMStub([kiaContextMock getApiKey]).andReturn(@"skadoo");
      
      id mainBundleMock = OCMPartialMock([NSBundle mainBundle]);
      OCMStub([mainBundleMock preferredLocalizations]).andReturn(@[@"sv"]);
    });
    
    it(@"should return a url with Swedish locale", ^{
      NSURL *url = ((NSURL * (^)(void)) data[@"method"])();
      expect(url.absoluteString).to.contain(@"locale=sv");
    });
  });
});

describe(@".registrationUrl", ^{
  
  context(@"when token is on playground", ^{
    beforeEach(^{
      id kiaContextMock = OCMClassMock([KIAContext class]);
      OCMStub([kiaContextMock getApiKey]).andReturn(@"test_skadoo");
    });
    
    it(@"should return a playground registration url", ^{
      expect([KIAUrl registrationUrl].absoluteString).to.equal(@"https://inapp.playground.klarna.com/registration/new?api_key=test_skadoo&locale=en");
    });
  });
  
  context(@"when token is on production", ^{
    beforeEach(^{
      id kiaContextMock = OCMClassMock([KIAContext class]);
      OCMStub([kiaContextMock getApiKey]).andReturn(@"skadoo");
    });
    
    it(@"should return a production registration url", ^{
      expect([KIAUrl registrationUrl].absoluteString).to.equal(@"https://inapp.klarna.com/registration/new?api_key=skadoo&locale=en");
    });
  });
  
  itBehavesLike(@"Locale aware url", @{@"method": ^NSURL*(void) { return [KIAUrl registrationUrl]; }});
});

SpecEnd