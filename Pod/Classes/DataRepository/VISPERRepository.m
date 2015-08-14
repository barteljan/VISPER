//
//  VISPERRepository.m
//  Pods
//
//  Created by Bartel on 23.07.15.
//
//

#import "VISPERRepository.h"

@implementation VISPERRepository

-(void)processCommand:(NSObject *)command
           completion:(BOOL(^)(NSString *identifier,NSObject *object,NSError **error)) completion{
    [self getDataForCommand:command
                 completion:completion];
}


-(void)getDataForCommand:(NSObject *)command
              completion:(BOOL(^)(NSString *identifier,NSObject *object,NSError **error))completion{

}
@end
