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
	CGColorRef                 aColor;
	BOOL                       twoFingers;
	
	IBOutlet UILabel           *xField;
	IBOutlet UILabel           *yField;
	IBOutlet UILabel           *zField;
}

@end
