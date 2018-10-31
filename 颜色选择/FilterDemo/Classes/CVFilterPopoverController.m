//
//  CVFilterPopoverController.m
//  FilterDemo
//
//  Created by Kesalin on 6/27/11.
//  Copyright 2011 kesalin@gmail.com. All rights reserved.
//

#import "CVFilterPopoverController.h"
#import "CVTableCellBGView.h"

#define kFilterContentWidth             320
#define kFilterContentRegionHeight      328
#define kFilterContentCountryHeight     (328 + 128)
#define kFilterButtonWidth              100
#define kFilterButtonHeight             40

#define kFilterSegmentControlWidth      280
#define kFilterSegmentControlHeight     40
#define kFilterTableWidth               280
#define kFilterTableRegionHeight        192
#define kFilterTableCountryHeight       (192 + 128)
#define kFilterTableCellHeight          32


@interface CVFilterPopoverController(PirvateMethods)

- (void)cancelButtonPressed:(id)sender;
- (void)applyButtonPressed:(id)sender;
- (void)segmentPressed:(id)sender;

- (void)setupCountrySections;
- (NSString *)code:(NSInteger)section row:(NSInteger)index filterMode:(CVFilterMode)mode;
- (NSString *)selectedKey:(NSInteger)section row:(NSInteger)index filterMode:(CVFilterMode)mode;
- (void)adjustSize:(CVFilterMode)mode animated:(BOOL)animated;

@end


@implementation CVFilterPopoverController

@synthesize container;

#pragma mark -
#pragma mark Life cycle

