//
//  WMKeyboardInputView.h
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/10/21.
//  Copyright © 2015年 wamaker. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WMKeyboardDefine.h"

static CGFloat const WMKeyboardIAViewHeight = 50;

@protocol WMKeyboardIAViewDelegate <NSObject>

@optional
- (void)IAViewTypeChanged:(WMKeyboardOtherType)type;

@end

@interface WMKeyboardIAView : UIView

@property (weak, nonatomic) id<WMKeyboardIAViewDelegate> delegate;

+ (instancetype)iaView;
- (instancetype)initIAView;

@end
