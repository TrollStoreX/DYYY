#import <substrate.h>
#import <objc/runtime.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

#import "DYYYSettingViewController.h"

@interface AWEURLModel : NSObject
@property (copy, nonatomic) NSArray* originURLList;
@end

@interface AWEMusicModel : NSObject
@property (readonly, nonatomic) AWEURLModel* playURL;
@end

@interface AWEVideoModel : NSObject
@property(readonly, nonatomic) AWEURLModel* playURL;
@property(readonly, nonatomic) AWEURLModel* h264URL;
@property(readonly, nonatomic) AWEURLModel *coverURL;
@end

@interface AWEImageAlbumImageModel : NSObject
@property (copy, nonatomic) NSString* uri;
@property (copy, nonatomic) NSArray* urlList;
@property (copy, nonatomic) NSArray* downloadURLList;
@end

@interface AWEAwemeModel : NSObject
@property(readonly, nonatomic) AWEVideoModel* video;
@property(retain, nonatomic) AWEMusicModel* music;
@property(nonatomic) NSArray<AWEImageAlbumImageModel *> *albumImages;
@property (nonatomic) NSInteger awemeType;
@property(nonatomic) NSInteger currentImageIndex;
@end

@interface AWEPlayInteractionViewController : UIViewController
@property(readonly, nonatomic) AWEAwemeModel *model;
@end

@interface DUXToast : UIView
+ (void)showText:(id)arg1 withCenterPoint:(CGPoint)arg2;
+ (void)showText:(id)arg1;
@end

@interface AWEProgressLoadingView : UIView
- (id)initWithType:(NSInteger)arg1 title:(NSString *)arg2;
- (id)initWithType:(NSInteger)arg1 title:(NSString *)arg2 progressTextFont:(UIFont *)arg3 progressCircleWidth:(NSNumber *)arg4;
- (void)dismissWithAnimated:(BOOL)arg1;
- (void)dismissAnimated:(BOOL)arg1;
- (void)showOnView:(id)arg1 animated:(BOOL)arg2;
- (void)showOnView:(id)arg1 animated:(BOOL)arg2 afterDelay:(CGFloat)arg3;
@end

@interface AWESettingItemModel : NSObject
@property (nonatomic, strong, readwrite) NSString *identifier;
@property (nonatomic, strong, readwrite) NSString *title;
@property (nonatomic, assign, readwrite) NSInteger type;
@property (nonatomic, strong, readwrite) NSString *svgIconImageName;
@property (nonatomic, strong, readwrite) NSString *iconImageName;
@property (nonatomic, assign, readwrite) NSInteger cellType;
@property (nonatomic, assign, readwrite) BOOL isEnable;
@property (nonatomic, copy, readwrite) id cellTappedBlock;
@property (nonatomic, assign, readwrite) NSInteger colorStyle;
@property (nonatomic, strong, readwrite) NSString *detail;
@end

@interface AWESettingSectionModel : NSObject
@property (nonatomic, strong, readwrite) NSArray<AWESettingItemModel *> *itemArray;
@property (nonatomic, assign, readwrite) NSInteger type;
@property (nonatomic, strong, readwrite) NSString *sectionHeaderTitle;
@property (nonatomic, assign, readwrite) CGFloat sectionHeaderHeight;
@end

@interface AWESettingsViewModel : NSObject
@property (nonatomic, weak, readwrite) id controllerDelegate;
@end

%hook AWESettingsViewModel

- (NSArray *)sectionDataArray {
    NSArray *originalSections = %orig;

    BOOL sectionExists = NO;
    for (AWESettingSectionModel *section in originalSections) {
        if ([section.sectionHeaderTitle isEqualToString:@"DYYY"]) {
            sectionExists = YES;
            break;
        }
    }

    if (!sectionExists) {
        AWESettingItemModel *newItem = [[%c(AWESettingItemModel) alloc] init];
        newItem.identifier = @"DYYY";
        newItem.title = @"DYYY";
        newItem.detail = @"2.0-9";
        newItem.type = 0;
        newItem.iconImageName = @"noticesettting_like";
        newItem.cellType = 26;
        newItem.colorStyle = 2;
        newItem.isEnable = YES;

        newItem.cellTappedBlock = ^(AWESettingItemModel *item) {
            UIViewController *rootViewController = self.controllerDelegate;
            DYYYSettingViewController *dyyyVC = [[DYYYSettingViewController alloc] init];
            [rootViewController.navigationController pushViewController:dyyyVC animated:YES];
        };

        AWESettingSectionModel *newSection = [[%c(AWESettingSectionModel) alloc] init];
        newSection.itemArray = @[newItem];
        newSection.type = 0;
        newSection.sectionHeaderHeight = 40;
        newSection.sectionHeaderTitle = @"DYYY";

        NSMutableArray<AWESettingSectionModel *> *newSections = [NSMutableArray arrayWithArray:originalSections];
        [newSections insertObject:newSection atIndex:0];

        return newSections;
    }

    return originalSections;
}