- (void)setupCountrySections
{
    countrySectionsDict = [[NSMutableDictionary alloc] init];

    NSMutableDictionary *allCountriesDict = [[[NSMutableDictionary alloc] init] autorelease];
    NSArray *allRegions = [regionDict allKeys];
    for (NSString *region in allRegions)
    {
        NSDictionary *countryDict = [regionDict objectForKey:region];
        countryDict = [countryDict objectForKey:@"countries"];
        [allCountriesDict addEntriesFromDictionary:countryDict];
    }
    
    NSArray *countryArray = [[allCountriesDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    for (NSInteger index = 'A'; index <= 'Z'; index++)
    {
        NSMutableDictionary *alphaDict = [[[NSMutableDictionary alloc] init] autorelease];
        NSString *alpha = [NSString stringWithFormat:@"%c", index];
        
        for (NSString *country in countryArray)
        {
            if ([country hasPrefix:alpha])
            {
                NSString *code = [allCountriesDict objectForKey:country];
                [alphaDict setObject:code forKey:country];
            }
        }
        
        if ([alphaDict count] > 0)
            [countrySectionsDict setObject:alphaDict forKey:alpha];
    }
    
    NSArray *sortedArray = [[countrySectionsDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    countrySections = [[NSArray alloc] initWithArray:sortedArray];
}

- (id) init
{
    self = [super init];
    
    if (self)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource: @"cv-regions-countries" ofType: @"plist"];
        regionDict = [[NSDictionary dictionaryWithContentsOfFile: path] retain];
        regionArray = [[[regionDict allKeys] sortedArrayUsingSelector:@selector(compare:)] retain];

        selectedItems = [[NSMutableSet alloc] init];
        
        [self setupCountrySections];

        // setup UI
        // 
        CGRect rect = CGRectMake(0, 0, kFilterContentWidth, kFilterContentRegionHeight);
        UIView *contentView = [[UIView alloc] initWithFrame:rect];
        contentView.backgroundColor = [UIColor whiteColor];
        
        // add cancel button
        CGFloat y = 20;
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelButton.frame = CGRectMake(40, y, kFilterButtonWidth, kFilterButtonHeight);
        [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];

        [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:cancelButton];
        
        // add apply button
        UIButton *applyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        applyButton.frame = CGRectMake(kFilterContentWidth - kFilterButtonWidth - 40, y, kFilterButtonWidth, kFilterButtonHeight);
        [applyButton setTitle:@"Apply" forState:UIControlStateNormal];
        
        [applyButton addTarget:self action:@selector(applyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:applyButton];
        
        // add segmented control
        y = 76;
        rect = CGRectMake((kFilterContentWidth - kFilterSegmentControlWidth) / 2, y, kFilterSegmentControlWidth, kFilterSegmentControlHeight);
        segmentedControl = [[UISegmentedControl alloc] initWithFrame:rect];
        segmentedControl.tintColor = [UIColor colorWithRed:75.0/255.0 green:129.0/255.0 blue:217.0f/255.0 alpha:0.7];
        [segmentedControl addTarget:self action:@selector(segmentPressed:) forControlEvents:UIControlEventValueChanged];
        [segmentedControl insertSegmentWithTitle:@"Region" atIndex:0 animated:NO];
        [segmentedControl insertSegmentWithTitle:@"Country" atIndex:1 animated:NO];
        
        segmentedControl.selectedSegmentIndex = 0;
        
        [contentView addSubview:segmentedControl];

        // add table
        y = 124;
        rect = CGRectMake((kFilterContentWidth - kFilterTableWidth) / 2, y, kFilterTableWidth, kFilterContentRegionHeight);
        tableView = [[UITableView alloc] initWithFrame:rect];
        [tableView setSeparatorColor:[UIColor clearColor]];
        [tableView setBackgroundColor:[UIColor clearColor]];
        tableView.delegate = self;
        tableView.dataSource = self;

        [contentView addSubview:tableView];
        
        self.view = contentView;
        [contentView release];
        
        filterMode = FilterMode_Region;
    }

    return self;
}

- (void)dealloc
{
    [selectedItems release];
    [countrySections release];
    [countrySectionsDict release];
    [regionArray release];
    [regionDict release];

    [tableView release];
    [segmentedControl release];

    [super dealloc];
}

#pragma mark -
#pragma mark Popover delegate

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)targetPopoverController
{
    return YES;
}

- (void) popoverControllerDidDismissPopover:(UIPopoverController *)targetPopoverController;
{
}

- (void)adjustSize:(CVFilterMode)mode animated:(BOOL)animated
{
    CGSize contentSize = container.popoverContentSize;
    CGRect tableFrame = tableView.frame;
    if (mode == FilterMode_Region)
    {
        tableFrame.size.height = kFilterTableRegionHeight;
        contentSize.height = kFilterContentRegionHeight;
    }
    else
    {
        tableFrame.size.height = kFilterTableCountryHeight;
        contentSize.height = kFilterContentCountryHeight;
    }
    
    tableView.frame = tableFrame;
    [container setPopoverContentSize:contentSize animated:animated];
}

#pragma mark -
#pragma mark - Button action

- (void)cancelButtonPressed:(id)sender
{
    [container dismissPopoverAnimated:YES];
}

- (void)applyButtonPressed:(id)sender
{    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:selectedItems, @"selectedItems", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kEventFilterChanged object:nil userInfo:userInfo];
    
    [container dismissPopoverAnimated:YES];
}

- (void)segmentPressed:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    
    CVFilterMode mode = FilterMode_Region;
    NSInteger segSelectedIndex = control.selectedSegmentIndex;
    if (segSelectedIndex == 0)
        mode = FilterMode_Region;
    else
        mode = FilterMode_Country;
    
    if (mode != filterMode)
    {        
        filterMode = mode;
        
        [self adjustSize:filterMode animated:YES];

        [selectedItems removeAllObjects];
        [tableView reloadData];
    }
}

#pragma mark -
#pragma mark Table View

- (CellStyle)checkCellStyleWith:(NSInteger)totalCount index:(NSInteger)index
{
    NSLog(@" == %d = %d", totalCount, index);
    
	if (totalCount > 0)
    {
        // only one item
        if (totalCount == 1)
            return CellStyleSingle;
        
        // first one
        if (index == 0)
            return CellStyleTop;
        
        // last one
        if (index == totalCount - 1)
            return CellStyleBottom;
        
        // middle ones
        return CellStyleMiddle;
	}
    
	return CellStyleNone;
}

