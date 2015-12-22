//
//  VISPERCommandBus.h
//  Pods
//
//  Created by Bartel on 22.12.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERCommandBus.h"
#import "IVISPERCommandHandler.h"
#import "IVISPERInteractor.h"
#import "VISPERCommandHandler.h"

@interface VISPERCommandBus : VISPERCommandHandler<IVISPERCommandBus>

@property(nonatomic,strong)IBOutletCollection(NSObject<IVISPERInteractor>) NSArray *commandHandlers;

//deprecated
@property(nonatomic,strong) NSArray *interactors __attribute((deprecated(("use commandHandlers instead"))));

@end
