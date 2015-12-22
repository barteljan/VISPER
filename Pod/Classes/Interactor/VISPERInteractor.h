//
//  VISPERInteractor.h
//  Pods
//
//  Created by Bartel on 23.07.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERInteractor.h"
#import "VISPERCommandHandler.h"

__attribute((deprecated(("Don't use VISPERInteractor use VISPERCommandHandler instead"))))
@interface VISPERInteractor : VISPERCommandHandler<IVISPERInteractor>
@end
