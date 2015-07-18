//
// Created by Bartel on 16.07.15.
//

#import "VISPERPresentationType.h"


@implementation VISPERPresentationType

-(instancetype)initIsAnimated:(BOOL)animated{
    self = [super init];
    if(self){
        self->_animated = animated;
    }
    return self;
}
@end