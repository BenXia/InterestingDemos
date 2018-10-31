//
//  CVFilterPopoverController.h
//  FilterDemo
//
//  Created by Kesalin on 6/27/11.
//  Copyright 2011 kesalin@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kEventFilterChanged @"kEventFilterChanged"

typedef enum {
    FilterMode_Region,
    FilterMode_Country,
} CVFilterMode;

@interface CVFilterPopoverController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPopoverControllerDelegate>
{
    UIPopoverController     *container;
    UITableView             *tableView;
    UISegmentedControl      *segmentedControl;

    NSArray                 *regionArray;
    NSDictionary            *regionDict;
    NSArray                 *countrySections;
    NSMutableDictionary     *countrySectionsDict;
    NSMutableSet            *selectedItems;

    CVFilterMode            filterMode;
}

@property (nonatomic, assign) UIPopoverController *container;

- (void)reset;

@end
