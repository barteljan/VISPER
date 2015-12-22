//
//  VISPERComposedInteractor.h
//  Pods
//
//  Created by Bartel on 23.07.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERComposedInteractor.h"
#import "IVISPERInteractor.h"
#import "VISPERCommandBus.h"

__attribute((deprecated(("Don't use VISPERComposedInteractor use VISPERCommandBus instead"))))
@interface VISPERComposedInteractor : VISPERCommandBus<IVISPERComposedInteractor,IVISPERInteractor>

@end
