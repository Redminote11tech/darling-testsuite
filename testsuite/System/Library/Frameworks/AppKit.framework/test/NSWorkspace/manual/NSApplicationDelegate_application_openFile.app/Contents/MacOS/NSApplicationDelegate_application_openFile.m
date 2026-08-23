// SPDX-FileCopyrightText: 2026 Darling Team
// SPDX-License-Identifier: MIT-0

#include <AppKit/AppKit.h>

@interface OpenTestDelegate : NSObject <NSApplicationDelegate>
@end

@implementation OpenTestDelegate
- (BOOL) application:(NSApplication*)sender
            openFile:(NSString*)filename {
    NSLog(@"Opened file: %@", filename);
    return YES;
}
@end

int main(int argc, const char** argv) {
    NSApplication *app = [NSApplication sharedApplication];
    OpenTestDelegate *delegate = [[OpenTestDelegate alloc] init];
    [app setDelegate:delegate];
    return NSApplicationMain(argc, argv);
}
