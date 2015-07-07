//
//  KeychainHelper.m
//  theMostAmazingFinalProject
//
//  Created by Samuel Fanfan on 28/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "KeychainHelper.h"

@implementation KeychainHelper

+(void)storeTheToken:(NSString *)token
{
    //Encrypt the token
    NSData *tokenData = [token dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedTokenData = [tokenData base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *encryptedToken = [[NSString alloc] initWithData:encryptedTokenData encoding:NSUTF8StringEncoding];
    
    //Use a UUID for uniqueness
    NSString *uuid = [[NSUUID UUID] UUIDString];
    
    //Store UUID to NSUserDefauls for later use
    NSUserDefaults *uuidStorage = [NSUserDefaults standardUserDefaults];
    //Check if UUID is already stored in NSUserDefaults. If so use the current UUID
    NSString *test = [uuidStorage objectForKey:@"UUID_String"];
    if ((test != nil) && ![test isEqualToString:@""])
    {
        //A UUID already exists so use that one
        uuid = [test copy];
    }
    
    [uuidStorage setObject:uuid forKey:@"UUID_String"];
    
    //Create the keychain and add the token
    KeychainItemWrapper *theKeychain = [[KeychainItemWrapper alloc] initWithIdentifier:uuid accessGroup:nil];
    [theKeychain setObject:encryptedToken forKey:(__bridge id)(kSecAttrAccount)];


}

+(NSString *)getToken
{
    //Retrieve the UUID from NSUserDefaults
    NSUserDefaults *uuidStorage = [NSUserDefaults standardUserDefaults];
    NSString *uuid = [uuidStorage stringForKey:@"UUID_String"];
    
    if (!uuid) {
        return nil;
    }
    
    //Create the keychain
    KeychainItemWrapper *theKeychain = [[KeychainItemWrapper alloc] initWithIdentifier:uuid accessGroup:nil];
    
    //Decrypt the token
    NSString *encryptedToken = [theKeychain objectForKey:(__bridge id)(kSecAttrAccount)];
    NSData *encryptedTokenData = [encryptedToken dataUsingEncoding:NSUTF8StringEncoding];
    NSData *decryptedTokenData = [[NSData alloc] initWithBase64EncodedData:encryptedTokenData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *decryptedToken = [[NSString alloc] initWithData:decryptedTokenData encoding:NSUTF8StringEncoding];
    
    //Retrieve the token from the keychain
    return decryptedToken;
}

@end
