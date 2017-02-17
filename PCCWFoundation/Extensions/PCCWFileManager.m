//
//  PCCWFileManager.m
//  NM
//
//  Created by 李智慧 on 26/10/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import "PCCWFileManager.h"

@implementation PCCWFileManager
#pragma mark - CalicoFimeAccess


#pragma mark - SystemFileManager

#pragma mark AccessFile
///----------------------------
/// @name Query File
///----------------------------
+ (BOOL)itemExistsAtPath:(NSString *)aPath {
    return [[NSFileManager defaultManager] fileExistsAtPath:aPath];
}

#pragma mark Create
///----------------------------
/// @name Create File or Dictionary
///----------------------------
/*!
 *  Creates a directory with given attributes at the specified path.
 *
 *  @param aPath  A path string identifying the directory to create.
 *  You may specify a full path or a path that is relative to the current working directory.
 *  This parameter must not be nil.
 *  @param pError On input, a pointer to an error object.
 *  If an error occurs, this pointer is set to an actual error object containing the error information.
 *  You may specify nil for this parameter if you do not want the error information.
 *
 *  @return YES if the directory was created, YES if createIntermediates is set and the directory already exists), or NO if an error occurred.
 */
+ (BOOL)createDictionaryAtPath:(NSString *)aPath error:(NSError **)pError {
    [PCCWFileManager assertPath:aPath];
    if ([PCCWFileManager itemExistsAtPath:aPath]) return YES;
    return [[NSFileManager defaultManager] createDirectoryAtPath:aPath withIntermediateDirectories:YES attributes:nil error:pError];
}

/*!
 *  Creates a file with the specified content and attributes at the given location.
 *
 *  @param aPath The path for the new file.
 *  @param data  A data object containing the contents of the new file.
 *
 *  @return YES if the operation was successful or if the item already exists, otherwise NO.
 */
+ (BOOL)createFileAtPath:(NSString *)aPath data:(NSData *)data {
    [PCCWFileManager assertPath:aPath];
    [PCCWFileManager createDictionaryAtPath:[aPath stringByDeletingLastPathComponent] error:nil];
    return [[NSFileManager defaultManager] createFileAtPath:aPath contents:data attributes:nil];
}

#pragma mark Delete

+ (BOOL)removeItemAtPath:(NSString *)aPath error:(NSError **)error {
    [PCCWFileManager assertPath:aPath];
    BOOL isSuccess = YES;
    if ([[NSFileManager defaultManager] fileExistsAtPath:aPath]) isSuccess = [[NSFileManager defaultManager] removeItemAtPath:aPath error:error];
    return isSuccess;
}

+ (NSString *)pathForApplicationSupportDirectory {
    static NSString *path = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
        path = [paths lastObject];
    });
    return path;
}

+ (NSString *)pathForCachesDirectory {
    static NSString *path = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        path = [paths lastObject];
    });
    return path;
}

+ (NSString *)pathForDocumentsDirectory {
    static NSString *path = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        path = [paths lastObject];
    });
    return path;
}

+ (NSString *)pathForLibraryDirectory {
    static NSString *path = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        path = [paths lastObject];
    });
    return path;
}

+ (NSString *)pathForMainBundleDirectory {
    return [NSBundle mainBundle].resourcePath;
}

+ (NSString *)pathForTemporaryDirectory {
    static NSString *path = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        path = NSTemporaryDirectory();
    });
    return path;
}

+ (NSString *)patchForLoginedUser{
    return [[[PCCWFileManager pathForDocumentsDirectory] stringByAppendingPathComponent:@"User"] stringByAppendingPathExtension:@"user.plist"];
}

#pragma mark - Asserts

/*!
 *  Assert the specified path not nil or equal to @""
 *
 *  @param aPath the path to Assert
 */
+ (void)assertPath:(NSString *)aPath {
    NSAssert(aPath != nil, @"Invalid path. Path cannot be nil.");
    NSAssert(![aPath isEqualToString:@""], @"Invalid path. Path cannot be empty string.");
}

@end