%end

void showToast(NSString *text) {
    [%c(DUXToast) showText:text];
}

void saveMedia(NSURL *mediaURL, BOOL isVideo) {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                if (isVideo) {
                    [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:mediaURL];
                } else {
                    UIImage *image = [UIImage imageWithContentsOfFile:mediaURL.path];
                    if (image) {
                        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
                    }
                }
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (success) {
                    NSString *str = [NSString stringWithFormat:@"%@已保存到相册", isVideo ? @"视频" : @"图片"];
                    showToast(str);
                } else {
                    showToast(@"保存失败");
                }

                [[NSFileManager defaultManager] removeItemAtPath:mediaURL.path error:nil];
            }];
        }
    }];
}

void downloadMedia(NSURL *url, BOOL isVideo) {
    dispatch_async(dispatch_get_main_queue(), ^{
        AWEProgressLoadingView *loadingView = [[%c(AWEProgressLoadingView) alloc] initWithType:0 title:@"保存相册中..."];
        [loadingView showOnView:[UIApplication sharedApplication].keyWindow animated:YES];

        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url
            completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {

                dispatch_async(dispatch_get_main_queue(), ^{
                    [loadingView dismissAnimated:YES];
                });

                if (!error) {
                    NSString *fileName = url.lastPathComponent;
                    if (![fileName.pathExtension length] && isVideo) {
                        fileName = [fileName stringByAppendingPathExtension:@"mp4"];
                    }

                    NSURL *documentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
                    NSURL *destinationURL = [documentsDirectory URLByAppendingPathComponent:fileName];

                    [[NSFileManager defaultManager] moveItemAtURL:location toURL:destinationURL error:nil];

                    saveMedia(destinationURL, isVideo);
                } else {
                    showToast(@"下载失败");
                }
            }];

        [downloadTask resume];
    });
}

%hook AWEPlayInteractionViewController

- (void)onVideoPlayerViewDoubleClicked:(UITapGestureRecognizer *)tapGes {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"DYYYDoubleClickedDownload"]) return %orig;
    AWEAwemeModel *awemeModel = self.model;
    AWEVideoModel *videoModel = awemeModel.video;
    AWEMusicModel *musicModel = awemeModel.music;

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无水印下载" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    NSString *typeStr = @"下载视频";
    NSInteger aweType = awemeModel.awemeType;

    if (aweType == 68) typeStr = @"下载图片";

    [alertController addAction:[UIAlertAction actionWithTitle:typeStr style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSURL *url = nil;
        if (aweType == 68) {
            AWEImageAlbumImageModel *currentImageModel = nil;
            if (awemeModel.albumImages.count == 1) {
                currentImageModel = [awemeModel.albumImages objectAtIndex:awemeModel.currentImageIndex];
            } else {
                currentImageModel = [awemeModel.albumImages objectAtIndex:awemeModel.currentImageIndex - 1];
            }
            url = [NSURL URLWithString:currentImageModel.urlList.firstObject];
            downloadMedia(url, NO);
        } else {
            url = [NSURL URLWithString:videoModel.h264URL.originURLList.firstObject];
            downloadMedia(url, YES);
        }
    }]];

    [alertController addAction:[UIAlertAction actionWithTitle:@"下载音频" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSURL *url = [NSURL URLWithString:musicModel.playURL.originURLList.firstObject];
        // 未处理
    }]];

    [alertController addAction:[UIAlertAction actionWithTitle:@"下载封面" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSURL *url = [NSURL URLWithString:videoModel.coverURL.originURLList.firstObject];
        downloadMedia(url, NO);
    }]];

    [alertController addAction:[UIAlertAction actionWithTitle:@"点赞视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        %orig;
    }]];

    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];

    [self presentViewController:alertController animated:YES completion:nil];
}

%end