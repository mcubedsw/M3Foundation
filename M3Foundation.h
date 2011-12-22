/*****************************************************************
 M3Foundation.h
 M3Foundation
 
 Created by Martin Pilkington on 09/01/2010.
 
 Copyright © 2006-2011 M Cubed Software.
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
  
*****************************************************************/

#import "M3AccessibilityController.h"
#import "M3AccessibleUIElement.h"
#import "M3CSVValueTransformer.h"
#import "M3Date.h"
#import "M3DFA.h"
#import "M3EncapsulatedURLConnection.h"
#import "M3FileSizeValueTransformer.h"
#import "M3IndexSetEnumerator.h"
#import "M3URLConnectionOperation.h"

//Categories
#import "NSArray+M3Extensions.h"
#import "NSExpression+M3Extensions.h"
#import "NSFileManager+M3Extensions.h"
#import "NSMutableArray+M3Extensions.h"
#import "NSMutableDictionary+M3Extensions.h"
#import "NSMutableSet+M3Extensions.h"
#import "NSObject+M3Extensions.h"
#import "NSPredicate+M3Extensions.h"
#import "NSCompoundPredicate+M3Extensions.h"
#import "NSComparisonPredicate+M3Extensions.h"
#import "NSString+M3Extensions.h"
#import "NSXMLElement+M3Extensions.h"
#import "NSXMLNode+M3Extensions.h"
#import "M3KeyValueObserving.h"