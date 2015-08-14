//
// Created by Bartel on 30.07.15.
//

#import <Foundation/Foundation.h>
#import "IVISPERPersistenceStore.h"

@protocol IVISPERComposedPersistenceStore <IVISPERPersistenceStore>
-(void)addPersistenceStore:(NSObject<IVISPERPersistenceStore>*)persistenceStore;
-(void)removePersistenceStore:(NSObject<IVISPERPersistenceStore>*)persistenceStore;
@end