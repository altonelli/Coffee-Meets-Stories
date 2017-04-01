//
//  StoryScrollViewFlowLayout.m
//  Coffee-Meets-Stories
//
//  Created by Arthur Tonelli on 3/28/17.
//  Copyright © 2017 Arthur Tonelli. All rights reserved.
//

#import "StoryScrollViewFlowLayout.h"

@implementation StoryScrollViewFlowLayout

-(id)init {
    if((self = [super init])) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 10000.0f;
    }
    return self;
}

@end
