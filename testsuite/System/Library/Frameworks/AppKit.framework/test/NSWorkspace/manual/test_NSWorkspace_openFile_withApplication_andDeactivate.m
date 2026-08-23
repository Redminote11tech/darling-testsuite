// SPDX-FileCopyrightText: 2026 Darling Team
// SPDX-License-Identifier: MIT-0

#include <darling-testsuite/assertion.h>

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>

int main(void) {
    @autoreleasepool {
        NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
        assert_is_true(workspace != nil);

        NSFileManager *fm = [NSFileManager defaultManager];
        NSString *dummyFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"nsworkspace_openfile_test.txt"];
        [fm createFileAtPath:dummyFile contents:[NSData data] attributes:nil];

        // A plain command line tool is not an application, so opening a file
        // with it is expected to fail.
        BOOL cliResult = [workspace openFile:dummyFile withApplication:@"/bin/echo" andDeactivate:NO];
        assert_is_false(cliResult);

        // A real application bundle can be launched with the file, so this
        // call is expected to succeed. Run this test from the directory that
        // contains NSApplicationDelegate_application_openFile.app.
        NSLog(@"Testing NSWorkspace openFile:withApplication:andDeactivate: manually...");
        NSLog(@"The launched app should log: Opened file: %@", dummyFile);

        BOOL appResult = [workspace openFile:dummyFile withApplication:@"./NSApplicationDelegate_application_openFile.app" andDeactivate:NO];
        assert_is_true(appResult);

        // Clean up
        [fm removeItemAtPath:dummyFile error:NULL];
    }
    return 0;
}
