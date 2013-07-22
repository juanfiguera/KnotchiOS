//
//  CustomCell.h
//  knotch
//
//  Created by Juan Figuera on 7/16/13.
//  Copyright (c) 2013 Juan Figuera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

// *** Profile Cell ***

// Profile
@property (retain, nonatomic) IBOutlet UIImageView *profileBackgroundImage;
@property (retain, nonatomic) IBOutlet UIImageView *profileAvatar;
@property (retain, nonatomic) IBOutlet UILabel *profileNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *profileLocationLabel;
// Stats
@property (retain, nonatomic) IBOutlet UILabel *gloryNumberLabel;
@property (retain, nonatomic) IBOutlet UILabel *gloryUnitLabel;
@property (retain, nonatomic) IBOutlet UILabel *followersNumberLabel;
@property (retain, nonatomic) IBOutlet UILabel *followersUnitLabel;
@property (retain, nonatomic) IBOutlet UILabel *followingNumberLabel;
@property (retain, nonatomic) IBOutlet UILabel *followingUnitLabel;
@property (retain, nonatomic) IBOutlet UIImageView *followersBarImage;
@property (retain, nonatomic) IBOutlet UIImageView *followingImage;
// Colorgraphic

@property (retain, nonatomic) IBOutlet UIImageView *colorgraphicImage;


// *** Knotch Cell ***
@property (retain, nonatomic) IBOutlet UILabel *quoteLabel;
@property (retain, nonatomic) IBOutlet UILabel *topicLabel;
@property (retain, nonatomic) IBOutlet UILabel *commentLabel;
@property (retain, nonatomic) IBOutlet UIImageView *commentBackground;
@property (retain, nonatomic) IBOutlet UIImageView *detailImage;



@end
