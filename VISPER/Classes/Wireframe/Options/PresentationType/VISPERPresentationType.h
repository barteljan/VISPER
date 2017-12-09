//
// Created by Bartel on 16.07.15.
//

#import <Foundation/Foundation.h>
#import "IVISPERWireframePresentationType.h"

@interface VISPERPresentationType : NSObject<IVISPERWireframePresentationType>
@property (nonatomic) BOOL animated;

-(instancetype)initIsAnimated:(BOOL)animated;

@end
