//
//  IVISPEREvent.h
//  Pods
//
//  Created by Bartel on 12.07.15.
//
//

#import <Foundation/Foundation.h>

@protocol IVISPEREvent <NSObject>
-(NSString*)name;
-(id)sender;
-(NSDictionary *)info;
@end
