//
//  StoryImageView.m
//  Coffee-Meets-Stories
//
//  Created by Arthur Tonelli on 3/29/17.
//  Copyright © 2017 Arthur Tonelli. All rights reserved.
//

#import "StoryImageView.h"

@interface StoryImageView()

@property (nonatomic,strong) UIImageView *rearImageView;
@property (nonatomic,strong) UIImageView *mainImageView;

@end

@implementation StoryImageView

-(id)initWithFrame:(CGRect)frame andData:(NSData *)data{
    self = [super initWithFrame:frame];
    
    if(self){
        self.backgroundColor = [UIColor blackColor];
        
        UIImage *image = [[UIImage alloc]initWithData:data];
        self.rearImageView = [[UIImageView alloc]initWithImage:image];
        self.mainImageView = [[UIImageView alloc]initWithImage:image];
        
        self.rearImageView.frame = frame;
        self.rearImageView.contentMode = UIViewContentModeScaleAspectFill;
        // rearImageView.contentMode = UIViewContentModeCenter;
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc]initWithEffect:blur];
        blurView.frame = frame;
        blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.rearImageView addSubview:blurView];

        self.mainImageView.frame = frame;
        self.mainImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:self.rearImageView];
        [self addSubview:self.mainImageView];
        
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame andData:(NSData *)data andName:(NSString *)name{
    self = [super initWithFrame:frame];
    
    if(self){
        self.backgroundColor = [UIColor blackColor];
        
        UIImage *image = [[UIImage alloc]initWithData:data];
        self.rearImageView = [[UIImageView alloc]initWithImage:image];
        self.mainImageView = [[UIImageView alloc]initWithImage:image];
        
        self.rearImageView.frame = frame;
        self.rearImageView.contentMode = UIViewContentModeScaleAspectFill;
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc]initWithEffect:blur];
        blurView.frame = frame;
        blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.rearImageView addSubview:blurView];
        
        self.mainImageView.frame = frame;
        self.mainImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.text = name;
        CGRect labelRect = CGRectMake(20, (frame.size.height * .5) + 180, 200, 36);
        nameLabel.frame = labelRect;
        nameLabel.transform = CGAffineTransformMakeRotation(M_PI / 10);
        nameLabel.font = [UIFont fontWithName:@"Damascus" size:24.0];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.allowsDefaultTighteningForTruncation = YES;
        
        
        [self addSubview:self.rearImageView];
        [self addSubview:self.mainImageView];
        [self addSubview:nameLabel];
        
    }
    
    return self;
}

-(void)updateImageToData:(NSData *)data{
    UIImage *newImage = [UIImage imageWithData:data];
    self.rearImageView.image = newImage;
    self.mainImageView.image = newImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
