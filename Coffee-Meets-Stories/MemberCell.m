//
//  MemberCell.m
//  Coffee-Meets-Stories
//
//  Created by Arthur Tonelli on 3/31/17.
//  Copyright © 2017 Arthur Tonelli. All rights reserved.
//

#import "MemberCell.h"

@interface MemberCell()

@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *label;


@end

@implementation MemberCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        CGFloat tableWidth = [[UIScreen mainScreen]bounds].size.width;
        CGFloat tableHeight = tableWidth * .625;
        self.frame = CGRectMake(0, 0, tableWidth, tableHeight);
        
        NSString *localPath = [[NSBundle mainBundle]bundlePath];
        NSString *BGImagePath = [localPath stringByAppendingPathComponent:[[NSString alloc]initWithFormat:@"bgImage.jpg"]];
        UIImage *BGImg = [UIImage imageWithContentsOfFile:BGImagePath];
        
        NSLog(@"wdith: %f",self.frame.size.width);
        NSLog(@"wdith: %f",[[UIScreen mainScreen]bounds].size.width);
        
        UIImageView *backgroundImage = [[UIImageView alloc]init];
        backgroundImage.frame = CGRectMake(0, 0, self.frame.size.width, tableHeight - 80);
        backgroundImage.image = BGImg;
        backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
        backgroundImage.clipsToBounds = YES;
        
        
        [self addSubview:backgroundImage];
        
        
        
        NSString *tempImagePath = [localPath stringByAppendingPathComponent:[[NSString alloc]initWithFormat:@"profileTemp.png"]];
        UIImage *tempImg = [UIImage imageWithContentsOfFile:tempImagePath];
        self.imgView = [[UIImageView alloc]initWithImage:tempImg];
        self.imgView.frame =  CGRectMake(0, 0, 60, 60);
        
        CAShapeLayer *imgShape = [CAShapeLayer layer];
        UIBezierPath *imgPath = [UIBezierPath bezierPathWithArcCenter:self.imgView.center radius:(self.imgView.bounds.size.width / 2) startAngle:0 endAngle:(2 * M_PI) clockwise:YES];
        imgShape.path = imgPath.CGPath;
        CAShapeLayer *outline = [CAShapeLayer layer];
        outline.path = imgPath.CGPath;
        [outline setFillColor:nil];
        [outline setStrokeColor:[UIColor whiteColor].CGColor];
        [outline setLineWidth:2.0];
        CGRect newFrame = CGRectMake(tableWidth / 2 - 30, tableHeight - 110, 60, 60);
        outline.frame = newFrame;
        self.imgView.layer.mask = imgShape;
        [self.layer addSublayer:outline];
        self.imgView.frame =  newFrame;
        [self addSubview:self.imgView];
        
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(15, tableHeight - 45, 200, 30)];
        self.label.text = @"Name";
        self.label.font = [UIFont fontWithName:@"Damascus" size:20.0];
        self.label.textAlignment = NSTextAlignmentLeft;
        self.label.allowsDefaultTighteningForTruncation = NO;
        
        [self addSubview:self.label];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
