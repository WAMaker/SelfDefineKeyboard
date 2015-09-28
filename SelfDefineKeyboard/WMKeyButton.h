//
//  WMKeyView.h
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/9/27.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WMKeyButtonTypeDel,
    WMKeyButtonTypeDone,
    WMKeyButtonTypeOther
} WMKeyButtonType;

@interface WMKeyButton : UIButton

@property (assign, nonatomic) WMKeyButtonType type;

@end
