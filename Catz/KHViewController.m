//
//  KHViewController.m
//  Catz
//
//  Created by Kris Hyland on 4/24/14.
//  Copyright (c) 2014 Kris Hyland. All rights reserved.
//

#import "KHViewController.h"
#import "UIImageView+WebCache.h"

@interface KHViewController ()

@property NSMutableArray *urlsForCats;
@property UIImageView *imageView;


@end

@implementation KHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *nsUrl = [NSURL URLWithString:@"http://www.reddit.com/r/cats/.json?limit=50&after=t3_2444p3"];
    NSData *jsonData = [NSData dataWithContentsOfURL:nsUrl];
    NSError *error = nil;
    
    
    
    NSDictionary *redditDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    NSArray *arrayOfPosts = redditDictionary[@"data"][@"children"];
   self.urlsForCats = [NSMutableArray new]; //[@[] mutableCopy]

    [arrayOfPosts enumerateObjectsUsingBlock:^(NSDictionary *post, NSUInteger idx, BOOL *stop) {
        NSString *urlString = post[@"data"][@"url"];
        NSURL *urlForPost = [NSURL URLWithString:urlString];
        
        NSArray *pathComponents = @[@"jpeg", @"png", @"jpg", @"gif", @"tiff"];
        NSString *pathExtension = [urlForPost pathExtension];
        
        [pathComponents enumerateObjectsUsingBlock:^(NSString *fileTypeWeWant, NSUInteger id, BOOL *stop) {
            NSRange range = [pathExtension rangeOfString:fileTypeWeWant options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                [self.urlsForCats addObject:urlForPost];
            }
        }];
    }];
    
    
    
        self.imageView = [[UIImageView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    [self.view addSubview:self.imageView];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    [self setRandomCatImage];

    /*
     NSDictionary *redditDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
     NSArray *arrayOfPosts = redditDictionary[@"data"][@"children"];
     NSMutableArray *self.urlsForCats = [NSMutableArray new]; //[@[] mutableCopy]
     
     [arrayOfPosts enumerateObjectsUsingBlock:^(NSDictionary *post, NSUInteger idx, BOOL *stop) {
     NSString *urlString = post[@"data"][@"url"];
     
     NSRange range = [urlString rangeOfString:@"imgur" options:NSCaseInsensitiveSearch];
     if (range.location != NSNotFound) {
     [self.urlsForCats addObject:urlString];
     }
     }];*/
    
    NSLog(@"%@",  self.urlsForCats);

    
   // NSPredicate *containsJpeg = [NSPredicate predicateWithFormat:@"catArray.url endswith '.jpeg'"];
   // NSPredicate *containsPng = [NSPredicate predicateWithFormat:@"SELF contains[c] '.png'"];
   // NSPredicate *containsJpg = [NSPredicate predicateWithFormat:@"SELF contains[c] '.jpg'"];
    
    
    
    
    
    
    


    
    
     
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Methods

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.subtype == UIEventSubtypeMotionShake)
    {
        [self setRandomCatImage];
    }
   

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (event.type == UIEventTypeTouches)
    {
        [self setRandomCatImage];
    }
}

- (void)setRandomCatImage
{
    NSInteger index;
    index = arc4random() % self.urlsForCats.count;
    [self.imageView setImageWithURL:[self.urlsForCats objectAtIndex:index]];
}

@end
