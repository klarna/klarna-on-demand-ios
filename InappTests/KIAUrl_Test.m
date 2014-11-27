//
//  InAppTests.m
//  InAppTests
//
//  Created by Guy Rozen on 11/17/2014.
//  Copyright (c) 2014 Guy Rozen. All rights reserved.
//

#import "KIAContext.h"
#import "KIAUrl.h"

SpecBegin(KIAUrl_Test)

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
  
  context(@"When locale is Swedish", ^{
    beforeEach(^{
      id kiaContextMock = OCMClassMock([KIAContext class]);
      OCMStub([kiaContextMock getApiKey]).andReturn(@"skadoo");
      
      id mainBundleMock = OCMPartialMock([NSBundle mainBundle]);
      OCMStub([mainBundleMock preferredLocalizations]).andReturn(@[@"sv"]);
    });
    
    it(@"should return a url with Swedish locale", ^{
      expect([KIAUrl registrationUrl].absoluteString).to.contain(@"locale=sv");
    });
  });
});

SpecEnd