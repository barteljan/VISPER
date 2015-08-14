//
// Created by Bartel on 30.07.15.
//

#import <Foundation/Foundation.h>
#import "VISPERComposedInteractor.h"
#import "IVISPERComposedRepository.h"

@interface VISPERComposedRepository : VISPERComposedInteractor<IVISPERComposedRepository>

-(void)addInteractor:(NSObject<IVISPERRepository>*)interactor;
-(void)removeInteractor:(NSObject<IVISPERRepository>*)interactor;

-(void)addRepository:(NSObject<IVISPERRepository>*)repository;
-(void)removeRepository:(NSObject<IVISPERRepository>*)repository;

@end