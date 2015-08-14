//
//  IVISPERRepository.h
//  Pods
//
//  Created by Bartel on 23.07.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERInteractor.h"

@protocol IVISPERRepository <IVISPERInteractor>
-(void)getDataForCommand:(NSObject*)command
              completion:(BOOL(^)(NSString *identifier,NSObject *object,NSError **error))completion;
@end
