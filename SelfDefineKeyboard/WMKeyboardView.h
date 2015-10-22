//
//  WMKeyboardView.h
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/9/27.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMKeyboardDefine.h"

static CGFloat WMKeyboardViewNumberHeight = 250;

typedef void(^WMKeyboardBlock)(WMKeyButtonType type, NSString *text);

@interface WMKeyboardView : UIView

- (instancetype)initKeyboardWithFrame:(CGRect)frame;
+ (instancetype)keyboardWithFrame:(CGRect)frame;

- (void)setWMKeyboardBlock:(WMKeyboardBlock)block;

@end
