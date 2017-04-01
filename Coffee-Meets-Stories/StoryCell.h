//
//  StoryCell.h
//  Coffee-Meets-Stories
//
//  Created by Arthur Tonelli on 3/28/17.
//  Copyright © 2017 Arthur Tonelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryCell : UICollectionViewCell

-(void)updateCellWithData:(NSData *)imageData andName:(NSString *)name;
-(void)updateCellWithName:(NSString *)name;

@end
