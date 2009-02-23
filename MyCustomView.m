//
//  MyCustomView.m
//  RotateMe
//
//  Created by David Nolen on 2/16/09.
//  Copyright 2009 David Nolen. All rights reserved.
//

#import "MyCustomView.h"

#define kAccelerometerFrequency        10 //Hz

@implementation MyCustomView

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
	}
	return self;
}

- (void) awakeFromNib
{
	// you have to initialize your view here since it's getting
	// instantiated by the nib
	squareSize = 100.0f;
	rotation = 0.5f;
	
	// touch flags
	oneFinger = NO;
	twoFingers = NO;
		
	// You have to explicity turn on multitouch for the view
	self.multipleTouchEnabled = YES;
	
	// configure for accelerometer
	[self configureAccelerometer];
}

-(void)configureAccelerometer
{
	UIAccelerometer*  theAccelerometer = [UIAccelerometer sharedAccelerometer];
	
	if(theAccelerometer)
	{
		theAccelerometer.updateInterval = 1 / kAccelerometerFrequency;
		theAccelerometer.delegate = self;
	}
	else
	{
		NSLog(@"Oops we're not running on the device!");
	}
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
	UIAccelerationValue x, y, z;
	x = acceleration.x;
	y = acceleration.y;
	z = acceleration.z;
	
	// Do something with the values.
	xField.text = [NSString stringWithFormat:@"%.5f", x];
	yField.text = [NSString stringWithFormat:@"%.5f", y];
	zField.text = [NSString stringWithFormat:@"%.5f", z];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"touches began count %d, %@", [touches count], touches);
	
	if([touches count] == 1)
	{
		oneFinger = YES;
	}
	
	if([touches count] > 1)
	{
		twoFingers = YES;
	}
	
	// tell the view to redraw
	[self setNeedsDisplay];
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
//	NSLog(@"touches moved count %d, %@", [touches count], touches);

	// create a UITouch object and ask it to gather information about our current touch event
	UITouch *currentTouch = [touches anyObject];
	// create a CGPoint object to extract the X & Y location of the last touch
	CGPoint firstTouchCurrentPoint = [currentTouch locationInView:nil];
	CGPoint firstTouchPreviousPoint = [currentTouch previousLocationInView:nil];
	
	// print out the point we're currently reading a touch from
	NSLog(@"x: %f, y: %f", firstTouchCurrentPoint.x, firstTouchCurrentPoint.y);
	NSLog(@"x: %f, y: %f", firstTouchPreviousPoint.x, firstTouchPreviousPoint.y);
	
	// rotate the box based on our touch
	if (oneFinger)
	{
		// if the first contact point is to the right of the current contact point
		if (firstTouchCurrentPoint.x < firstTouchPreviousPoint.x)
		{
			// upper part of the rectangle
			if (firstTouchCurrentPoint.y < centery)
			{
				rotation = rotation-0.1;
			}
			else
			{
				rotation = rotation+0.1;
			}
		}

		// if the first contact point is to theleft of the current contact point
		if (firstTouchCurrentPoint.x > firstTouchPreviousPoint.x)
		{
			// upper part of the rectangle
			if (firstTouchCurrentPoint.y < centery)
			{
				rotation = rotation+0.1;
			}
			else
			{
				rotation = rotation-0.1;
			}
		}
	}
	
	// tell the view to redraw
	[self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"touches moved count %d, %@", [touches count], touches);
	
	// reset the var
	twoFingers = NO;
	oneFinger = NO;
	
	// tell the view to redraw
	[self setNeedsDisplay];
}

- (void) drawRect:(CGRect)rect
{
	NSLog(@"drawRect");
	
	centerx = rect.size.width/2;
	centery = rect.size.height/2;
	CGFloat half = squareSize/2;
	CGRect theRect = CGRectMake(-half, -half, squareSize, squareSize);
	
	// Grab the drawing context
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// like Processing pushMatrix
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, centerx, centery);
		
	// Set red stroke
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
	
	NSLog (@"rotation: %f", rotation);
		
	// apply rotation to our rectangle based on the 'rotation' variable
	CGContextRotateCTM(context, rotation);
	
	// Set different based on multitouch
	if(!twoFingers)
	{
		CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 1.0);
	}
	else
	{
		CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1.0);
	}
	
	// Draw a rect with a red stroke
	CGContextFillRect(context, theRect);
	CGContextStrokeRect(context, theRect);
	
	// like Processing popMatrix
	CGContextRestoreGState(context);
}

- (void) dealloc
{
	[super dealloc];
}

@end