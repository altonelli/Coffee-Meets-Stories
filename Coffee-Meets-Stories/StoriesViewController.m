//
//  StoriesViewController.m
//  Coffee-Meets-Stories
//
//  Created by Arthur Tonelli on 3/29/17.
//  Copyright © 2017 Arthur Tonelli. All rights reserved.
//

#import "StoriesViewController.h"
#import "TeamManager.h"
#import "StoryImageView.h"
#import "StoryTextView.h"

@interface StoriesViewController ()

@property (nonatomic,strong) NSArray *viewsArray;
@property (nonatomic,strong) UIButton *exitButton;



@end

@implementation StoriesViewController{
    CGFloat screenWidth;
    CGFloat screenHeight;
    NSArray *teamArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    TeamManager *teamManager = [TeamManager sharedInstance];
    screenWidth = teamManager.screenWidth;
    screenHeight = teamManager.screenHeight;
    teamArray = teamManager.teamArray;
    
    CGRect screenRect = CGRectMake(0, 0, screenWidth, screenHeight);
    NSData *tempData = teamManager.tempImgData;
    
    NSMutableArray *mutableViewArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < teamArray.count; i++) {
        NSUInteger index = (NSUInteger) i;
        NSDictionary *teamMember = [teamArray objectAtIndex:index];
        NSString *firstName = [teamMember objectForKey:@"firstName"];
        NSString *lastName = [teamMember objectForKey:@"lastName"];
        NSString *fullName = [NSString stringWithFormat:@"%@ %@",firstName,lastName];
        
        // Create profile view
        
        NSString *memberID = [teamMember valueForKey:@"id"];
        
        NSData *imgData = [teamManager.imageDataDictionary valueForKey:memberID];
        
        if(imgData == nil){
            StoryImageView *storyView = [[StoryImageView alloc]initWithFrame:screenRect andData:tempData andName:fullName];
            [mutableViewArray addObject:storyView];
            
            dispatch_async(teamManager.scrollQueue, ^{
                NSString *avatarStr = [teamMember valueForKey:@"avatar"];
                NSURL *avatartURL = [NSURL URLWithString:avatarStr];
                NSData *data = [NSData dataWithContentsOfURL:avatartURL];
                [self updateImageAtIndex:index withData:data];
                [teamManager storeDataForId:memberID withData:data];
            });
        
        } else {
            StoryImageView *storyView = [[StoryImageView alloc]initWithFrame:screenRect andData:imgData andName:fullName];
            [mutableViewArray addObject:storyView];
        }
        

        // Create text view
        NSString *bio = [teamMember objectForKey:@"bio"];
        StoryTextView *textView = [[StoryTextView alloc]initWithFrame:screenRect andString:bio];
        [mutableViewArray addObject:textView];
    }
    
    self.viewsArray = [NSArray arrayWithArray:mutableViewArray];

    StoryImageView *startView = [self.viewsArray objectAtIndex:self.viewIndex];
    startView.tag = 1;
    [self.view addSubview:startView];
    [self addButton];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tap];
    
}

-(void) addButton{
    NSString *localPath = [[NSBundle mainBundle]bundlePath];
    NSString *xImagePath = [localPath stringByAppendingPathComponent:[[NSString alloc]initWithFormat:@"WhiteXButton.png"]];
    UIImage *xImage = [UIImage imageNamed:xImagePath];
    
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitButton addTarget:self
                   action:@selector(closeButtonTapped:)
         forControlEvents:UIControlEventTouchUpInside];
    
    CGRect buttonRect = CGRectMake(screenWidth - 45, 25, 25, 25);
    exitButton.frame = buttonRect;
    [exitButton setBackgroundImage:xImage forState:UIControlStateNormal];
    exitButton.tag = 42;
    exitButton.alpha = .5;

    [self.view addSubview:exitButton];
}

#pragma handle user interaction

-(IBAction)closeButtonTapped:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Dismissed");
    }];
}

-(void)handleTap:(UITapGestureRecognizer *)recognizer{
    CGPoint location = [recognizer locationInView:recognizer.view.superview];
    
    if(location.x < screenWidth * .3 && self.viewIndex > 0){
        self.viewIndex = self.viewIndex - 1;
    } else if(location.x > screenWidth * .3 && (self.viewsArray.count - 1 > (NSUInteger)(self.viewIndex))) {
        self.viewIndex = self.viewIndex + 1;
    }
    
    UIView *nextStory = [self.viewsArray objectAtIndex:self.viewIndex];
    nextStory.tag = 1;
    UIView *oldStory = [self.view viewWithTag:1];
    NSInteger idx = [self.view.subviews indexOfObject:oldStory];
    [oldStory removeFromSuperview];
    [self.view insertSubview:nextStory atIndex:idx];
}

-(void)updateImageAtIndex:(NSUInteger)index withData:(NSData *)data{
#pragma May be unsafe due to asyncronous fetch
    // Multiply by two since added view in between
    index = index * 2;
    StoryImageView *storyImageView = [self.viewsArray objectAtIndex:index];
    [storyImageView updateImageToData:data];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
