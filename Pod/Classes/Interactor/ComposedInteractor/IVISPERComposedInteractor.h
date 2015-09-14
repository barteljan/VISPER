//
//  IVISPERComposedInteractor.h
//  Pods
//
//  Created by bartel on 20.08.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERInteractor.h"

@protocol IVISPERComposedInteractor <IVISPERInteractor>

-(void)addInteractor:(NSObject<IVISPERInteractor>*)interactor;
-(void)removeInteractor:(NSObject<IVISPERInteractor>*)interactor;

-(BOOL)isInStrictMode;
-(void)setStrictMode:(BOOL)isInStrictMode;

@end
