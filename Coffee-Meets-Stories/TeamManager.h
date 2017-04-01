//
//  TeamManager.h
//  Coffee-Meets-Stories
//
//  Created by Arthur Tonelli on 3/29/17.
//  Copyright © 2017 Arthur Tonelli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TeamManager : NSObject

@property (nonatomic,strong) NSArray *teamArray;
@property (nonatomic,strong) NSArray *viewArray;

@property (nonatomic,strong) NSMutableDictionary *imageDataDictionary;

@property (nonatomic,strong) NSData *tempImgData;

@property (nonatomic,assign) CGFloat screenWidth;
@property (nonatomic,assign) CGFloat screenHeight;

@property (nonatomic,strong) dispatch_queue_t queue;
@property (nonatomic,strong) dispatch_queue_t serialQueue;
@property (nonatomic,strong) dispatch_queue_t scrollQueue;
@property (nonatomic,strong) dispatch_queue_t tableQueue;

+(id)sharedInstance;

-(void)retrieveBundleInfo;
//-(void)storeDataForId:(NSString *)string withURLString:(NSString *)URLString;
-(void)storeDataForId:(NSString *)string withData:(NSData *)data;

@end
