//
// Created by Bartel on 30.07.15.
//

#import <Foundation/Foundation.h>
#import "VISPERComposedInteractor.h"
#import "IVISPERComposedPersistenceStore.h"


@interface VISPERComposedPersistenceStore : VISPERComposedInteractor <IVISPERComposedPersistenceStore>

-(void)addInteractor:(NSObject<IVISPERPersistenceStore>*)interactor;
-(void)removeInteractor:(NSObject<IVISPERPersistenceStore>*)interactor;

-(void)addPersistenceStore:(NSObject<IVISPERPersistenceStore>*)persistenceStore;
-(void)removePersistenceStore:(NSObject<IVISPERPersistenceStore>*)persistenceStore;


@end