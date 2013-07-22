//
//  ViewController.m
//  knotch
//
//  Created by Juan Figuera on 7/14/13.
//  Copyright (c) 2013 Juan Figuera. All rights reserved.
//

#import "ViewController.h"
#import "Knotch.h"
#import "CustomCell.h"

@interface ViewController () {
    
}

@property (strong, nonatomic) NSDictionary *profileDictionary;
@property (strong, nonatomic) NSArray *profileArrayFromAFNetworking;
@property (strong, nonatomic) NSArray *knotchesArrayFromAFNetworking;
@property (strong, nonatomic) UIView *colorgraphicView;

// Placeholder implementation of colorgraphic - Needs to be refactored 
@property (strong, nonatomic) UIView *colorgraphic1View;
@property (strong, nonatomic) UIView *colorgraphic2View;
@property (strong, nonatomic) UIView *colorgraphic3View;
@property (strong, nonatomic) UIView *colorgraphic4View;
@property (strong, nonatomic) UIView *colorgraphic5View;

@end

@implementation ViewController

@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Setup colorgraphic
    self.colorgraphicView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, 320, 35)];
    self.colorgraphicView.backgroundColor = [UIColor blackColor];
    self.colorgraphicView.alpha = 0;
    [self.view addSubview:self.colorgraphicView];
    
    // Placeholder implementation of colorgraphic - Needs to be refactored
        self.colorgraphic1View = [[UIView alloc] initWithFrame:CGRectMake(16, 57, 57, 7)];
        self.colorgraphic1View.backgroundColor = [UIColor blueColor];
        self.colorgraphic1View.alpha = 0;
        [self.view addSubview:self.colorgraphic1View];
        
        self.colorgraphic2View = [[UIView alloc] initWithFrame:CGRectMake(73, 57, 57, 7)];
        self.colorgraphic2View.backgroundColor = [UIColor greenColor];
        self.colorgraphic2View.alpha = 0;
        [self.view addSubview:self.colorgraphic2View];
        
        self.colorgraphic3View = [[UIView alloc] initWithFrame:CGRectMake(130, 57, 57, 7)];
        self.colorgraphic3View.backgroundColor = [UIColor whiteColor];
        self.colorgraphic3View.alpha = 0;
        [self.view addSubview:self.colorgraphic3View];
        
        self.colorgraphic4View = [[UIView alloc] initWithFrame:CGRectMake(187, 57, 58, 7)];
        self.colorgraphic4View.backgroundColor = [UIColor orangeColor];
        self.colorgraphic4View.alpha = 0;
        [self.view addSubview:self.colorgraphic4View];
        
        self.colorgraphic5View = [[UIView alloc] initWithFrame:CGRectMake(245, 57, 59, 7)];
        self.colorgraphic5View.backgroundColor = [UIColor redColor];
        self.colorgraphic5View.alpha = 0;
        [self.view addSubview:self.colorgraphic5View];
        

    // Initialize Profile and Knotches arrays
    self.profileArrayFromAFNetworking  = [[NSArray alloc] init];
    self.knotchesArrayFromAFNetworking = [[NSArray alloc] init];
    
    // Placeholder Profile dictionary - (need to refactor this, issue w/ NSArray, should use a class instead)
    self.profileDictionary             = [[NSDictionary alloc] init];
	
    // Setup AFNetworking's url and req
    NSURL *url = [NSURL URLWithString:@"http://dev.knotch.it:8080/miniProject/user_feed/500e3b57bbcd08696800000a/18"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // Initialize AFNetworking
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            // Store knotches in NSArray
            self.profileArrayFromAFNetworking = [JSON objectForKey:@"userInfo"];
            NSLog(@"profile array %@", self.profileArrayFromAFNetworking);
            
            // Create profile dictionary - (need to refactor this, issue w/ NSArray, should use a class instead)
            self.profileDictionary = @{
                                         @"name"          : [JSON valueForKeyPath:@"userInfo.name"],
                                         @"location"      : [JSON valueForKeyPath:@"userInfo.location"],
                                         @"num_followers" : [JSON valueForKeyPath:@"userInfo.num_followers"],
                                         @"num_following" : [JSON valueForKeyPath:@"userInfo.num_following"],
                                         @"num_glory"     : [JSON valueForKeyPath:@"userInfo.num_glory"],
                                         @"profilePicUrl" : [JSON valueForKeyPath:@"userInfo.profilePicUrl"]
                                     };
            
            // Store knotches in NSArray
            self.knotchesArrayFromAFNetworking = [JSON objectForKey:@"knotches"];
             NSLog(@"knotches array %@", self.knotchesArrayFromAFNetworking);
            
            // Setup Name at Nav Bar label
            self.nameTopLabel.text   = [JSON valueForKeyPath:@"userInfo.name"];
            self.nameTopLabel.font   = [UIFont fontWithName:@"Aller" size:17.5];
            
            // Call tableview display
            [self.tableView reloadData];
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"Recieved an HTTP %d", response.statusCode);
            NSLog(@"The error was: %@", error);
        }];
    
    [operation start];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma UITableViewDelegate / UITableViewDatasource methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return number of rows in section.
    return [self.knotchesArrayFromAFNetworking count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Define row height.
    if (indexPath.row == 0) {
        return 410.0;
    }
    return 170.0;
}

