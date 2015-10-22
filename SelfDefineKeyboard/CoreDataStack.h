//
//  CoreDataStack.h
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/10/20.
//  Copyright © 2015年 wamaker. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const CoreDataStackButton = @"Button";

@interface CoreDataStack : NSObject

@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic, readonly) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype)sharedInstance;

- (void)saveContext;

@end
