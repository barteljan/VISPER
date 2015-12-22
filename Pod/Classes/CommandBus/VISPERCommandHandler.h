//
//  VISPERCommandHandler.h
//  Pods
//
//  Created by Bartel on 22.12.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERCommandHandler.h"

@interface VISPERCommandHandler : NSObject<IVISPERCommandHandler>

@property(nonatomic,strong)NSString *identifier;
-(id)initWithIdentifier:(NSString*)identifier;

@end
