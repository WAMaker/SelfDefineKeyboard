//
//  AppDelegate.m
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/9/10.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreDataStack.h"
#import "Button+CoreDataProperties.h"

@interface AppDelegate ()

@property (strong, nonatomic) CoreDataStack *stack;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.stack = [CoreDataStack sharedInstance];
    
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:CoreDataStackButton];
    NSArray *results = [self.stack.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (results.count == 0) {
        [self addKeyboardButtonText];
    } else {
        for (Button *button in results) {
            NSLog(@"%@", button.text);
        }
    }
    
    return YES;
}

- (void)addKeyboardButtonText {
    NSEntityDescription *entity = [NSEntityDescription entityForName:CoreDataStackButton inManagedObjectContext:self.stack.managedObjectContext];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"KeyboardButtonText" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSArray *textArray = dict[@"texts"];
    for (NSString *text in textArray) {
        Button *button = [[Button alloc] initWithEntity:entity insertIntoManagedObjectContext:self.stack.managedObjectContext];
        button.text = text;
        button.count = 0;
    }
    
    [self.stack saveContext];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
