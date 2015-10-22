//
//  WMKeyView.h
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/9/27.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMKeyboardDefine.h"

static CGFloat const WMKeyButtonFont = 15;

typedef void(^buttonClickBlock)(WMKeyButtonType buttonType, NSString *text);

@interface WMKeyButton : UIButton

@property (assign, nonatomic) WMKeyButtonType type;

+ (instancetype)keyButtonWithFrame:(CGRect)frame;
- (instancetype)initKeyButtonWithFrame:(CGRect)frame;

- (void)setButtonClickBlock:(buttonClickBlock)block;

@end
