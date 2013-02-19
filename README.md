M3Foundation 1.0.1
============
M3Foundation is a collection of categories and classes that extend and enhance the Foundation framework. This functionality is taken from various M Cubed applications.

M3Foundation includes the following:

- Safer access/editing of arrays and dictionaries
- performBlock:withDelay: methods
- Replace the implementation of a method on a single object
- Bulk KVO operations
- Simplified XML access
- Conversion of predicates and expressions to and from XML representation
- Value transformers for file sizes and CSV strings
- A NSOperation subclass for URL connections

And more

M3Foundation is currently Mac-only. An iOS version is in the works for M3Foundation 1.1.

**M3Foundation requires Lion and Xcode 4.4+**

<br/>

## Change Log

### 1.0.1
* Moved some headers from Protected to Public

### 1.0
* Removed M3Accessibility classes
* Removed the M3DFA class
* Removed the NSFileManager category
* Removed the NSMutableSet category
* No longer supports Garbage Collection, instead uses ARC
* Improved tests
* Updated to modern Obj-C syntax
* Fixed the naming of some methods
* Modified some methods to make more logical and practical sense
* Added category for working with NSCountedSet
* Added NSDictionary category to add equivalent to -[NSArray arrayByAddingObject:]
* Added subscripting to NSMapTable

#### API changes
_M3AccessibilityController_ **(removed)**

<hr/>

_M3AccessibleUIElement_ **(removed)**

<hr/>

_NSArray+M3Extensions_

**Changed**<br/>
Old: `- (id)m3_objectPassingTest:(BOOL (^)(id))`<br/>
New: `- (id)m3_firstObjectPassingTest:(BOOL (^)(id))`

<hr/>

_NSCountedSet+M3Extensions_ **(added)**

**Added**<br/>
`- (NSSet *)m3_objectsWithCount:(NSUInteger)`
`@property (readonly) NSUInteger m3_countedObjectTotal`

<hr/>

_M3DFA_ **(removed)**

<hr/>

_NSDictionary+M3Extensions_ **(added)**

**Added**<br/>
`- (NSDictionary *)m3_dictionaryBySettingObject:(id) forKey:(id <NSCopying>)`

<hr/>

_NSExpression+M3Extensions_

**Changed**<br/>
Old: `+ (NSExpression *)m3_expressionFromXMLElement:(NSXMLElement *)`<br/>
New: `+ (NSExpression *)m3_expressionWithXMLElement:(NSXMLElement *)`

<hr/>

_NSFileManager+M3Extensions_ **(removed)**

<hr/>

_NSKeyValueObserving+M3Extensions_ **(added)**
**Added**<br/>
`- (void)m3_addObserver:(NSObject *) forKeyPathsInArray:(NSArray *) options:(NSKeyValueObservingOptions) context:(void *)`
`- (void)m3_removeObserver:(NSObject *) forKeyPathsInArray:(NSArray *)`
`- (void)m3_willChangeValueForKeys:(NSArray *)`
`- (void)m3_didChangeValueForKeys:(NSArray *)`

<hr/>

_NSMapTable+M3Extensions_ **(added)**

**Added**<br/>
`- (id)objectForKeyedSubscript:(id)`
`- (void)setObject:(id) forKeyedSubscript:(id)`

<hr/>

_NSMutableArray+M3Extensions_

**Changed**<br/>
Old: `- (void)m3_moveObject:(id) toIndex:(NSUInteger)`<br/>
New: `- (void)m3_moveObjectAtIndex:(NSUInteger) toIndex:(NSUInteger)`

<hr/>

_NSMutableSet+M3Extensions_ **(removed)**

<hr/>

_NSObject+M3Extensions_

**Changed**<br/>
Old: `- (id)m3_replaceImplementationOfMethodWithSelector:(SEL) with:(void *)`<br/>
New: `- (id)m3_replaceImplementationOfMethodWithSelector:(SEL) withBlock:(id)`

**Removed**<br/>
`- (void)m3_addObserver:(NSObject *) forKeyPathsInArray:(NSArray *) options:(NSKeyValueObservingOptions) context:(void *)`
`- (void)m3_removeObserver:(NSObject *) forKeyPathsInArray:(NSArray *)`
`- (void)m3_willChangeValueForKeys:(NSArray *)`
`- (void)m3_didChangeValueForKeys:(NSArray *)`

<hr/>

_NSPredicate+M3Extensions_

**Changed**<br/>
Old: `+ (NSPredicate *)m3_predicateFromXMLElement:(NSXMLElement *)`<br/>
New: `+ (NSPredicate *)m3_predicateWithXMLElement:(NSXMLElement *)`

<hr/>

_NSXMLNode+M3Extensions_

**Removed**<br/>
`- (NSXMLNode *)m3_nodeForXPath:(NSString *) error:(NSError **)`