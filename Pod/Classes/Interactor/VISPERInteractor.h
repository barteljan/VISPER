//
//  VISPERInteractor.h
//  Pods
//
//  Created by Bartel on 23.07.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERInteractor.h"

@interface VISPERInteractor : NSObject<IVISPERInteractor>

@property(nonatomic,strong)NSString *identifier;

-(id)initWithIdentifier:(NSString*)identifier;

@end
