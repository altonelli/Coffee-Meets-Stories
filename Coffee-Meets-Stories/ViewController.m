//
//  ViewController.m
//  Coffee-Meets-Stories
//
//  Created by Arthur Tonelli on 3/28/17.
//  Copyright © 2017 Arthur Tonelli. All rights reserved.
//

#import "ViewController.h"
#import "StoryScrollViewFlowLayout.h"
#import "StoryCell.h"
#import "TeamManager.h"
#import "StoriesViewController.h"
#import "MemberCell.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UICollectionView *scrollView;
@property (nonatomic,strong) UINavigationBar *navigationBar;
@property (nonatomic,strong) UITableView *tableView;


@end

@implementation ViewController{
    CGFloat screenWidth;
    CGFloat screenHeight;
    NSArray *teamArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    screenWidth = [[TeamManager sharedInstance]screenWidth];
    screenHeight = [[TeamManager sharedInstance]screenHeight];
    
    teamArray = [[TeamManager sharedInstance]teamArray];

    // topscrollview
    StoryScrollViewFlowLayout *scrollViewLayout = [[StoryScrollViewFlowLayout alloc]init];
    
    CGRect scrollViewRect = CGRectMake(0, 60, screenWidth, 90);
    self.scrollView = [[UICollectionView alloc]initWithFrame:scrollViewRect collectionViewLayout:scrollViewLayout];
    [self.scrollView setDataSource:self];
    [self.scrollView setDelegate:self];
    [self.scrollView registerClass:[StoryCell class] forCellWithReuseIdentifier:@"storyCell"];
    [self.scrollView setBackgroundColor:[UIColor whiteColor]];
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    
    // tableview
    CGRect tableViewRect = CGRectMake(0, 150, screenWidth, screenHeight - 150);
    self.tableView = [[UITableView alloc]initWithFrame:tableViewRect];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView registerClass:[MemberCell class] forCellReuseIdentifier:@"memberCell"];
    UIColor *CMBGreyColor = [UIColor colorWithRed:175.0/255 green:175.0/255 blue:175.0/255 alpha:1.0];
    [self.tableView setBackgroundColor:CMBGreyColor];

    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.tableView];
    [self setNeedsStatusBarAppearanceUpdate];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)viewDidAppear:(BOOL)animated {
    // navbar
    CGRect navBarRect = CGRectMake(0, 0, screenWidth, 60);
    self.navigationBar = [[UINavigationBar alloc]initWithFrame:navBarRect];
    UIColor *barBlueColor = [UIColor colorWithRed:19.0/255 green:122.0/255 blue:240.0/255 alpha:1.0];
    self.navigationBar.barTintColor = barBlueColor;
    [self.view addSubview:self.navigationBar];
    UINavigationItem *navBarItem = [[UINavigationItem alloc]initWithTitle:@"Meet the Team"];
    navBarItem.titleView.tintColor = [UIColor whiteColor];
    self.navigationBar.items = [NSArray arrayWithObjects:navBarItem,nil];
    NSDictionary *attDictionary = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationBar.titleTextAttributes = attDictionary;
}

#pragma collection view

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"storyCell" forIndexPath:indexPath];
    
    TeamManager *teamManager = [TeamManager sharedInstance];
    teamArray = teamManager.teamArray;
    
    NSDictionary *teamMember = [teamArray objectAtIndex:indexPath.row];
    NSString *nameStr = [teamMember valueForKey:@"firstName"];
    NSString *memberID = [teamMember valueForKey:@"id"];
    
    NSData *imgData = [teamManager.imageDataDictionary valueForKey:memberID];
    if(imgData == nil){
        dispatch_async(teamManager.scrollQueue, ^{
            NSString *avatarStr = [teamMember valueForKey:@"avatar"];
            NSURL *avatartURL = [NSURL URLWithString:avatarStr];
            NSData *data = [NSData dataWithContentsOfURL:avatartURL];
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell updateCellWithData:data andName:nameStr];
            });
            [teamManager storeDataForId:memberID withData:data];
        });
    } else {
        [cell updateCellWithData:imgData andName:nameStr];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    StoriesViewController *storyController = [[StoriesViewController alloc]init];
    
    // Multiple by 2 because we also inserted the text views.
    storyController.viewIndex = indexPath.row * 2;
    [self presentViewController:storyController animated:YES completion:^{
        NSLog(@"Completed");
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(60, 80);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[[TeamManager sharedInstance]teamArray]count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

-(CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10.0;
}



#pragma table view

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"memberCell" forIndexPath:indexPath];

    TeamManager *teamManager = [TeamManager sharedInstance];
    teamArray = teamManager.teamArray;
    
    NSDictionary *teamMember = [teamArray objectAtIndex:indexPath.section];
    NSString *firstName = [teamMember valueForKey:@"firstName"];
    NSString *lastName = [teamMember valueForKey:@"lastName"];
    NSString *fullName = [NSString stringWithFormat:@"%@ %@",firstName,lastName];
    NSString *memberID = [teamMember valueForKey:@"id"];
    
    NSData *imgData = [teamManager.imageDataDictionary valueForKey:memberID];
    if(imgData == nil){
        dispatch_async(teamManager.tableQueue, ^{
            NSString *avatarStr = [teamMember valueForKey:@"avatar"];
            NSURL *avatartURL = [NSURL URLWithString:avatarStr];
            NSData *data = [NSData dataWithContentsOfURL:avatartURL];
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell updateCellWithData:data andName:fullName];
            });
            [teamManager storeDataForId:memberID withData:data];
        });
    } else {
        [cell updateCellWithData:imgData andName:fullName];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StoriesViewController *storyController = [[StoriesViewController alloc]init];
    
    // Multiple by 2 because we also inserted the text views.
    storyController.viewIndex = indexPath.section * 2;
    [self presentViewController:storyController animated:YES completion:^{
        NSLog(@"Completed");
    }];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return [[[TeamManager sharedInstance]teamArray]count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 12.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return screenWidth * .625;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
