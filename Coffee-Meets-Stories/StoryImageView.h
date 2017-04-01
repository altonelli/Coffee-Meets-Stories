//
//  StoryImageView.h
//  Coffee-Meets-Stories
//
//  Created by Arthur Tonelli on 3/29/17.
//  Copyright © 2017 Arthur Tonelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryImageView : UIView

-(id)initWithFrame:(CGRect)frame andData:(NSData *)data;
-(id)initWithFrame:(CGRect)frame andData:(NSData *)data andName:(NSString *)name;
-(void)updateImageToData:(NSData *)data;

@end
