//
//  CustomCell.m
//  knotch
//
//  Created by Juan Figuera on 7/16/13.
//  Copyright (c) 2013 Juan Figuera. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [_topicLabel release];
    [_commentLabel release];
    [_detailImage release];
    [_commentBackground release];
    [_followingImage release];
    [_profileBackgroundImage release];
    [_profileAvatar release];
    [_profileNameLabel release];
    [_profileLocationLabel release];
    [_gloryNumberLabel release];
    [_gloryUnitLabel release];
    [_followersNumberLabel release];
    [_followersUnitLabel release];
    [_followingNumberLabel release];
    [_followingUnitLabel release];
    [_followersBarImage release];
    [super dealloc];
}
@end
