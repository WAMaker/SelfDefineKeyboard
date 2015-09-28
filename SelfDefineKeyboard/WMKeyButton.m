//
//  WMKeyView.m
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/9/27.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import "WMKeyButton.h"

#import "UIColor+extension.h"

@implementation WMKeyButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:247 / 255.0 blue:236 / 255.0 alpha:1.0];
        [self setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(keyClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)keyClicked:(WMKeyButton *)button {
    
}

@end
