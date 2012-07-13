//
//  NSError+FITParseUtilities.h
//  Fitivity
//
//  Created by Richard Ng 04/29/2012.
//  Copyright (c) 2012 Fitivity Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (FITParseUtilities)

-(NSString *)userFriendlyParseErrorDescription:(BOOL)isUserRelated;

@end
