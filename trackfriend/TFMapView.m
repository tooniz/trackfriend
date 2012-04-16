//
//  TFMapView.m
//  trackfriend
//
//  Created by Ming Zhou on 12-02-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TFMapView.h"
#import "TFPersonClass.h"
#import "TFAppDelegate.h"
#import "TZMapAnnotation.h"

@implementation TFMapView
@synthesize mapView;
@synthesize person;
@synthesize isScanMode, isLocationStored;
@synthesize dateLbl;
@synthesize nameLbl;
@synthesize numberLbl;
@synthesize zoomBtn;
@synthesize satelliteBtn;
@synthesize zoom_radius;
@synthesize timer;
@synthesize searching;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        person = [[TFPersonClass alloc] init];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setDateLbl:nil];
    [self setNameLbl:nil];
    [self setNumberLbl:nil];
    [self setZoomBtn:nil];
    [self setSearching:nil];
    [self setSatelliteBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    person = nil;
}

// Listen to change in the userLocation
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context 
{
    MKCoordinateRegion region;
    region.center = self.mapView.userLocation.coordinate;  
    
    MKCoordinateSpan span; 
    span.latitudeDelta  = 1; // Change these values to change the zoom
    span.longitudeDelta = 1;
    region.span = span;
    [self.mapView setRegion:region animated:YES];
    [self.mapView.userLocation removeObserver:self forKeyPath:@"location"];
    [timer invalidate];
    [UIView beginAnimations:@"fade" context:nil];
    searching.alpha = 0;
    [UIView commitAnimations];
    zoomBtn.enabled = YES;
    satelliteBtn.enabled = YES;
    mapView.multipleTouchEnabled = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    nameLbl.text = [NSString stringWithFormat:@"%@, %@", person.firstName, person.lastName];
    numberLbl.text = [NSString stringWithFormat:@"%@", person.phoneNumber];
    if (isScanMode) {
        mapView.showsUserLocation = YES;
        person.date = [NSDate date];
        isLocationStored = NO;
        zoomBtn.enabled = NO;
        satelliteBtn.enabled = NO;
        searching.hidden = NO;
        mapView.multipleTouchEnabled = NO;
        timer=  [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(searchEvent) userInfo:nil repeats:YES];
        [self performSelector:@selector(delayedTask) withObject:nil afterDelay:5];
    }
    else {
        mapView.showsUserLocation = NO;
        MKCoordinateRegion region =
        MKCoordinateRegionMakeWithDistance (person.location.coordinate, 1000, 1000);
        [mapView setRegion:region animated:NO];
        [mapView setCenterCoordinate:person.location.coordinate];
        zoomBtn.enabled = NO;
        satelliteBtn.enabled = YES;
        searching.hidden = YES;
        Place *place = [[Place alloc] initWithLong:person.location.coordinate.longitude Lat:person.location.coordinate.latitude iconNumber:[NSNumber numberWithInt:4]];
        place.myTitle = nameLbl.text;
        place.mySubtitle = numberLbl.text;
        [mapView addAnnotation:place];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterLongStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	NSString *dateString = [dateFormatter stringFromDate:person.date];
	[dateFormatter setDateStyle:NSDateFormatterNoStyle];
	[dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
	NSString *timeString = [dateFormatter stringFromDate:person.date];
	dateLbl.text = [NSString stringWithFormat:@"%@ | %@", dateString, timeString];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)prsZoom:(id)sender {
    if (zoom_radius == 0.01) { zoom_radius = 1; }
    else { zoom_radius = 0.01; }
    
    MKCoordinateRegion region;
    region.center = self.mapView.userLocation.coordinate;  
    
    MKCoordinateSpan span; 
    span.latitudeDelta  = zoom_radius; // Change these values to change the zoom
    span.longitudeDelta = zoom_radius;
    region.span = span;
    [self.mapView setRegion:region animated:YES];
}

- (IBAction)prsType:(id)sender {
    if (mapView.mapType == MKMapTypeStandard)
        mapView.mapType = MKMapTypeSatellite;
    else
        mapView.mapType = MKMapTypeStandard;
}

- (IBAction)searchEvent{
    searching.text = [NSString stringWithFormat:@"%@.", searching.text];
}

- (IBAction)delayedTask{
    [self.mapView.userLocation addObserver:self 
                                forKeyPath:@"location" 
                                   options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) 
                                   context:nil];
}

#pragma mark - Map View Delegate Methods
- (void)mapView:(MKMapView *)myMapView didUpdateUserLocation:(MKUserLocation *)userLocation      {
    if (userLocation.location.horizontalAccuracy > 0) {
        if (isScanMode && !isLocationStored) {
            person.location = myMapView.userLocation.location;
            [UIAppDelegate.personAry addObject:person];
            [UIAppDelegate storeData];    
            isLocationStored = YES;

        }
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if (annotation == aMapView.userLocation) {
        return nil; // Let map view handle user location annotation
    }
    
    // Identifyer for reusing annotationviews
    static NSString *annotationIdentifier = @"icon_annotation";
    
    // Check in queue if there is an annotation view we already can use, else create a new one
    TZMapAnnotation *annotationView = (TZMapAnnotation *)[aMapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    if (!annotationView) {
        annotationView.canShowCallout = YES;
        annotationView = [[TZMapAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
    }
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    MKAnnotationView *aV; 
    
    for (aV in views) {
        
        // Don't pin drop if annotation is user location
        if ([aV.annotation isKindOfClass:[MKUserLocation class]]) {
            continue;
        }
        
        // Check if current annotation is inside visible map rect
        MKMapPoint point =  MKMapPointForCoordinate(aV.annotation.coordinate);
        if (!MKMapRectContainsPoint(self.mapView.visibleMapRect, point)) {
            continue;
        }
        
        CGRect endFrame = aV.frame;
        
        // Move annotation out of view
        aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y - self.view.frame.size.height, aV.frame.size.width, aV.frame.size.height);
        
        // Animate drop
        [UIView animateWithDuration:0.5 delay:0.04*[views indexOfObject:aV] options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            aV.frame = endFrame;
            
            // Animate squash
        }completion:^(BOOL finished){
            if (finished) {
                [UIView animateWithDuration:0.05 animations:^{
                    aV.transform = CGAffineTransformMakeScale(1.0, 0.8);
                    
                }completion:^(BOOL finished){
                    if (finished) {
                        [UIView animateWithDuration:0.1 animations:^{
                            aV.transform = CGAffineTransformIdentity;
                        }];
                    }
                }];
            }
        }];
    }
}

@end
