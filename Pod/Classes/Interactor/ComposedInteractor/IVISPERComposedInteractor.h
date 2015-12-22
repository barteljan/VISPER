//
//  IVISPERComposedInteractor.h
//  Pods
//
//  Created by bartel on 20.08.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERInteractor.h"
#import "IVISPERCommandBus.h"

__attribute((deprecated(("Don't use IVISPERComposedInteractor use IVISPERCommandBus instead"))))
@protocol IVISPERComposedInteractor <IVISPERInteractor,IVISPERCommandBus>

@end
