//
//  TFMapView.h
//  trackfriend
//
//  Created by Ming Zhou on 12-02-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class TFPersonClass;

@interface TFMapView : UIViewController

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) TFPersonClass *person;

- (IBAction)prsZoom:(id)sender;
- (IBAction)prsType:(id)sender;

@property BOOL isScanMode;
@property BOOL isLocationStored;
@property float zoom_radius;

@property (strong, nonatomic) IBOutlet UILabel *dateLbl;
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *numberLbl;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *zoomBtn;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *satelliteBtn;

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) IBOutlet UILabel *searching;

@end
