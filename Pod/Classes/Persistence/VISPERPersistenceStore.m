//
//  VISPERPersistenceStore.m
//  Pods
//
//  Created by Bartel on 23.07.15.
//
//

#import "VISPERPersistenceStore.h"

@implementation VISPERPersistenceStore

-(void)processCommand:(NSObject *)command
           completion:(BOOL(^)(NSString *identifier,NSObject *object,NSError **error))completion{
    [self saveCommand:command
           completion:completion];
}


-(void)saveCommand:(NSObject*)command
        completion:(BOOL(^)(NSString *identifier,NSObject *object,NSError **error))completion{

}

@end
