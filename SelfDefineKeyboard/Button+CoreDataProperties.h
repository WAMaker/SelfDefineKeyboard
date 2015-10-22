//
//  Button+CoreDataProperties.h
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/10/22.
//  Copyright © 2015年 wamaker. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Button.h"

NS_ASSUME_NONNULL_BEGIN

@interface Button (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *count;
@property (nullable, nonatomic, retain) NSString *text;

@end

NS_ASSUME_NONNULL_END
