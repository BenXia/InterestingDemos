//
//  ViewController.m
//  UIAlertTest
//
//  Created by lcc on 14-6-23.
//  Copyright (c) 2014年 lcc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) NSString *messageString;

@end

@implementation ViewController

- (void)dealloc
{
    self.messageString = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    self.messageString = @"1.第一行我是3个子\n2.第二行我是好几个字反正目的是为了和第一行区分开来\n3.哈哈我是陪衬的1.第一行我是3个子\n2.第二行我是好几个字反正目的是为了和第一行区分开来\n3.哈哈我是陪衬的";
    
    UIButton *alertBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 320, 40)];
    [alertBtn setTitle:@"点我啊，我会alert" forState:UIControlStateNormal];
    alertBtn.backgroundColor = [UIColor redColor];
    [alertBtn addTarget:self action:@selector(alertBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertBtn];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark - alert Custom method
- (NSArray *)viewArray:(UIView *)root {
    NSLog(@"%@", root.subviews);
    static NSArray *_subviews = nil;
    _subviews = nil;
    for (UIView *v in root.subviews) {
        if (_subviews) {
            break;
        }
        if ([v isKindOfClass:[UILabel class]]) {
            _subviews = root.subviews;
            return _subviews;
        }
        [self viewArray:v];
    }
    return _subviews;
}

- (void) showAlertWithMessage:(NSString *) message
{
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"ffff" message:message preferredStyle:UIAlertControllerStyleAlert];
        //方式1:
        //start --
//        NSArray *views = [self viewArray:alertController.view];
//        UILabel *title = views[1];
//        title.textAlignment = NSTextAlignmentLeft;
        //end --
        //方式2:
        //start --
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        //paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        //行间距
        paragraphStyle.lineSpacing = 5.0;
        
        NSDictionary * attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:18.0], NSParagraphStyleAttributeName : paragraphStyle};
        NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:message];
        [attributedTitle addAttributes:attributes range:NSMakeRange(0, message.length)];
        [alertController setValue:attributedTitle forKey:@"attributedMessage"];//attributedTitle\attributedMessage
        //end ---
        
        
        UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:@"cancel"
                                                                style: UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
//                                                                  UITextField *textField = alertController.textFields[0];
//                                                                  NSLog(@"text was %@", textField.text);
                                                              }];
        UIAlertAction *defaultAction2 = [UIAlertAction actionWithTitle:@"ok"
                                                                style: UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  NSLog(@"ok btn");
                                                                  
                                                                  [alertController dismissViewControllerAnimated:YES completion:nil];

                                                              }];

        [alertController addAction:defaultAction1];
        [alertController addAction:defaultAction2];
        //添加textfield
//        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//            textField.placeholder = @"folder name";
//            textField.keyboardType = UIKeyboardTypeDefault;
//        }];
//        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//            textField.placeholder = @"text type text";
//            textField.keyboardType = UIKeyboardTypeDefault;
//        }];
        UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        [rootViewController presentViewController:alertController animated: YES completion: nil];

    }else{
        
        UIAlertView *tmpAlertView = [[UIAlertView alloc] initWithTitle:@"测试换行"
                                                               message:message
                                                              delegate:self
                                                     cancelButtonTitle:nil
                                                     otherButtonTitles:@"知道了", nil];
        
        //如果你的系统大于等于7.0
         
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
        {
            CGSize size = [self.messageString sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(240, 1000) lineBreakMode:NSLineBreakByTruncatingTail];
            
            UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 240, size.height)];
            textLabel.font = [UIFont systemFontOfSize:15];
            textLabel.textColor = [UIColor blackColor];
            textLabel.backgroundColor = [UIColor clearColor];
            textLabel.lineBreakMode = NSLineBreakByWordWrapping;
            textLabel.numberOfLines = 0;
            textLabel.textAlignment = NSTextAlignmentLeft;
            textLabel.text = self.messageString;
            [tmpAlertView setValue:textLabel forKey:@"accessoryView"];
            
            //这个地方别忘了把alertview的message设为空
            tmpAlertView.message = @"";
            
        }
        
        [tmpAlertView show];
    }
    
}

#pragma mark -
#pragma mark - uibutton 单击事件
- (void) alertBtnTapped
{
    [self showAlertWithMessage:self.messageString];
}

#pragma mark -
#pragma mark - alert delegate
- (void) willPresentAlertView:(UIAlertView *)alertView
{
    //由于不希望标题也居左
    NSInteger labelIndex = 1;
    //在ios7.0一下版本这个方法是可以的
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
    {
        for (UIView *subView in alertView.subviews)
        {
        
            if ([subView isKindOfClass: [UILabel class]])
            {
                if (labelIndex > 1)
                {
                    UILabel *tmpLabel = (UILabel *)subView;
                    tmpLabel.textAlignment = NSTextAlignmentLeft;
                }
                //过滤掉标题
                labelIndex ++;
            }
        }
    }
}

@end
