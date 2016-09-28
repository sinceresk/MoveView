//
//  ViewController.m
//  MoveView
//
//  Created by sincere on 16/9/28.
//  Copyright © 2016年 cofortune. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
   
    UIView   * V1;
    UIView   * V2;

}

@end

@implementation ViewController



- (void)viewDidLoad {
   
    [super viewDidLoad];
    
//  方法1 利用手势
    V1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    V1.backgroundColor = [UIColor redColor];
    [self.view addSubview:V1];
    UIPanGestureRecognizer * panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(doMoveAction:)];
    [V1 addGestureRecognizer:panGestureRecognizer];
    
//  方法2 利用UITouchEvent
    V2 = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 60, 60)];
    V2.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:V2];
    [self.view addSubview:V2];
    
    

}


-(void)doMoveAction:(UIPanGestureRecognizer *)recognizer{

    
    // Figure out where the user is trying to drag the view.
    
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint newCenter = CGPointMake(recognizer.view.center.x+ translation.x,
                                    recognizer.view.center.y + translation.y);
//    限制屏幕范围：
    newCenter.y = MAX(recognizer.view.frame.size.height/2, newCenter.y);
    newCenter.y = MIN(self.view.frame.size.height - recognizer.view.frame.size.height/2, newCenter.y);
    newCenter.x = MAX(recognizer.view.frame.size.width/2, newCenter.x);
    newCenter.x = MIN(self.view.frame.size.width - recognizer.view.frame.size.width/2,newCenter.x);
    recognizer.view.center = newCenter;
    [recognizer setTranslation:CGPointZero inView:self.view];

    
}

BOOL isMove;
CGPoint legend_point;
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    isMove = NO;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if (CGRectContainsPoint(V2.frame, point)) {
        legend_point = [touch locationInView:V2];
        isMove = YES;
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    if (!isMove) {
        return;
    }
    @autoreleasepool {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        //转化成相对的中心
        point.x += V2.frame.size.width/2.0f - legend_point.x;
        point.y += V2.frame.size.height/2.0f - legend_point.y;
//        限制范围
        if (point.x < V2.frame.size.width / 2.0f) {
            point.x = V2.frame.size.width / 2.0f;
        }
        if (point.y < V2.frame.size.height / 2.0f) {
            point.y = V2.frame.size.height / 2.0f;
        }
        
        if (point.x > self.view.frame.size.width - V2.frame.size.width / 2.0f) {
            point.x = self.view.frame.size.width - V2.frame.size.width / 2.0f;
        }
        if (point.y > self.view.frame.size.height - V2.frame.size.height / 2.0f) {
            point.y = self.view.frame.size.height - V2.frame.size.height / 2.0f;
        }
        V2.center = point;

    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
