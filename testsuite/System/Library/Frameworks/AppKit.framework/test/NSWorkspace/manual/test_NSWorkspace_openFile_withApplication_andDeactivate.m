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

        // The cases below launch real applications (the helper bundle, or the
        // default application for the file type), so they cannot run
        // unattended and live in the manual test suite. The cases that launch
        // nothing are covered by the automated test of the same name.
        NSLog(@"Testing NSWorkspace openFile:withApplication:andDeactivate: manually...");
        NSLog(@"The launched app should log: Opened file: %@", dummyFile);

        // With a nil path but a valid application, the application is simply
        // launched without a file, so the call is expected to succeed. Run
        // this test from the directory that contains
        // NSApplicationDelegate_application_openFile.app.
        BOOL noFileArgumentTest = [workspace openFile:NULL withApplication:@"NSApplicationDelegate_application_openFile.app" andDeactivate:NO];
        assert_is_true(noFileArgumentTest);

        // With no application given, the file is opened with the default
        // application for its type, so the call is expected to succeed.
        BOOL noAppArgumentTest = [workspace openFile:dummyFile withApplication:NULL andDeactivate:NO];
        assert_is_true(noAppArgumentTest);

        // A real application bundle can be launched with the file, so this
        // call is expected to succeed. Run this test from the directory that
        // contains NSApplicationDelegate_application_openFile.app. Note that
        // openFile:withApplication:andDeactivate: rejects a "./" prefix on
        // the path, so the bundle name is given without it.
        BOOL appResult = [workspace openFile:dummyFile withApplication:@"NSApplicationDelegate_application_openFile.app" andDeactivate:NO];
        assert_is_true(appResult);

        // Clean up
        [fm removeItemAtPath:dummyFile error:NULL];
    }
    return 0;
}
