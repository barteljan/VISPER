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

@interface VISPERComposedInteractor : VISPERCommandBus<IVISPERComposedInteractor,IVISPERInteractor>

@end
