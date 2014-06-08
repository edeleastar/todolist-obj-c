#import "XYZAddToDoItemViewController.h"

@interface XYZAddToDoItemViewController ()

  @property (weak, nonatomic) IBOutlet UITextField *textField;
  @property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
  @property (weak, nonatomic) IBOutlet UIDatePicker *reminderDate;

@end

@implementation XYZAddToDoItemViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if (sender != self.doneButton) return;
  if (self.textField.text.length > 0)
  {
    self.toDoItem = [[XYZToDoItem alloc] init];
    self.toDoItem.itemName = self.textField.text;
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    localNotif.alertBody = self.toDoItem.itemName;
    localNotif.applicationIconBadgeNumber = 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
  }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self)
  {
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

@end
