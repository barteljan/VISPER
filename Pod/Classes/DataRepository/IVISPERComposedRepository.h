//
// Created by Bartel on 30.07.15.
//

#import <Foundation/Foundation.h>
#import "IVISPERRepository.h"

@protocol IVISPERComposedRepository <IVISPERRepository>

-(void)addRepository:(NSObject<IVISPERRepository>*)repository;
-(void)removeRepository:(NSObject<IVISPERRepository>*)repository;

@end