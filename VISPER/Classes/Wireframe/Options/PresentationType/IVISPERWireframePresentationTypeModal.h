//
// Created by Bartel on 16.07.15.
//

#import <Foundation/Foundation.h>
#import "IVISPERWireframePresentationType.h"

@protocol IVISPERWireframePresentationTypeModal <IVISPERWireframePresentationType>
-(UIModalPresentationStyle)presentationStyle;
-(void)setPresentationStyle:(UIModalPresentationStyle)presentationStyle;
@end