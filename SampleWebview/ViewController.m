//
//  ViewController.m
//  SampleWebview
//
//  Created by Aravind Mariappan on 29/06/15.
//  Copyright (c) 2015 Tringapps. All rights reserved.
//

#import "ViewController.h"
#import "DownloadManager.h"

@interface ViewController ()<DownloadManagerDelegate>
@property (strong, nonatomic) DownloadManager *downloadManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self serviceHitForAPIs];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)serviceHitForAPIs
{
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *plistPath = [bundlePath stringByAppendingPathComponent:@"service.plist"];
    NSArray *plistData = [NSArray arrayWithContentsOfFile:plistPath];
       NSLog(@"URLS:%@",plistData);
    [self queueAndStartDownloadsWithArray:plistData];
    
}
- (void)queueAndStartDownloadsWithArray:(NSArray*)arrayOFServiceApis
{
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *downloadFolder = [documentsPath stringByAppendingPathComponent:@"downloads"];
    
    // create download manager instance
    
    self.downloadManager = [[DownloadManager alloc] initWithDelegate:self];
    
    // queue the files to be downloaded
    
    for (NSString *urlString in arrayOFServiceApis) {
        NSString *downloadFilename = [downloadFolder stringByAppendingPathComponent:[urlString lastPathComponent]];
        NSURL *url = [NSURL URLWithString:urlString];
        
        [self.downloadManager addDownloadWithFilename:downloadFilename URL:url];
    }
   
}
- (void)didFinishLoadingAllForManager:(DownloadManager *)downloadManager
{
    // all downloads successful
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Downloading Done..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
- (void)downloadManager:(DownloadManager *)downloadManager downloadDidFinishLoading:(Download *)download;
{
    // download failed
    // filename is retrieved from `download.filename`
    NSLog(@"Filename: %@",download.filename);
}

- (void)downloadManager:(DownloadManager *)downloadManager downloadDidFail:(Download *)download;
{
    // download failed
    // filename is retrieved from `download.filename`
}
- (void)downloadManager:(DownloadManager *)downloadManager downloadDidReceiveData:(Download *)download;
{
    // download failed
    // filename is retrieved from `download.filename`
    // the bytes downloaded thus far is `download.progressContentLength`
    // if the server reported the size of the file, it is returned by `download.expectedContentLength`
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
