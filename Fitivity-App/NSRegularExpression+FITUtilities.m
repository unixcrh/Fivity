//
//  NSRegularExpression+FITUtilities.m
//  Fitivity
//
//  Created by Richard Ng 04/29/2012.
//  Copyright (c) 2012 Fitivity Inc. All rights reserved.
//

#import "NSRegularExpression+FITUtilities.h"

@implementation NSRegularExpression (FITUtilities)

-(BOOL)stringIsConformant:(NSString *)targetString {
  BOOL stringIsConformant = NO;
  if (targetString) {
    NSUInteger numberOfMatches = [self numberOfMatchesInString:targetString
                                                       options:(NSMatchingAnchored) 
                                                         range:NSMakeRange(0, [targetString length])];
    stringIsConformant = ((numberOfMatches > 0) && (numberOfMatches != NSNotFound));
  }
  return stringIsConformant;
}

@end
