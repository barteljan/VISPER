//
// Created by Bartel on 16.07.15.
//

#import <Foundation/Foundation.h>
#import "IVISPERWireframePresentationType.h"

@protocol IVISPERWireframePresentationTypePush <IVISPERWireframePresentationType>
//enables multiple pushes of the same route and parameters
-(BOOL)enableMultiplePush;
@end