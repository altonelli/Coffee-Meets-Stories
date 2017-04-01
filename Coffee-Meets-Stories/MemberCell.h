//
//  MemberCell.h
//  Coffee-Meets-Stories
//
//  Created by Arthur Tonelli on 3/31/17.
//  Copyright © 2017 Arthur Tonelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberCell : UITableViewCell

-(void)updateCellWithData:(NSData *)imageData andName:(NSString *)name;
-(void)updateCellWithName:(NSString *)name;

@end