-(void)scrollViewDidScroll:(UITableView *)tableView
{
    // Display colorgraphic upon scrolling
    NSLog(@"offset: %f", tableView.contentOffset.y);
    
    // Keep view's coordinates unchanged  
    CGRect newFrame = self.colorgraphicView.frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = 43;
    self.colorgraphicView.frame = newFrame;
    
    // Placeholder implementation of colorgraphic - Needs to be refactored
    CGRect newFrame1 = self.colorgraphic1View.frame;
    newFrame1.origin.x = 0;
    newFrame1.origin.y = 43;
    
    CGRect newFrame2 = self.colorgraphic2View.frame;
    newFrame2.origin.x = 5;
    newFrame2.origin.y = 43;
    
    CGRect newFrame3 = self.colorgraphic3View.frame;
    newFrame3.origin.x = 10;
    newFrame3.origin.y = 43;
    
    CGRect newFrame4 = self.colorgraphic4View.frame;
    newFrame4.origin.x = 15;
    newFrame4.origin.y = 43;
    
    CGRect newFrame5 = self.colorgraphic5View.frame;
    newFrame5.origin.x = 20;
    newFrame5.origin.y = 43;
    
    self.colorgraphicView.frame = newFrame;
    
    // Display colorgraphic upon scrolling
    if (tableView.contentOffset.y < 228){
        self.colorgraphicView.alpha  = 0;
        // Placeholder implementation of colorgraphic
        self.colorgraphic1View.alpha = 0;
        self.colorgraphic2View.alpha = 0;
        self.colorgraphic3View.alpha = 0;
        self.colorgraphic4View.alpha = 0;
        self.colorgraphic5View.alpha = 0;
        
    }
    else if (tableView.contentOffset.y > 228 ){
        self.colorgraphicView.alpha  = 1;
        // Placeholder implementation of colorgraphic
        self.colorgraphic1View.alpha = 1;
        self.colorgraphic2View.alpha = 1;
        self.colorgraphic3View.alpha = 1;
        self.colorgraphic4View.alpha = 1;
        self.colorgraphic5View.alpha = 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Create dictionary with knotches data
    NSDictionary *knotchesDictionary= [self.knotchesArrayFromAFNetworking objectAtIndex:indexPath.row];
    
    // Create sentiment dictionary
    NSDictionary *sentimentDictionary = @{
                                          @"0" : @"0x2e5ca6",
                                          @"2" : @"0x586db9",
                                          @"4" : @"0x008fd0",
                                          @"6" : @"0x57cccc",
                                          @"8" : @"0xceebee",
                                          @"10": @"0x2e5ca6",
                                          @"12": @"0xffeec3",
                                          @"14": @"0xffcc43",
                                          @"16": @"0xffa02d",
                                          @"18": @"0xff6d3a",
                                          @"20": @"0xee443a",
                                          };
    
    // Add margin for sentiment = 10 (white)
    // *** Placeholder ***
    
    
    // Get knotch sentiment from knotchesDictionary
    NSString *sentiment = [[knotchesDictionary objectForKey:@"sentiment"] stringValue];
    // Get sentiment's color from sentimentDictionary
    NSString *colorFromSentimentDictionary = [sentimentDictionary objectForKey:sentiment];
    
    // Placeholder implementation of colorgraphic - Needs to be refactored
    switch(indexPath.row)
    {
        case 0:
            self.colorgraphic1View.backgroundColor = [self colorWithHexString:colorFromSentimentDictionary];
            break;
        case 2:
            self.colorgraphic2View.backgroundColor = [self colorWithHexString:colorFromSentimentDictionary];
            break;
        case 3:
            self.colorgraphic3View.backgroundColor = [self colorWithHexString:colorFromSentimentDictionary];
            break;
        case 4:
            self.colorgraphic4View.backgroundColor = [self colorWithHexString:colorFromSentimentDictionary];
            break;
        case 5:
            self.colorgraphic5View.backgroundColor = [self colorWithHexString:colorFromSentimentDictionary];
            break;
        default:
            self.colorgraphic5View.backgroundColor = [self colorWithHexString:colorFromSentimentDictionary];
            break;
    };
    
    // Populate Profile Cell
    if (indexPath.row == 0) {
        NSLog(@"displaying profile");
        
        // *** Profile Cell ***
        
        // Profile section
        cell.profileBackgroundImage.backgroundColor =
                                    [UIColor colorWithRed:255.0f/255.0f
                                                    green:204.0f/255.0f
                                                     blue:67.0f/255.0f
                                                    alpha:1.0];
        [cell.profileAvatar setImageWithURL:[NSURL URLWithString:[self.profileDictionary
                                                 valueForKeyPath:@"profilePicUrl"]]];
        
        // Stats section
        cell.profileNameLabel.text      = [self.profileDictionary valueForKeyPath:@"name"];
        cell.profileNameLabel.font      = [UIFont fontWithName:@"Aller" size:17.5];
        cell.profileLocationLabel.text  = [self.profileDictionary valueForKeyPath:@"location"];
        cell.profileLocationLabel.font  = [UIFont fontWithName:@"Aller-Light" size:10.5];
        cell.gloryNumberLabel.text      = [NSString stringWithFormat:@"%@",
                                          [self.profileDictionary valueForKeyPath:@"num_glory"]];
        cell.gloryNumberLabel.font      = [UIFont fontWithName:@"Lato-Bold" size:15];
        cell.followersNumberLabel.text  = [NSString stringWithFormat:@"%@",
                                          [self.profileDictionary valueForKeyPath:@"num_followers"]];
        cell.followersNumberLabel.font  = [UIFont fontWithName:@"Lato-Bold" size:15];
        cell.followingNumberLabel.text  = [NSString stringWithFormat:@"%@",
                                          [self.profileDictionary valueForKeyPath:@"num_following"]];
        cell.followingNumberLabel.font  = [UIFont fontWithName:@"Lato-Bold" size:15];
        cell.gloryUnitLabel.text        = @"Glory";
        cell.gloryUnitLabel.font        = [UIFont fontWithName:@"Aller-Light" size:10];
        cell.followersUnitLabel.text    = @"Followers";
        cell.followersUnitLabel.font    = [UIFont fontWithName:@"Aller-Light" size:10];
        cell.followingUnitLabel.text    = @"Following";
        cell.followingUnitLabel.font    = [UIFont fontWithName:@"Aller-Light" size:10];
        cell.followersBarImage.image    = [UIImage imageNamed:@"followers-bar@2x.png"];
        cell.followingImage.image       = [UIImage imageNamed:@"following-button@2x.png"];
        cell.colorgraphicImage.image    = [UIImage imageNamed:@"colour-bar_test@2x.png"];
        
        cell.commentBackground.backgroundColor = [self colorWithHexString:colorFromSentimentDictionary];
        
        // Row #1 - Should refactor this, issue placing it inside:  if (indexPath.row > 0)
        cell.topicLabel.text   = [knotchesDictionary objectForKey:@"topic"];
        cell.topicLabel.font   = [UIFont fontWithName:@"Aller" size:17.5];
        cell.commentLabel.text = [knotchesDictionary objectForKey:@"comment"];
        cell.commentLabel.font = [UIFont fontWithName:@"Lato-Bold" size:15];
        
        return cell;
        
    } else if (indexPath.row > 0)
    {
        
        // *** Reset Profile Cell - Should refactor this ***
        // Profile section 
        cell.profileBackgroundImage.backgroundColor =  nil;
        cell.profileAvatar.image = nil;
        // Stats section
        cell.profileNameLabel.text      = nil;
        cell.profileLocationLabel.text  = nil;
        cell.profileLocationLabel.font  = nil;
        cell.gloryNumberLabel.text      = nil;
        cell.followersNumberLabel.text  = nil;
        cell.followingNumberLabel.text  = nil;
        cell.gloryUnitLabel.text        = nil;
        cell.followersUnitLabel.text    = nil;
        cell.followingUnitLabel.text    = nil;
        cell.followersBarImage.image    = nil;
        cell.followingImage.image       = nil;
        cell.colorgraphicImage.image    = nil;
        
        // Populate Knotch Cell
        NSLog(@"Display Knotch Content ");
        
        // *** Knotch Cell ***
        cell.topicLabel.text   = [knotchesDictionary objectForKey:@"topic"];
        cell.topicLabel.font   = [UIFont fontWithName:@"Aller" size:17.5];
        cell.commentLabel.text = [knotchesDictionary objectForKey:@"comment"];
        cell.commentLabel.font = [UIFont fontWithName:@"Lato-Bold" size:15];
        cell.commentBackground.backgroundColor = [self colorWithHexString:colorFromSentimentDictionary];
        
        // Edit quote color depending on background colow
        // i.e. black in case of knotch sentiment = 10 (white)
        // *** Placeholder ***
        
    }
    return cell;
}

#pragma UITableViewDelegate / UITableViewDatasource helper methods

// Returns RGB equivalent of given Hex color
// Look to refactor this with:
// #define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
- (UIColor *) colorWithHexString: (NSString *) stringToConvert{
    
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location     = 0;
    range.length       = 2;
    NSString *rString  = [cString substringWithRange:range];
    range.location     = 2;
    NSString *gString  = [cString substringWithRange:range];
    range.location     = 4;
    NSString *bString  = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

- (void)dealloc {
    [_nameTopLabel release];
    [_tableView release];
    [super dealloc];
}

@end
