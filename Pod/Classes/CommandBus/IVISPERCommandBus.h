//
//  IVISPERCommandBus.h
//  Pods
//
//  Created by Bartel on 22.12.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERCommandHandler.h"

@protocol IVISPERCommandBus <IVISPERCommandHandler>

-(BOOL)isInStrictMode;
-(void)setStrictMode:(BOOL)isInStrictMode;

-(void)addHandler:(NSObject<IVISPERCommandHandler>*)commandHandler;
-(void)removeHandler:(NSObject<IVISPERCommandHandler>*)commandHandler;


//deprecated
@optional
-(void)addInteractor:(NSObject<IVISPERCommandHandler>*)interactor __attribute((deprecated(("use addHandler: instead"))));
-(void)removeInteractor:(NSObject<IVISPERCommandHandler>*)interactor  __attribute((deprecated(("use removeHandler: instead"))));


@end
