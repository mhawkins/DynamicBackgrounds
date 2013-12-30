//
//  GCDynamicBackgroundView.m
//  DynamicBackground
//
//  Created by Matt Hawkins on 12/30/13.
//  Copyright (c) 2013 Matt Hawkins. All rights reserved.
//

#import "GCDynamicBackgroundView.h"
#import <QuartzCore/QuartzCore.h>

@interface GCDynamicBackgroundView()

@property(nonatomic,strong) CAEmitterLayer *emitterLayer;
@property(nonatomic,strong) CAEmitterCell *emitterCell;

@end

@implementation GCDynamicBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupDefaults];
        [self initializeLayers];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

        // Initialization code
        [self setupDefaults];
        [self initializeLayers];
    }
    
    return self;
}

#pragma mark - Properties
-(void)setStartingColor:(UIColor *)startingColor
{
    if(_startingColor != startingColor)
    {
        _startingColor = [startingColor copy];
        [self setNeedsDisplay];
    }
}

-(void)setEndingColor:(UIColor *)endingColor
{
    if(_endingColor != endingColor)
    {
        _endingColor = [endingColor copy];
        [self setNeedsDisplay];
    }
}

#pragma  mark - Private
-(void)setupDefaults
{
    self.startingColor = [UIColor lightGrayColor];
    self.endingColor = [UIColor darkGrayColor];
}

-(void)initializeLayers
{
    // Add an emitter layer
    self.emitterLayer = [[CAEmitterLayer alloc] init];
    self.emitterLayer.frame = self.bounds;
    self.emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
    
    // Rectangle emitter
    self.emitterLayer.emitterShape = kCAEmitterLayerRectangle;
    self.emitterLayer.emitterPosition = CGPointMake(CGRectGetWidth(self.bounds)/2.0, CGRectGetHeight(self.bounds)/2.0);
    self.emitterLayer.emitterSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    
    [self.layer addSublayer:self.emitterLayer];
    
    // Create our emitter cell
    self.emitterCell = [CAEmitterCell emitterCell];
    self.emitterCell.contents = (id)[[UIImage imageNamed:@"Disc Image"] CGImage];
    self.emitterCell.contentsRect = CGRectMake(0, 0, 1, 1);
    self.emitterCell.birthRate = 0.25;
    self.emitterCell.lifetime = 60.0;
    self.emitterCell.lifetimeRange = 5.0;
    self.emitterCell.velocity = 8.0;
    self.emitterCell.velocityRange = 20.0;
    self.emitterCell.scale = 1.0;
    self.emitterCell.scaleRange = 0.5;
    self.emitterCell.zAcceleration = 0.5;
    self.emitterCell.emissionRange = 2 * M_PI;
    self.emitterCell.color = [[UIColor colorWithWhite:1.0 alpha:0.0] CGColor];
    self.emitterCell.alphaSpeed = 0.05;

    // Add our emitter cell to the layer
    self.emitterLayer.emitterCells = @[self.emitterCell];
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // Update emitter size and position based on bounds
    self.emitterLayer.emitterPosition = CGPointMake(CGRectGetWidth(self.bounds)/2.0, CGRectGetHeight(self.bounds)/2.0);
    self.emitterLayer.emitterSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    // Get our context
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    // Save state
    CGContextSaveGState(contextRef);
    
    // Generate a gradient using the RGB color space and our starting & stopping colors
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CFArrayRef colorsArrayRef = CFBridgingRetain(@[(id)self.startingColor.CGColor, (id)self.endingColor.CGColor]);
    CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpaceRef, colorsArrayRef, NULL);
    CFRelease(colorsArrayRef);
    CGColorSpaceRelease(colorSpaceRef);
    
    // Draw our gradient from top to bottom
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    CGContextDrawLinearGradient(contextRef, gradientRef, startPoint, endPoint, 0);

    // Release the gradient
    CGGradientRelease(gradientRef);
    
    // Restore state
    CGContextRestoreGState(contextRef);
    
}

@end
