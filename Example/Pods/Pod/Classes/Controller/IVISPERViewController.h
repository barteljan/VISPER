//
//  IVISPERViewController.h
//  VISPER
//
//  Created by Bartel on 10.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

@import Foundation;
@import UIKit;
#import "IVISPERPresenter.h"


@protocol IVISPERViewController <NSObject>

-(NSObject<IVISPERPresenter>*)presenter;

@end
