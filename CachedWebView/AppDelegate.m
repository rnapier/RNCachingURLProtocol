//
//  AppDelegate.m
//  CachedWebView
//
//  Created by Robert Napier on 1/29/12.
//  Copyright (c) 2012 Rob Napier.
//
//  This code is licensed under the MIT License:
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "RNCachingURLProtocol.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //only cache Steam
    [RNCachingURLProtocol setShouldHandleRequest:^BOOL(NSURLRequest * _Nonnull aRequest) {
        if(!aRequest.URL.host) {
            return NO;
        }
        
        BOOL br = [aRequest.URL.host rangeOfString:@"steamcommunity.com"].location != NSNotFound;
        if(br) {
            NSLog(@"cache %@", aRequest.URL.host);
        }
        return br;
    }];
    
    //set our protocol
    [NSURLProtocol registerClass:[RNCachingURLProtocol class]];
    
    //prepare the content vcs
    ViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    viewController.url = [NSURL URLWithString:@"http://steamcommunity.com"];
    viewController.title = @"cached Steamcommunity";
    ViewController *viewController2 = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    viewController2.url = [NSURL URLWithString:@"http://www.spiegel.de"];
    viewController2.title = @"uncached Spiegel";
    
    //add tabbar
    self.viewController = [[UITabBarController alloc] init];
    self.viewController.viewControllers = @[viewController, viewController2];
    
    //add the window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
