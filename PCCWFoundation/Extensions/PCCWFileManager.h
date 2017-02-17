//
//  PCCWFileManager.h
//  NM
//
//  Created by 李智慧 on 26/10/2016.
//  Copyright © 2016 PCCW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCCWFileManager : NSObject
///----------------------------
/// @name Accessing Application's Sandbox
///----------------------------
/*!
 *  Returns the current application's sandbox's `Application Support` Dictionary path
 *
 *  @return A string containning the sandbox path of Caches for the current application.
 */
+ (NSString *)pathForApplicationSupportDirectory;

/*!
 *  Returns the sandbox's Caches path for the current application.
 *
 *  @return A string containning the sandbox path of Caches for the current application.
 */
+ (NSString *)pathForCachesDirectory;

/*!
 *  Returns the sandbox's Document path for the current application.
 *
 *  @return A string containning the sandbox path of Document for the current application.
 */
+ (NSString *)pathForDocumentsDirectory;

/*!
 *  Returns the sandbox's Library path for the current application.
 *
 *  @return A string containning the sandbox path of Library for the current application.
 */
+ (NSString *)pathForLibraryDirectory;

/*!
 *  Returns the full pathname of the bundle’s subdirectory containing resources.
 *
 *  @return A string containing the path of current application bundle's local Path
 */
+ (NSString *)pathForMainBundleDirectory;

/*!
 *  Returns the path of the temporary directory for the current user.
 *
 *  @return A string containing the path of the temporary directory for the current user. If no such directory is currently available, returns nil.
 */
+ (NSString *)pathForTemporaryDirectory;

///----------------------------
/// @name Remove File or Dictionary
///----------------------------
/*!
 *  Removes the file or directory at the specified path.
 *
 *  @param aPath A path string indicating the file or directory to remove. If the path specifies a directory, the contents of that directory are recursively removed. You may specify nil for this parameter.
 *  @param error On input, a pointer to an error object. If an error occurs, this pointer is set to an actual error object containing the error information. You may specify nil for this parameter if you do not want the error information.
 *
 *  @return YES if the item was removed successfully or if path was nil. Returns NO if an error occurred. If the delegate aborts the operation for a file, this method returns YES. However, if the delegate aborts the operation for a directory, this method returns NO.
 */
+ (BOOL)removeItemAtPath:(NSString *)aPath error:(NSError **)error;


+ (NSString *)patchForLoginedUser;
@end
