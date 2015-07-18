//
// Created by Bartel on 16.07.15.
//

#import <Foundation/Foundation.h>
#import "IVISPERRoutingOption.h"

@protocol IVISPERFacade <NSObject>

+(NSObject<IVISPERRoutingOption> *routingOption:(BOOL)animated;
+(NSObject<IVISPERRoutingOption> *pushRoutingOption:(BOOL)animated;
+(NSObject<IVISPERRoutingOption> *modalRoutingOption:(BOOL)animated;

-(NSObject<IVISPERRoutingOption> *routingOption:(BOOL)animated;
-(NSObject<IVISPERRoutingOption> *pushRoutingOption:(BOOL)animated;
-(NSObject<IVISPERRoutingOption> *modalRoutingOption:(BOOL)animated;


@end