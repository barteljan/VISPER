//
//  NSObject+CallSuperFunction.h
//  Pods
//
//  Created by Bartel on 18.07.15.
//
//

#import <Foundation/Foundation.h>

#define visperInvokeSupersequent(...) \
([self visperGetImplementationOf:_cmd \
after:visperImpOfCallingMethod(self, _cmd)]) \
(self, _cmd, ##__VA_ARGS__)

#define visperInvokeSupersequentNoParameters() \
([self visperGetImplementationOf:_cmd \
after:visperImpOfCallingMethod(self, _cmd)]) \
(self, _cmd)


@interface NSObject (CallSuperFunction)

- (IMP)visperGetImplementationOf:(SEL)lookup after:(IMP)skip;
IMP visperImpOfCallingMethod(id lookupObject, SEL selector);

@end
