//
//  PriorizedObjectStoreItem.m
//  Pods
//
//  Created by Bartel on 31.07.15.
//
//

#import "PriorizedObjectStoreItem.h"
@interface PriorizedObjectStoreItem()

@property(nonatomic,assign)NSInteger priority;
@property(nonatomic,strong)NSObject *object;

@end


@implementation PriorizedObjectStoreItem

-(instancetype)initWithObject:(NSObject*)object
                     priority:(NSInteger)priority{
    self = [super init];
    if(self){
        self->_object = object;
        self->_priority = priority;
    }
    
    return self;
    
}




@end
