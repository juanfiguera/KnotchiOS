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
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController () {
    
}
@property (strong, nonatomic) NSDictionary *profileDictionary;

@property (strong, nonatomic) NSArray *profileArrayFromAFNetworking;
@property (strong, nonatomic) NSArray *knotchesArrayFromAFNetworking;

@end

@implementation ViewController

@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Initialize arrays and dictionary
    self.profileArrayFromAFNetworking =  [[NSArray alloc] init];
    self.knotchesArrayFromAFNetworking = [[NSArray alloc] init];
    self.profileDictionary =  [[NSDictionary alloc] init];
	
    // Initialize AFNetworking
    NSURL *url = [NSURL URLWithString:@"http://dev.knotch.it:8080/miniProject/user_feed/500e3b57bbcd08696800000a/10"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            // Store knotches in NSArray
            self.profileArrayFromAFNetworking = [JSON objectForKey:@"userInfo"];
            NSLog(@"profile array %@", self.profileArrayFromAFNetworking);
            
            // Create profile dictionary (need to refactor this, issue w/ NSArray)
            self.profileDictionary = @{
                                     @"name": [JSON valueForKeyPath:@"userInfo.name"],
                                     @"location": [JSON valueForKeyPath:@"userInfo.location"],
                                     @"num_followers": [JSON valueForKeyPath:@"userInfo.num_followers"],
                                     @"num_following": [JSON valueForKeyPath:@"userInfo.num_following"],
                                     @"num_glory": [JSON valueForKeyPath:@"userInfo.num_glory"],
                                     @"profilePicUrl": [JSON valueForKeyPath:@"userInfo.profilePicUrl"]
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.knotchesArrayFromAFNetworking count];
}

// Adjust cell heights according to row value 
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
//{
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            NSLog(@"should be 0, row: %ld", (long)indexPath.row);
//            return 417.0;
//        }
//    }
//    NSLog(@"should be gt 0, row: %ld", (long)indexPath.row);
//    return 130.0;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Cell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    // Create dictionary with knotches data
    NSDictionary *knotchesDictionary= [self.knotchesArrayFromAFNetworking objectAtIndex:indexPath.row];
    
    // Get currentRow
    int currentRow = (int)indexPath.row;
    NSLog(@"Current row: %d", currentRow);
    
    // Populate Profile Cell
    if (currentRow < 1)
    {
        
    // *** Profile Cell ***
    
    // Profile section
    cell.profileBackgroundImage.backgroundColor =  [UIColor colorWithRed:255.0f/255.0f
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
    
    // Colorgraphic section

//   Custom colorgraphic will be here
//        if(tableView.contentOffset.y<0){
//            //it means table view is pulled down like refresh
//            NSLog(@" y is less than 0");
//        }
//        else if(tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height)) {
//            NSLog(@"bottom!");
//            NSLog(@" y is gt 0");
//           // [self getMoreStuff:[self getLastMessageID]];
//        }
    
    // Populate Knotch Cell   
    } else if (currentRow > 1)
    {
        tableView.rowHeight = 130.0;
        NSLog(@"row height should be 130 => %f", [tableView rowHeight]);
        cell.followingImage.backgroundColor = [UIColor clearColor];
    }
    
    // *** Knotch Cell ***
    cell.topicLabel.text = [knotchesDictionary objectForKey:@"topic"];
    cell.topicLabel.font = [UIFont fontWithName:@"Aller" size:17.5];
    cell.commentLabel.text = [knotchesDictionary objectForKey:@"comment"];
    cell.commentLabel.font = [UIFont fontWithName:@"Lato-Bold" size:15];
    
    // Create sentiment dictionary
    NSDictionary *sentimentDictionary = @{
                                          @"0": @"0x2e5ca6",
                                          @"2": @"0x586db9",
                                          @"4": @"0x008fd0",
                                          @"6": @"0x57cccc",
                                          @"8": @"0xceebee",
                                          @"10": @"0x2e5ca6",
                                          @"12": @"0xffeec3",
                                          @"14": @"0xffcc43",
                                          @"16": @"0xffa02d",
                                          @"18": @"0xff6d3a",
                                          @"20": @"0xee443a",
                                          };
    
    // Get knotch sentiment from knotchesDictionary
    NSString *sentiment = [[knotchesDictionary objectForKey:@"sentiment"] stringValue];
    
    // Get sentiment's color from sentimentDictionary
    NSString *colorFromSentimentDictionary = [sentimentDictionary objectForKey:sentiment];
    
    // Set comment's sentiment color background
    cell.commentBackground.backgroundColor = [self colorWithHexString:colorFromSentimentDictionary];
    
    return cell;
}

#pragma UITableViewDelegate / UITableViewDatasource helper methods

// Returns RGB equivalent of given Hex color
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
