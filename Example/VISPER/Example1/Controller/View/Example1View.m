//
//  Example1View.m
//  VISPER
//
//  Created by Jan Bartel on 25.02.16.
//  Copyright © 2016 Jan Bartel. All rights reserved.
//

#import "Example1View.h"
@interface Example1View()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end


@implementation Example1View

-(NSString*)text{
    return self.textLabel.text;
}

-(void)setText:(NSString *)text{
    self.textLabel.text = text;
}

@end
