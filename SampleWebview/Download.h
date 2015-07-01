//
//  Download.h
//  SampleWebview
//
//  Created by Aravind Mariappan on 29/06/15.
//  Copyright (c) 2015 Tringapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Download;


@protocol DownloadDelegate <NSObject>

@optional

/** Called to notify delegate that the download completed.
 *
 * Pointer to the `Download` that just completed.
 *
 */

- (void)downloadDidFinishLoading:(Download *)download;

/** Called to notify delegate that the download completed.
 *
 * Pointer to the `Download` that just failed.
 *
 */

- (void)downloadDidFail:(Download *)download;

/** Called to notify delegate that the download completed.
 *
 * Pointer to the `Download` that just failed.
 *
 */

- (void)downloadDidReceiveData:(Download *)download;

@end

/** The `Download` is a class to download a single file using `NSURLConnection`. 
 * Generally you will not interact directly with this class, but rather just
 * employ the `DownloadManager` class.
 *
 * @see DownloadManager
 */

@interface Download : NSObject <NSURLConnectionDelegate>

/// @name Properties


@property (nonatomic, copy) NSString *filename;


@property (nonatomic, copy) NSURL *url;

/** The delegate object that conforms to `DownloadDelegate`, if any.
  */

@property (nonatomic, weak) id<DownloadDelegate> delegate;

/// `BOOL` property designating whether this download is in progress or not.

@property (getter = isDownloading) BOOL downloading;

/** `long long` property that designates how large the file is (in bytes). Some
 * servers will provide this information, some will not. If no size
 * information provided, `expectedContentLength` will be negative.
 *
 * @warning Even if servers provide this information, this is not
 * always reliable. Never depend upon the accuracy of this property.
 */

@property long long expectedContentLength;

/// `long long` property indicates the current progress (in bytes).

@property long long progressContentLength;

/// If there was an error, what was it. Otherwise `nil`.

@property (nonatomic, strong) NSError *error;

/// @name Initialization

/** Returns pointer to `Download` object and initiates download from `url`, saving the file to `filename`.
 *
 * @param filename
 *
 * The local filename of the file being downloaded.
 *
 * @param url
 *
 * The remote URL of the file being downloaded. 
 *
 * @param delegate
 *
 * The delegate object to be notified of the status of the download. Must conform to `DownloadDelegate` protocol. This is optional.
 *
 */

- (id)initWithFilename:(NSString *)filename URL:(NSURL *)url delegate:(id<DownloadDelegate>)delegate;

/// @name Control

/// Start the individual download.

- (void)start;

/// Cancel the individual download, whether in progress or simply pending.

- (void)cancel;

@end
