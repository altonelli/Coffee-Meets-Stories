//
//  StoryTextView.m
//  Coffee-Meets-Stories
//
//  Created by Arthur Tonelli on 3/31/17.
//  Copyright © 2017 Arthur Tonelli. All rights reserved.
//

#import "StoryTextView.h"

@implementation StoryTextView

-(id)initWithFrame:(CGRect)frame andString:(NSString *)string{
    self = [super initWithFrame:frame];
    if(self){
        NSLog(@"string: %lu",(unsigned long)string.length);
        
        UIColor *CMBBlueColor = [UIColor colorWithRed:15.0/255 green:124.0/255 blue:228.0/255 alpha:1.0];
        self.backgroundColor = CMBBlueColor;
        
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.frame = CGRectMake(20, 45, frame.size.width - 40, frame.size.height - 60);
        scrollView.contentInset = UIEdgeInsetsMake(10, 0, 15, 0);
        
        
        UITextView *textView = [[UITextView alloc]init];
        textView.text = string;
        [textView sizeToFit];
        CGRect textRect = CGRectMake(0, 0, frame.size.width - 40, frame.size.height - 40);
        textView.frame = textRect;
        // [textLabel resizeToFit];
        textView.backgroundColor = [UIColor clearColor];
        textView.font = [UIFont fontWithName:@"Damascus" size:24.0];
        textView.textColor = [UIColor whiteColor];
        textView.textAlignment = NSTextAlignmentLeft;
        // textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        // textLabel.numberOfLines = 0;
        textView.editable = NO;
        
        [scrollView addSubview:textView];
        scrollView.contentSize = textView.frame.size;
        [self addSubview:scrollView];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
