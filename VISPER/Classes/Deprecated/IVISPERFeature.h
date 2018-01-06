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
-(NSArray* _Nonnull)routePatterns;

-(void)bootstrapWireframe:(NSObject<IVISPERWireframe> * _Nonnull)wireframe
               commandBus:(VISPERCommandBus * _Nonnull)commandBus;


@end
