//
//  WMKeyboardView.h
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/9/27.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WMKeyboardTypeNumber,
    WMKeyboardTypeMore
} WMKeyboardType;

@interface WMKeyboardView : UIView

- (instancetype)initWithKeyboardType:(WMKeyboardType)type;
+ (instancetype)keyboardViewWithKeyboardType:(WMKeyboardType)type;

- (void)exchangeNumber;

@end
