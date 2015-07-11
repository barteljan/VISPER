//
//  IVISPERViewEvent.h
//  VISPER
//
//  Created by Bartel on 10.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IVISPERViewEvent <NSObject>
    -(NSString*)name;
    -(id)sender;
    -(NSDictionary *)info;
@end