- (CGFloat)tableView:(UITableView *)targetTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kFilterTableCellHeight;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)targetTableView
{
    if (filterMode == FilterMode_Region)
        return nil;
    
	return countrySections;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)targetTableView
{
    NSInteger count = 0;
    if (filterMode == FilterMode_Region) {
        count = [regionArray count];
    }
        
    else {
        count = [countrySections count];
    }
    
    return count;
}

- (NSInteger)tableView:(UITableView *)targetTableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (filterMode == FilterMode_Region){
        count = 1;
    }
        
    else {
        NSString *alpha = [countrySections objectAtIndex:section];
        NSDictionary *dict = [countrySectionsDict objectForKey:alpha];
        count = [dict count];
    }
        
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)targetTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section  = indexPath.section;
    
    static NSString *FilterIdentifier = @"FilterIdentifier";
    UITableViewCell *cell = [targetTableView dequeueReusableCellWithIdentifier:FilterIdentifier];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:FilterIdentifier] autorelease];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"ArialMT" size:17];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    CVTableCellBGView *bgView = [[CVTableCellBGView alloc] init];
    bgView.cellStyle = CellStyleSingle;
    if (filterMode == FilterMode_Region)
    {
        bgView.cellStyle = [self checkCellStyleWith:[regionArray count] index:section];
    }
    else
    {
        bgView.gradientColor = GradientColorBlue;
    }

    [cell setBackgroundView:bgView];
    [bgView release];
    
    NSString *text;
    if (filterMode == FilterMode_Region)
    {
        text = [regionArray objectAtIndex:section];
    }
    else
    {
        NSString *alpah = [countrySections objectAtIndex:section];
        NSDictionary *dict = [countrySectionsDict objectForKey:alpah];
        NSArray *sortedCountries = [[dict allKeys] sortedArrayUsingSelector:@selector(compare:)];
        text = [sortedCountries objectAtIndex:row];
    }
    
    cell.textLabel.text = text;

    cell.accessoryType = UITableViewCellAccessoryNone;
    NSString *selectedKey = [self selectedKey:section row:row filterMode:filterMode];
    if ([selectedItems containsObject:selectedKey])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;

    return cell;
}

- (void)tableView:(UITableView *)targetTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section  = indexPath.section;

    UITableViewCell *cell = [targetTableView cellForRowAtIndexPath:indexPath];
    if (cell)
    {
        NSString *selectedKey = [self selectedKey:section row:row filterMode:filterMode];
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [selectedItems removeObject:selectedKey];
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [selectedItems addObject:selectedKey];
        }
    }
}

#pragma mark -
#pragma mark Region and countries define

- (void)reset
{
    filterMode = FilterMode_Region;
    
    [selectedItems removeAllObjects];
    [self adjustSize:filterMode animated:NO];
    segmentedControl.selectedSegmentIndex = 0;
    [tableView reloadData];
}

- (NSString *)code:(NSInteger)section row:(NSInteger)row filterMode:(CVFilterMode)mode
{
    NSString *code;
    if (mode == FilterMode_Region)
    {
        NSString *regionName = [regionArray objectAtIndex:section];
        NSDictionary *dict = [regionDict objectForKey:regionName];
        code = [dict objectForKey:@"code"];
    }
    else
    {
        NSString *alpha = [countrySections objectAtIndex:section];
        NSDictionary *dict = [countrySectionsDict objectForKey:alpha];
        NSArray *sortedArray = [[dict allKeys] sortedArrayUsingSelector:@selector(compare:)];
        NSString *country = [sortedArray objectAtIndex:row];
        code = [dict objectForKey:country];
    }

    return code;
}

- (NSString *)selectedKey:(NSInteger)section row:(NSInteger)row filterMode:(CVFilterMode)mode
{
    NSString *modeString = (mode == FilterMode_Region) ? @"region" : @"country";
    NSString *code = [self code:section row:row filterMode:mode];
    NSString *key = [NSString stringWithFormat:@"%@|%@", modeString, code];
    
    return key;
}

@end
