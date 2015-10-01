//
//  WMKeyView.h
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/9/27.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMKeyKeyboardDefine.h"

typedef void(^buttonClickBlock)(WMKeyButtonType buttonType, NSString *text);

@interface WMKeyButton : UIButton

@property (assign, nonatomic) WMKeyButtonType type;

- (void)setButtonClickBlock:(buttonClickBlock)block;

@end
