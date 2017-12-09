//
//  VISPERCommandHandler.h
//  Pods
//
//  Created by Jan Bartel on 26.02.16.
//
//

@import VISPER_CommandBus;
#import <Foundation/Foundation.h>

@protocol IVISPERCommandHandler;

@interface VISPERCommandHandler : NSObject<IVISPERCommandHandler>

@property(nonatomic,strong)NSString *identifier;
-(id)initWithIdentifier:(NSString*)identifier;

@end
