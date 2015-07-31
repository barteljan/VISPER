//
//  PriorizedObjectStore.h
//  Pods
//
//  Created by Bartel on 31.07.15.
//
//

#import <Foundation/Foundation.h>

@interface PriorizedObjectStore : NSObject

-(void)addObject:(NSObject*)object withPriority:(NSInteger)priority;
-(void)removeObject:(NSObject*)object;

-(NSArray*)allObjects;

@end
