@interface SKUICardViewElement : NSObject
- (bool)isAdCard;
@end

%hook SKUIGridViewElementPageSection

-(void)_reloadViewElementProperties {
	%orig;
	NSMutableArray *elementsToRemove = [[NSMutableArray alloc] init];

	NSMutableArray *elements = MSHookIvar<NSMutableArray *>(self, "_viewElements");

	for (SKUICardViewElement *element in elements) {
		if(![element isKindOfClass:[%c(SKUICardViewElement) class]]) return; // continue
		if([element isAdCard]) {
			[elementsToRemove addObject:element];
		}
	}

	for (SKUICardViewElement *element in elementsToRemove) {
		[elements removeObject:element];
	}

}

%end