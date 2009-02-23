//
//  MyCustomView.h
//  redsquare01
//
//  Created by Craig Kapp on 2/19/09.
//  Copyright 2009 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCustomView : UIView
{
	CGFloat                    squareSize;
	CGFloat                    rotation;
	CGFloat                    centerx;
	CGFloat                    centery;
	CGColorRef                 aColor;
	BOOL                       twoFingers;
	BOOL					   oneFinger;
	
	IBOutlet UILabel           *xField;
	IBOutlet UILabel           *yField;
	IBOutlet UILabel           *zField;
}

@end
