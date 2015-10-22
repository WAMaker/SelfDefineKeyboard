//
//  WMKeyKeyboardDefine.h
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/9/30.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

typedef enum : NSUInteger {
    WMKeyButtonTypeDel,   // 按键类型：删除
    WMKeyButtonTypeDone,  // 按键类型：完成
    WMKeyButtonTypeOther  // 按键类型：其他
} WMKeyButtonType;

typedef enum : NSUInteger {
    WMKeyboardOtherTypeCommon, // 常用
    WMKeyboardOtherTypeAll     // 全部
} WMKeyboardOtherType;

static NSString *const DeleteText = @"删除";
static NSString *const DoneText = @"完成";