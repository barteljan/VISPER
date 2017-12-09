//
//  VISPEREvent.h
//  Pods
//
//  Created by Bartel on 12.07.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPEREvent.h"

@interface VISPEREvent : NSObject<IVISPEREvent>

-(instancetype)initWithName:(NSString*)name
                     sender:(id)sender;

-(instancetype)initWithName:(NSString*)name
                     sender:(id)sender
                       info:(NSDictionary *)info;

@property (nonatomic) NSString *name;
@property (nonatomic) id sender;
@property (nonatomic) NSDictionary *info;

@end
