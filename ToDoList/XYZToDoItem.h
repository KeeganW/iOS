//
//  XYZToDoItem.h
//  ToDoList
//
//  Created by Keegan Williams on 9/11/14.
//
//

#import <Foundation/Foundation.h>

@interface XYZToDoItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;

@end
