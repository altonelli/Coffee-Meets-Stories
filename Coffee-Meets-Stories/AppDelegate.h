//
//  AppDelegate.h
//  Coffee-Meets-Stories
//
//  Created by Arthur Tonelli on 3/28/17.
//  Copyright © 2017 Arthur Tonelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) ViewController *mainViewController;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

