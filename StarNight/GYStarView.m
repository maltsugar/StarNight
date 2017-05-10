//
//  GYStarView.m
//  MSStarsView
//
//  Created by zgy on 2017/5/10.
//  Copyright © 2017年 mr.scorpion. All rights reserved.
//

#import "GYStarView.h"

@interface GYStarView ()

@property (nonatomic, strong) CAEmitterLayer *emitter;
@property (nonatomic, strong) CAEmitterCell *particle;

@end


@implementation GYStarView

+ (Class)layerClass
{
    return [CAEmitterLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.emitter.emitterMode = kCAEmitterLayerOutline;
    self.emitter.emitterShape = kCAEmitterLayerCircle;
    self.emitter.renderMode = kCAEmitterLayerOldestFirst;
    self.emitter.preservesDepth = YES;
    
    self.particle = [CAEmitterCell emitterCell];
    
    self.particle.contents = (__bridge id _Nullable)([UIImage imageNamed:@"star"].CGImage);
    self.particle.birthRate = 10;
    
    self.particle.lifetime = 50;
    self.particle.lifetimeRange = 5;
    
    self.particle.velocity = 20;
    self.particle.velocityRange = 10;
    
    self.particle.scale = 0.8;
    self.particle.scaleRange = 1.2;
    self.particle.scaleSpeed = 0.02;
    self.emitter.emitterCells = @[self.particle];
}


- (void)didMoveToWindow
{
    [super didMoveToWindow];
    if (self.window != nil) {
        if (self.emitterTimer == nil) {
            self.emitterTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(randomizeEmitterPosition) userInfo:nil repeats:YES];
        }
    }else if (self.emitterTimer != nil) {
        [self.emitterTimer invalidate];
        self.emitterTimer = nil;
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.emitter.emitterPosition = self.center;
    self.emitter.emitterSize = self.bounds.size;
}

- (void)randomizeEmitterPosition
{
    CGFloat sizeWidth = MAX(self.bounds.size.width, self.bounds.size.height);
    CGFloat radius = fmodf((float)arc4random(), sizeWidth);
    self.emitter.emitterSize = CGSizeMake(radius, radius);
    self.particle.birthRate = 10 + sqrt(radius);
}



#pragma mark- lazy
- (CAEmitterLayer *)emitter
{
    return (CAEmitterLayer *)self.layer;
}

@end
