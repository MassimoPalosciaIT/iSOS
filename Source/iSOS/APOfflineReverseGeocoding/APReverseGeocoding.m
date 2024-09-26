//
//  APReverseGeocoding.m
//  APReverseGeocodingExample
//
//  Created by Sergii Kryvoblotskyi on 4/15/15.
//  Copyright (c) 2015 Sergii Kryvoblotskyi. All rights reserved.
//

#import "APReverseGeocoding.h"
#import "APPolygon.h"

static NSString *const APReverseGeocodingDefaultDBName = @"countries.geo";
static NSString *const APReverseGeocodingCountriesKey  = @"features";

@interface APReverseGeocoding ()

@property (nonatomic, strong, readwrite) NSArray *countries;
@property (nonatomic, strong, readwrite) NSDictionary *geoJSON;

@end

@implementation APReverseGeocoding

+ (instancetype)defaultGeocoding
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:APReverseGeocodingDefaultDBName withExtension:@"json"];
    return [self geocodingWithGeoJSONURL:url];
}

- (instancetype)init
{
    return nil;
}

+ (instancetype)geocodingWithGeoJSONURL:(NSURL *)url
{
    return [[self alloc] initWithGeoJSONURL:url];
}

- (instancetype)initWithGeoJSONURL:(NSURL *)url
{
    NSParameterAssert(url);
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

#pragma mark - Public

- (APCountry *)geocodeCountryWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    return [self _geocodeCountryWithCoordinate:coordinate];
}

#pragma mark - Private

- (APCountry *)_geocodeCountryWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSArray *countryData = self.countries;
    APCountry *closestCountry = nil;
    CLLocationDistance closestDistance = DBL_MAX;
    
    for (int i = 0; i < [countryData count]; i++)
    {
        NSDictionary *countryDict = [countryData objectAtIndex:i];
        NSDictionary *geometry = [countryDict objectForKey:@"geometry"];
        NSString *geometryType = [geometry valueForKey:@"type"];
        NSArray *coordinates = [geometry objectForKey:@"coordinates"];
        
        /* Check the polygon type */
        if ([geometryType isEqualToString:@"Polygon"]) {
            
            /* Create the polygon */
            NSArray *polygonPoints  = [coordinates objectAtIndex:0];
            APPolygon *polygon = [APPolygon polygonWithPoints:polygonPoints];
            
            /* Check containment */
            if ([polygon containsLocation:coordinate]) {
                return [APCountry countryWithGEODictionary:countryDict];
            } else {
                CLLocationDistance distance = [self distanceFromCoordinate:coordinate toPolygon:polygon];
                if (distance < closestDistance) {
                    closestDistance = distance;
                    closestCountry = [APCountry countryWithGEODictionary:countryDict];
                }
            }

        /* Loop through all sub-polygons and make the checks */
        } else if([geometryType isEqualToString:@"MultiPolygon"]){
            for (int j = 0; j < [coordinates count]; j++){
                
                NSArray *polygonPoints = [[coordinates objectAtIndex:j] objectAtIndex:0];
                APPolygon *polygon = [APPolygon polygonWithPoints:polygonPoints];
                
                if([polygon containsLocation:coordinate]) {
                    return [APCountry countryWithGEODictionary:countryDict];
                } else {
                    CLLocationDistance distance = [self distanceFromCoordinate:coordinate toPolygon:polygon];
                    if (distance < closestDistance) {
                        closestDistance = distance;
                        closestCountry = [APCountry countryWithGEODictionary:countryDict];
                    }
                }
            }
        }
    }
    
    return closestCountry;
}

- (CLLocationDistance)distanceFromCoordinate:(CLLocationCoordinate2D)coordinate toPolygon:(APPolygon *)polygon {
    double minDistance = DBL_MAX;
    
    for (NSArray *pointArray in polygon.points) {
        CLLocationCoordinate2D pointCoordinate;
        pointCoordinate.latitude = [pointArray[1] doubleValue];
        pointCoordinate.longitude = [pointArray[0] doubleValue];
        
        double distance = [self haversineDistanceFrom:coordinate to:pointCoordinate];
        if (distance < minDistance) {
            minDistance = distance;
        }
    }
    
    return minDistance;
}

- (double)haversineDistanceFrom:(CLLocationCoordinate2D)coord1 to:(CLLocationCoordinate2D)coord2 {
    double lat1 = coord1.latitude * M_PI / 180.0;
    double lon1 = coord1.longitude * M_PI / 180.0;
    double lat2 = coord2.latitude * M_PI / 180.0;
    double lon2 = coord2.longitude * M_PI / 180.0;
    
    double dlat = lat2 - lat1;
    double dlon = lon2 - lon1;
    
    double a = pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2);
    double c = 2 * asin(sqrt(a));
    double R = 6371000; // Radius of Earth in meters
    
    return R * c;
}

#pragma mark - Lazy Accessors

- (NSArray *)countries
{
    if (!_countries) {
        _countries = self.geoJSON[APReverseGeocodingCountriesKey];
    }
    return _countries;
}

- (NSDictionary *)geoJSON
{
    if (!_geoJSON) {
        
        NSError *error = nil;
        NSData *jsonData = [[NSData alloc] initWithContentsOfURL:self.url];
        NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        
        if (!error) {
            _geoJSON = [parsedJSON copy];
        } else {
            [NSException raise:@"Cannot parse JSON." format:@"JSON URL - %@\nError:%@", self.url, parsedJSON];
        }
    }
    return _geoJSON;
}

@end
