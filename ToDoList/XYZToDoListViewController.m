#import "XYZToDoListViewController.h"
#import "XYZToDoItem.h"
#import "XYZAddToDoItemViewController.h"

@interface XYZToDoListViewController ()

@property NSString *path;

@end

@implementation XYZToDoListViewController

- (void)saveList
{
  [NSKeyedArchiver archiveRootObject:self.toDoItems toFile:self.path];
}

- (void)loadInitialData
{
  XYZToDoItem *item1 = [[XYZToDoItem alloc] init];
  item1.itemName = @"Buy milk";
  [self.toDoItems addObject:item1];
  
  XYZToDoItem *item2 = [[XYZToDoItem alloc] init];
  item2.itemName = @"Buy eggs";
  [self.toDoItems addObject:item2];
  
  XYZToDoItem *item3 = [[XYZToDoItem alloc] init];
  item3.itemName = @"Read a book";
  [self.toDoItems addObject:item3];
  
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
  XYZAddToDoItemViewController *source = [segue sourceViewController];
  XYZToDoItem *item = source.toDoItem;
  if (item != nil)
  {
    [self.toDoItems addObject:item];
    [self saveList];
    [self.tableView reloadData];
    
  }
}

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self)
  {
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  self.path = [self.path stringByAppendingPathComponent:@"TodoList.txt"];
  
  NSFileManager *fileManager = [NSFileManager defaultManager];
  if (![fileManager fileExistsAtPath:self.path])
  {
    self.toDoItems = [[NSMutableArray alloc] init];
  }
  else
  {
    self.toDoItems = [[NSKeyedUnarchiver unarchiveObjectWithFile:self.path] mutableCopy];
  }
  [self loadInitialData];
  self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.toDoItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"ListPrototypeCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  
  XYZToDoItem *toDoItem = [self.toDoItems objectAtIndex:indexPath.row];
  cell.textLabel.text = toDoItem.itemName;
  
  if (toDoItem.completed)
  {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
  }
  else
  {
    cell.accessoryType = UITableViewCellAccessoryNone;
  }
  
  return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete)
  {
    [self.toDoItems removeObjectAtIndex:indexPath.row];
    [self saveList];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  }
  else if (editingStyle == UITableViewCellEditingStyleInsert)
  {
  }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}


#pragma mark - Navigation
 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
  
  XYZToDoItem *tappedItem = [self.toDoItems objectAtIndex:indexPath.row];
  tappedItem.completed = !tappedItem.completed;
  [self saveList];
  
  [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
