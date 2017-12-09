//
// Created by Bartel on 02.08.15.
//

#import <Foundation/Foundation.h>

@protocol IVISPERPriorizedObjectStore <NSObject>

-(void)addObject:(NSObject*)object withPriority:(NSInteger)priority;
-(void)removeObject:(NSObject*)object;
-(NSArray*)allObjects;
-(NSInteger)priorityForObject:(NSObject*)object;

@end