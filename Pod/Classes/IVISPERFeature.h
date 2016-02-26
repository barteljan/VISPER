//
//  IVISPERFeature.h
//  Pods
//
//  Created by Bartel on 23.07.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERWireframe.h"
@import VISPER_CommandBus;

@protocol IVISPERFeature <NSObject>

@optional
-(NSArray*)routePatterns;

-(void)bootstrapWireframe:(NSObject<IVISPERWireframe> *)wireframe
               commandBus:(VISPERCommandBus *)commandBus;


@end
