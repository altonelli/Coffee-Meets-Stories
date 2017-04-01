//
//  TeamManager.m
//  Coffee-Meets-Stories
//
//  Created by Arthur Tonelli on 3/29/17.
//  Copyright © 2017 Arthur Tonelli. All rights reserved.
//

#import "TeamManager.h"

@implementation TeamManager

+(id)sharedInstance{
    static TeamManager *sharedTeamManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTeamManager = [[self alloc]init];
        sharedTeamManager.queue = dispatch_queue_create("com.Coffee-Meets-Stories.queue", DISPATCH_QUEUE_SERIAL);
        sharedTeamManager.serialQueue = dispatch_queue_create("com.Coffee-Meets-Stories.serialQueue", DISPATCH_QUEUE_SERIAL);
        sharedTeamManager.scrollQueue = dispatch_queue_create("com.Coffee-Meets-Stories.scrollQueue", DISPATCH_QUEUE_CONCURRENT);
        sharedTeamManager.tableQueue = dispatch_queue_create("com.Coffee-Meets-Stories.tableQueue", DISPATCH_QUEUE_CONCURRENT);
        sharedTeamManager.imageDataDictionary = [[NSMutableDictionary alloc]init];
        
    });
    
    return sharedTeamManager;
}

-(void)retrieveBundleInfo{
    CGRect screenRect = [[UIScreen mainScreen]bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;

    self.screenWidth = screenWidth;
    self.screenHeight = screenHeight;
    
    // Parse JSON and Add Team Array to Manager
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"team" ofType:@".json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    self.teamArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    // begin retrieving Image Data
    dispatch_async(self.serialQueue, ^{
        for(NSDictionary *teamMember in self.teamArray){
            NSString *avatarStr = [teamMember objectForKey:@"avatar"];
            NSString *memberID = [teamMember objectForKey:@"id"];
            [self storeDataForId:memberID withURLString:avatarStr];
        }
    });
    
    // Add temp File to Manager
    NSString *localPath = [[NSBundle mainBundle]bundlePath];
    NSString *imageName = [localPath stringByAppendingPathComponent:[[NSString alloc]initWithFormat:@"profileTemp.png"]];
    self.tempImgData = [NSData dataWithContentsOfFile:imageName];
}

-(void)storeDataForId:(NSString *)string withURLString:(NSString *)URLString{
    NSData *data = [self.imageDataDictionary objectForKey:string];
    if(data == nil){
        NSURL *avatarUrl = [NSURL URLWithString:URLString];
        data = [NSData dataWithContentsOfURL:avatarUrl];
        [self.imageDataDictionary setValue:data forKey:string];
    }
}

-(void)storeDataForId:(NSString *)string withData:(NSData *)data{
    dispatch_async(self.serialQueue, ^{
        [self.imageDataDictionary setValue:data forKey:string];
    });
}


@end
