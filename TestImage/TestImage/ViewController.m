//
//  ViewController.m
//  TestImage
//
//  Created by zm on 2016/10/28.
//  Copyright © 2016年 zmMac. All rights reserved.
//

#import "ViewController.h"
#import "UIViewAdditions.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview1;
@property (nonatomic, strong) UIImageView * tView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //3024x4023/2.1MB

    _imageview1.backgroundColor = [UIColor cyanColor];
    NSData * data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"]];
    UIImage * imageFromData = [UIImage imageWithData:data];
    UIImage * sImage = [self image:imageFromData scaelToSize:CGSizeMake(200, 200)];
//    CGDataProviderRef provider = CGImageGetDataProvider(imageFromData.CGImage);
    NSData* data1 = UIImageJPEGRepresentation(sImage, 0.7);//(id)CFBridgingRelease(CGDataProviderCopyData(provider));
//    NSLog(@"%@ %@", data, data1);
    UIImage * iamgeFromeName = [UIImage imageNamed:@"1.jpg"];
    NSData * cData = UIImageJPEGRepresentation(imageFromData, 0.1);//改变图片体积，但像素数不变
    UIImage * cImage = [UIImage imageWithData:cData];
    
    
    UIImageView * i  = [[UIImageView alloc] initWithImage:[self image:cImage scaelToSize:CGSizeMake(200, 200)]];
    [self.view addSubview:i];
    
    _tView = [UIImageView new];//[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:_tView];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    _tView.width = screenWidth;
    _tView.origin = CGPointZero;

    [_tView sd_setImageWithURL:[NSURL URLWithString:@"http://s1.51cto.com/wyfs02/M00/89/6A/wKioL1gSqv-TaEsuAAFpYtBoSfc555.jpg-wh_651x-s_146557409.jpg"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        _imageContainerView.origin = CGPointZero;
//        _imageContainerView.width = self.width;
//        NSLog(@"%@", NSStringFromCGRect(self.frame));
//        UIImage *image = _imageView.image;
//        NSLog(@"%@, %@", image, _imageContainerView);
        if (image.size.height / image.size.width > screenHeight / screenWidth) {
            _tView.height = floor(image.size.height / (image.size.width / screenWidth));
        } else {
            CGFloat height = image.size.height / image.size.width * screenWidth;
            if (height < 1 || isnan(height)) height = screenHeight;
            height = floor(height);
            _tView.height = height;
            _tView.centerY = screenHeight / 2;
        }
        if (_tView.height > screenHeight && _tView.height - screenHeight <= 1) {
            _tView.height = screenHeight;
        }
        _tView.frame = _tView.bounds;
//        self.contentSize = CGSizeMake(self.width, MAX(_imageContainerView.height, self.height));
//        [self scrollRectToVisible:self.bounds animated:NO];
        
//        if (_imageContainerView.height <= self.height) {
//            self.alwaysBounceVertical = NO;
//        } else {
//            self.alwaysBounceVertical = YES;
//        }
        
//        [CATransaction begin];
//        [CATransaction setDisableActions:YES];
//        _imageView.frame = _imageContainerView.bounds;
//        [CATransaction commit];

    }];
   //_imageview1.image = cImage;//    NSData * data1 =
    // Do any additional setup after loading the view, typically from a nib.
}

- (UIImage *)image:(UIImage*)image scaelToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
