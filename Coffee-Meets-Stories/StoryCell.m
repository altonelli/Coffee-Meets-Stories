//
//  StoryCell.m
//  Coffee-Meets-Stories
//
//  Created by Arthur Tonelli on 3/28/17.
//  Copyright © 2017 Arthur Tonelli. All rights reserved.
//

#import "StoryCell.h"

@interface StoryCell()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIImageView *imgView;

@end

@implementation StoryCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        
        CGRect cirleRect = CGRectMake(0, 0, 60, 60);
        CGPoint center = CGPointMake(30, 30);
        CAShapeLayer *shape = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:(cirleRect.size.width / 2) startAngle:0 endAngle:(2 * M_PI) clockwise:YES];
        shape.path = path.CGPath;
        self.layer.mask = shape;
        
        [shape setFillColor:nil];
        UIColor *CMBBlueColor = [UIColor colorWithRed:15.0/255 green:124.0/255 blue:228.0/255 alpha:1.0];
        [shape setStrokeColor:CMBBlueColor.CGColor];
        [shape setLineWidth:2.0];
        [self.layer addSublayer:shape];
        
        NSString *localPath = [[NSBundle mainBundle]bundlePath];
        NSString *imageName = [localPath stringByAppendingPathComponent:[[NSString alloc]initWithFormat:@"profileTemp.png"]];
        UIImage *tempImg = [UIImage imageWithContentsOfFile:imageName];
        self.imgView = [[UIImageView alloc]initWithImage:tempImg];
        self.imgView.frame = CGRectMake(0, 0, 50, 50);
        
        CAShapeLayer *imgShape = [CAShapeLayer layer];
        UIBezierPath *imgPath = [UIBezierPath bezierPathWithArcCenter:self.imgView.center radius:(self.imgView.bounds.size.width / 2) startAngle:0 endAngle:(2 * M_PI) clockwise:YES];
        imgShape.path = imgPath.CGPath;
        self.imgView.layer.mask = imgShape;
        self.imgView.frame = CGRectMake(5, 5, 50, 50);
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, 60, 20)];
        self.label.text = @"Name";
        self.label.font = [UIFont fontWithName:@"Damascus" size:15.0];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.allowsDefaultTighteningForTruncation = YES;
        
        
        [self addSubview:self.imgView];
        [self addSubview:self.label];

    }
    
    return self;
}

-(void)updateCellWithData:(NSData *)imageData andName:(NSString *)name{
    self.label.text = name;
    self.imgView.image = [UIImage imageWithData:imageData];
}

-(void)updateCellWithName:(NSString *)name{
    self.label.text = name;
}




@end
