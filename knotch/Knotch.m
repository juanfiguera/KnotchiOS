//
//  Knotch.m
//  knotch
//
//  Created by Juan Figuera on 7/14/13.
//  Copyright (c) 2013 Juan Figuera. All rights reserved.
//

#import "Knotch.h"

@implementation Knotch

@synthesize comment = _comment;
@synthesize topic = _topic;
@synthesize sentiment = _sentiment;

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.comment = [dictionary objectForKey:@"comment"];
        self.topic = [dictionary objectForKey:@"topic"];
        self.sentiment = [dictionary objectForKey:@"sentiment"];
    }
    
    return self;
}

- (void)dealloc {
    [_comment release];
    [_topic release];
    [_sentiment release];
    [super dealloc];
}


@end
