//
//  ViewController.m
//  TestImage
//
//  Created by zm on 2016/10/28.
//  Copyright © 2016年 zmMac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview1;

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
