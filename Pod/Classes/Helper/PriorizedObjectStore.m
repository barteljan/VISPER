//
//  PriorizedObjectStore.m
//  Pods
//
//  Created by Bartel on 31.07.15.
//
//

#import "PriorizedObjectStore.h"
#import "PriorizedObjectStoreItem.h"

@interface PriorizedObjectStore()

@property(nonatomic,strong)NSMutableArray *prioriezedObjects;

@end

@implementation PriorizedObjectStore


-(NSMutableArray*)prioriezedObjects{
    if(!self->_prioriezedObjects){
        self->_prioriezedObjects = [NSMutableArray array];
    }
    
    return self->_prioriezedObjects;
}

-(void)addObject:(NSObject*)object withPriority:(NSInteger)priority{
    
    if(!object){
        return;
    }
    
    [self removeObject:object];
    
    PriorizedObjectStoreItem *currentItem = [[PriorizedObjectStoreItem alloc] initWithObject:object
                                                                                    priority:priority];

    BOOL appendToEnd = TRUE;
    NSInteger index = 0;
    NSInteger lastPriority = 0;
    NSInteger currentPriority = 0;
    for (PriorizedObjectStoreItem *item in self.prioriezedObjects) {
        lastPriority = currentPriority;
        currentPriority = item.priority;
        
        if(lastPriority <= priority && item.priority < priority){
            appendToEnd = FALSE;
            break;
        }
        
        index++;
    }
    
    if(appendToEnd){
        [self.prioriezedObjects addObject:currentItem];
    }else{
        [self.prioriezedObjects insertObject:currentItem atIndex:index];
    }
}

-(void)removeObject:(NSObject*)object{
    
    NSMutableArray *objectsToRemove = [NSMutableArray array];
    
    //clean store from already priorized objects
    for (PriorizedObjectStoreItem *item in self.prioriezedObjects) {
        if([item.object isEqual:object]){
            [objectsToRemove addObject:item];
            break;
        }
    }
    
    [self.prioriezedObjects removeObjectsInArray:objectsToRemove];

}

-(NSArray*)allObjects{
    NSMutableArray *objectArray = [NSMutableArray array];
    
    for(PriorizedObjectStoreItem *item in self.prioriezedObjects){
        [objectArray addObject:item.object];
    }
    
    return [NSArray arrayWithArray:objectArray];
}

@end
