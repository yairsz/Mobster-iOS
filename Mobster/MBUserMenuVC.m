//
//  MBUserMenuVCViewController.m
//  Mobster
//
//  Created by Yair Szarf on 4/24/14.
//  Copyright (c) 2014 2HC. All rights reserved.
//

#import "MBUserMenuVC.h"
#import "MBChatTableViewCell.h"
#import "MBChatMessage.h"
#import "MBSocketController.h"
#import "MBMapVC.h"

@interface MBUserMenuVC ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak,nonatomic) IBOutlet UITextField * messageTextField;
@property (weak,nonatomic) IBOutlet UITableView * tableView;
@property (weak,nonatomic) IBOutlet UIScrollView * contentScrollView;
@property (strong,nonatomic) NSMutableArray * chatMessages;
@end

@implementation MBUserMenuVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self registerForKeyboardNotifications];
}

#pragma mark Setters and Getters

- (NSMutableArray *) chatMessages
{
    if (!_chatMessages) {
        _chatMessages = [NSMutableArray new];
    }
    return _chatMessages;
}


- (void) didReceiveChatMessage:(MBChatMessage *) chatMessage
{
    [self.chatMessages addObject:chatMessage];
    [self.tableView reloadData];
}



- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

#pragma mark UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chatMessages.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBChatMessage * chatMessage = self.chatMessages[indexPath.row];
    NSString * identifier;
    if (chatMessage.other) {
        identifier = @"otherPeopleMessageCell";
    } else {
        identifier = @"myMessageCell";
    }
    
    MBChatTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.messageLabel.text = chatMessage.message;
    cell.userIcon.image = [UIImage imageNamed:@"userIcon"];
    return cell;
}


- (IBAction)sendPressed:(UIButton *)sender
{
    if (self.messageTextField.text > 0) {
        MBMapVC * mapVC =(MBMapVC*) self.revealViewController.frontViewController;
        NSString * message = [NSString stringWithFormat:@"rmypjciv : %@",self.messageTextField.text];
        [mapVC.socketController sendChatMessageWithData:@{@"msg":message}];
    }
}
#pragma mark respond to keyboard notifications

- (void)keyboardDidShow:(NSNotification*)notification
{
    NSDictionary* info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.contentScrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height + 6, keyboardSize.width);
    [self.contentScrollView scrollRectToVisible:self.messageTextField.frame animated:YES];
    
    
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    self.contentScrollView.contentInset = UIEdgeInsetsZero;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate


-(void) textFieldDidBeginEditing:(UITextField *)textField {
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    [textField removeTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    [textField becomeFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

-(void) textFieldDidChange: (UITextField *) sender {
    // use this method for behaviors that happen as the user types
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //This is a gist by @johnnyclem https://gist.github.com/johnnyclem/8215415 well done!
    for (UIControl *control in self.view.subviews) {
        if ([control isKindOfClass:[UITextField class]]) {
            [control endEditing:YES];
        }
    }
}


@end
