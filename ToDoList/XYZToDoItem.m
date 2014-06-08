#import "XYZToDoItem.h"

@implementation XYZToDoItem
- (id)init
{
  self = [super init];
  if (self)
  {
    _completed = NO;
  }
  
  return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
  self = [super init];
  if (self)
  {
    _itemName = [coder decodeObjectForKey:@"itemName"];
    _completed = [coder decodeBoolForKey:@"completed"];
  }
  
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
  [coder encodeObject:self.itemName forKey:@"itemName"];
  [coder encodeBool:self.completed forKey:@"completed"];
}

@end
