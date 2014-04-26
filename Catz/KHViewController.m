//
//  KHViewController.m
//  Catz
//
//  Created by Kris Hyland on 4/24/14.
//  Copyright (c) 2014 Kris Hyland. All rights reserved.
//

#import "KHViewController.h"

@interface KHViewController ()

@end

@implementation KHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *nsUrl = [NSURL URLWithString:@"http://www.reddit.com/r/cats/.json"];
    NSData *jsonData = [NSData dataWithContentsOfURL:nsUrl];
    NSError *error = nil;
    
    
    
    NSDictionary *redditDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    NSArray *arrayOfPosts = redditDictionary[@"data"][@"children"];
    NSMutableArray *urlsOfImages = [NSMutableArray new]; //[@[] mutableCopy]

    [arrayOfPosts enumerateObjectsUsingBlock:^(NSDictionary *post, NSUInteger idx, BOOL *stop) {
        NSString *urlString = post[@"data"][@"url"];
        NSURL *urlForPost = [NSURL URLWithString:urlString];
        
        NSArray *pathComponents = @[@"jpeg", @"png", @"jpg", @"gif", @"tiff"];
        NSString *pathExtension = [urlForPost pathExtension];
        
        [pathComponents enumerateObjectsUsingBlock:^(NSString *fileTypeWeWant, NSUInteger id, BOOL *stop) {
            NSRange range = [pathExtension rangeOfString:fileTypeWeWant options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                [urlsOfImages addObject:urlString];
            }
        }];
    }];
    
    /*
     NSDictionary *redditDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
     NSArray *arrayOfPosts = redditDictionary[@"data"][@"children"];
     NSMutableArray *urlsOfImages = [NSMutableArray new]; //[@[] mutableCopy]
     
     [arrayOfPosts enumerateObjectsUsingBlock:^(NSDictionary *post, NSUInteger idx, BOOL *stop) {
     NSString *urlString = post[@"data"][@"url"];
     
     NSRange range = [urlString rangeOfString:@"imgur" options:NSCaseInsensitiveSearch];
     if (range.location != NSNotFound) {
     [urlsOfImages addObject:urlString];
     }
     }];*/
    
    NSLog(@"%@",  urlsOfImages);

    
   // NSPredicate *containsJpeg = [NSPredicate predicateWithFormat:@"catArray.url endswith '.jpeg'"];
   // NSPredicate *containsPng = [NSPredicate predicateWithFormat:@"SELF contains[c] '.png'"];
   // NSPredicate *containsJpg = [NSPredicate predicateWithFormat:@"SELF contains[c] '.jpg'"];
    
    
    
    
    
    
    


    
    
     
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
