//
//  VISPERViewPresenter.h
//  VISPER
//
//  Created by Bartel on 10.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

@import Foundation;
@import UIKit;

#import "IVISPERPresenter.h"
#import "IVISPERViewEvent.h"
#import "IVISPERWireframe.h"

@interface VISPERViewPresenter : NSObject<IVISPERPresenter>

@property(nonatomic) IBOutlet NSObject<IVISPERWireframe> *wireframe;

-(instancetype)initWithWireframe:(NSObject<IVISPERWireframe>*)wireframe;

@end
