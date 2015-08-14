//
// Created by Bartel on 30.07.15.
//

#import "VISPERComposedPersistenceStore.h"


@implementation VISPERComposedPersistenceStore

-(void)saveCommand:(NSObject*)command
        completion:(BOOL(^)(NSString *identifier,NSObject *object,NSError **error))completion {
    [self processCommand:command completion:completion];
}

-(void)addInteractor:(NSObject<IVISPERPersistenceStore>*)interactor{
    [super addInteractor:interactor];
}

-(void)removeInteractor:(NSObject<IVISPERPersistenceStore>*)interactor{
    [super removeInteractor:interactor];
}

-(void)addPersistenceStore:(NSObject<IVISPERPersistenceStore>*)persistenceStore{
    [self addInteractor:persistenceStore];
}

-(void)removePersistenceStore:(NSObject<IVISPERPersistenceStore>*)persistenceStore{
    [self removeInteractor:persistenceStore];
}

@end