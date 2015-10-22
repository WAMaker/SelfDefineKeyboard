//
//  WMKeySpecialButton.h
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/10/22.
//  Copyright © 2015年 wamaker. All rights reserved.
//

#import "WMKeyButton.h"
@class Button;

typedef void(^sButtonClickBlock)(WMKeyButtonType buttonType, NSString *text, Button *button);

@interface WMKeySpecialButton : WMKeyButton

@property (strong, nonatomic) Button *button;

- (void)setSButtonClickBlock:(sButtonClickBlock)block;

@end
