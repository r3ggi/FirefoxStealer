#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelfieTaker : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate>

@property AVCaptureSession* session;
@property dispatch_queue_main_t queue;

- (void) captureOutput:(AVCaptureOutput*)output didOutputSampleBuffer:(CMSampleBufferRef)buffer fromConnection:(AVCaptureConnection*)connection;
- (void) stopTakingSelfie;

@end

NS_ASSUME_NONNULL_END
