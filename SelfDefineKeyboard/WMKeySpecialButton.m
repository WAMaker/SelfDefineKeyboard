//
//  WMKeySpecialButton.m
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/10/22.
//  Copyright © 2015年 wamaker. All rights reserved.
//

#import "WMKeySpecialButton.h"

#import "Button.h"

#import "UIColor+extension.h"
#import "UIImage+extension.h"

@interface WMKeySpecialButton ()

@property (copy, nonatomic) sButtonClickBlock block;

@end

@implementation WMKeySpecialButton

- (instancetype)initKeyButtonWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:WMKeyButtonFont];
        [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#dfdfdf"]] forState:UIControlStateHighlighted];
        [self addTarget:self action:@selector(keyClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.layer setBorderWidth:0.5];
        [self.layer setBorderColor:[[UIColor blueColor] CGColor]];
        [self.layer setCornerRadius:5.0];
    }
    return self;
}

- (void)setSButtonClickBlock:(sButtonClickBlock)block {
    self.block = block;
}

- (void)keyClicked:(WMKeySpecialButton *)btn {
    NSString *text = @"";
    if (self.type == WMKeyButtonTypeOther) {
        text = btn.titleLabel.text;
    }
    self.block(self.type, text, self.button);
}

@end
