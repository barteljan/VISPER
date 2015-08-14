//
// Created by Bartel on 30.07.15.
//

#import "VISPERComposedRepository.h"


@implementation VISPERComposedRepository

-(void)getDataForCommand:(NSObject*)command
              completion:(BOOL(^)(NSString *identifier,NSObject *object,NSError **error))completion{
    [self processCommand:command completion:completion];
}

-(void)addRepository:(NSObject<IVISPERRepository>*)repository{
    [self addInteractor:repository];
}

-(void)removeRepository:(NSObject<IVISPERRepository>*)repository{
    [self removeInteractor:repository];
}

-(void)addInteractor:(NSObject<IVISPERRepository>*)interactor{
    [super addInteractor:interactor];
}

-(void)removeInteractor:(NSObject<IVISPERRepository>*)interactor{
    [super removeInteractor:interactor];
}


@end