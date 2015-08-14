//
//  IVISPERComposedApplication.h
//  Pods
//
//  Created by Bartel on 23.07.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERWireframe.h"
#import "IVISPERComposedPersistenceStore.h"
#import "IVISPERComposedRepository.h"

@protocol IVISPERComposedApplication <NSObject>

-(void)bootstrapWireframe:(NSObject<IVISPERWireframe> *)wireframe
               repository:(NSObject<IVISPERComposedRepository> *)repository
         persistenceStore:(NSObject<IVISPERComposedPersistenceStore> *)persistenceStore;

-(NSString*)startingRoute;

@end
