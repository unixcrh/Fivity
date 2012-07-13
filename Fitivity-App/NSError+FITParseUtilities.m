//
//  NSError+FITParseUtilities.m
//  Fitivity
//
//  Created by Richard Ng 04/29/2012.
//  Copyright (c) 2012 Fitivity Inc. All rights reserved.
//

#import "NSError+FITParseUtilities.h"
#import <Parse/Parse.h>

@implementation NSError (FITParseUtilities)

-(NSString *)userFriendlyParseErrorDescription:(BOOL)isUserRelated {
  NSString *userFriendlyParseErrorDescription = nil;
  NSInteger code = [self code];
  if (code == kPFErrorInternalServer) {
    userFriendlyParseErrorDescription = @"Internal server error. No information available.";
  } else if (code == kPFErrorConnectionFailed) {
    userFriendlyParseErrorDescription = @"The connection to the Parse servers failed.";
  } else if (code == kPFErrorObjectNotFound) {
    if (isUserRelated) {
      userFriendlyParseErrorDescription = @"Supplied an incorrect password.";
    } else {
      userFriendlyParseErrorDescription = @"Object doesn't exist.";
    }
  } else if (code == kPFErrorInvalidQuery) {
    userFriendlyParseErrorDescription = @"You tried to find values matching a datatype that doesn't support exact database matching, like an array or a dictionary.";
  } else if (code == kPFErrorInvalidClassName) {
    userFriendlyParseErrorDescription = @"Missing or invalid classname. Classnames are case-sensitive. They must start with a letter, and a-zA-Z0-9_ are the only valid characters.";
  } else if (code == kPFErrorMissingObjectId) {
    userFriendlyParseErrorDescription = @"Missing object id.";
  } else if (code == kPFErrorInvalidKeyName) {
    userFriendlyParseErrorDescription = @"Invalid key name. Keys are case-sensitive. They must start with a letter, and a-zA-Z0-9_ are the only valid characters.";
  } else if (code == kPFErrorInvalidPointer) {
    userFriendlyParseErrorDescription = @"Malformed pointer. Pointers must be arrays of a classname and an object id.";
  } else if (code == kPFErrorInvalidJSON) {
    userFriendlyParseErrorDescription = @"Malformed json object. A json dictionary is expected.";
  } else if (code == kPFErrorCommandUnavailable) {
    userFriendlyParseErrorDescription = @"Tried to access a feature only available internally.";
  } else if (code == kPFErrorIncorrectType) {
    userFriendlyParseErrorDescription = @"Field set to incorrect type.";
  } else if (code == kPFErrorInvalidChannelName) {
    userFriendlyParseErrorDescription = @"Invalid channel name. A channel name is either an empty string (the broadcast channel) or contains only a-zA-Z0-9_ characters and starts with a letter.";
  } else if (code == kPFErrorInvalidDeviceToken) {
    userFriendlyParseErrorDescription = @"Invalid device token.";
  } else if (code == kPFErrorPushMisconfigured) {
    userFriendlyParseErrorDescription = @"Push is misconfigured. See details to find out how.";
  } else if (code == kPFErrorObjectTooLarge) {
    userFriendlyParseErrorDescription = @"The object is too large.";
  } else if (code == kPFErrorOperationForbidden) {
    userFriendlyParseErrorDescription = @"That operation isn't allowed for clients.";
  } else if (code == kPFErrorCacheMiss) {
    userFriendlyParseErrorDescription = @"The results were not found in the cache.";
  } else if (code == kPFErrorInvalidNestedKey) {
    userFriendlyParseErrorDescription = @"Keys in NSDictionary values may not include '$' or '.'.";
  } else if (code == kPFErrorInvalidFileName) {
    userFriendlyParseErrorDescription = @"Invalid file name. A file name contains only a-zA-Z0-9_. characters and is between 1 and 36 characters.";
  } else if (code == kPFErrorInvalidACL) {
    userFriendlyParseErrorDescription = @"Invalid ACL. An ACL with an invalid format was saved. This should not happen if you use PFACL.";
  } else if (code == kPFErrorTimeout) {
    userFriendlyParseErrorDescription = @"The request timed out on the server. Typically this indicates the request is too expensive.";
  } else if (code == kPFErrorInvalidEmailAddress) {
    userFriendlyParseErrorDescription = @"The email address was invalid.";
  } else if (code == kPFErrorUsernameMissing) {
    userFriendlyParseErrorDescription = @"Username is missing or empty.";
  } else if (code ==  kPFErrorUserPasswordMissing) {
    userFriendlyParseErrorDescription = @"Password is missing or empty.";
  } else if (code == kPFErrorUsernameTaken) {
    userFriendlyParseErrorDescription = @"Username has already been taken.";
  } else if (code == kPFErrorUserEmailTaken) {
    userFriendlyParseErrorDescription = @"Email has already been taken.";
  } else if (code == kPFErrorUserEmailMissing) {
    userFriendlyParseErrorDescription = @"The email is missing, and must be specified.";
  } else if (code == kPFErrorUserWithEmailNotFound) {
    userFriendlyParseErrorDescription = @"A user with the specified email was not found.";
  } else if (code == kPFErrorUserCannotBeAlteredWithoutSession) {
    userFriendlyParseErrorDescription = @"The user cannot be altered by a client without the session.";
  } else if (code == kPFErrorUserCanOnlyBeCreatedThroughSignUp) {
    userFriendlyParseErrorDescription = @"Users can only be created through sign up.";
  } else if (code == kPFErrorFacebookAccountAlreadyLinked) {
    userFriendlyParseErrorDescription = @"An existing Facebook account already linked to another user.";
  } else if (code == kPFErrorUserIdMismatch) {
    userFriendlyParseErrorDescription = @"User ID mismatch.";
  } else if (code == kPFErrorFacebookIdMissing) {
    userFriendlyParseErrorDescription = @"Facebook id missing from request.";
  } else if (code == kPFErrorFacebookInvalidSession) {
    userFriendlyParseErrorDescription = @"Invalid Facebook session.";
  }
  return userFriendlyParseErrorDescription;
}

@end
