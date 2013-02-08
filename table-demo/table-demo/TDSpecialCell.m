//
//  TDSpecialCell.m
//  table-demo
//
//  Created by John Bender on 2/8/13.
//  Copyright (c) 2013 General UI, LLC. All rights reserved.
//

#import "TDSpecialCell.h"

@implementation TDSpecialCell

-(void) populateForIndexPath:(NSIndexPath*)indexPath
{
    self.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row*100];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
