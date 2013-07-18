//
//  Knotch.h
//  knotch
//
//  Created by Juan Figuera on 7/14/13.
//  Copyright (c) 2013 Juan Figuera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Knotch : NSObject


@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *topic;
@property (nonatomic, copy) NSString *sentiment;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
