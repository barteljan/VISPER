//
//  VISPERPersistenceStore.h
//  Pods
//
//  Created by Bartel on 23.07.15.
//
//

#import <Foundation/Foundation.h>
#import "VISPERInteractor.h"
#import "IVISPERPersistenceStore.h"
__attribute((deprecated(("Don't use VISPERPersistenceStore use VISPERCommandHandler instead"))))
@interface VISPERPersistenceStore : VISPERInteractor<IVISPERPersistenceStore>

@end
