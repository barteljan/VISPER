//
//  VISPERViewEvent.h
//  VISPER
//
//  Created by Bartel on 10.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IVISPERViewEvent.h"

@interface VISPERViewEvent : NSObject<IVISPERViewEvent>

-(instancetype)initWithName:(NSString*)name
                     sender:(id)sender;

-(instancetype)initWithName:(NSString*)name
                     sender:(id)sender
                       info:(NSDictionary *)info;

@property (nonatomic) NSString *name;
@property (nonatomic) id sender;
@property (nonatomic) NSDictionary *info;

@end
