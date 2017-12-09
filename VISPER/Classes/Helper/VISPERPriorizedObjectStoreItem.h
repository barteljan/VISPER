//
//  VISPERPriorizedObjectStoreItem.h
//  Pods
//
//  Created by Bartel on 31.07.15.
//
//

#import <Foundation/Foundation.h>

@interface VISPERPriorizedObjectStoreItem : NSObject

@property(readonly,nonatomic,assign)NSInteger priority;
@property(readonly,nonatomic,strong)NSObject *object;

-(instancetype)initWithObject:(NSObject*)object
                     priority:(NSInteger)priority;

@end
