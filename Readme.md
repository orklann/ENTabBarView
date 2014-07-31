## ENTabBarView

ENTabBarView is a clean and simple TabBarView for Cocoa with ARC enabled and Objective-C.

### How to use

* Drag ENTabBarView into your project.
* Drag a NSView object into Interface Builder, and set its class as ENTabBarView
* In your App delegate's 

```
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{   
    [tabBarView setDelegate:self];
    
    [tabBarView addTabViewWithTitle:@"Elk Developer's Note.txt"];
    [tabBarView addTabViewWithTitle:@"index.html.rjs"];
}
```
  
  Here we assume that `tabBarView` is a IBOutlet to that ENTabBarView in Interface Builder.


### Callbacks

After `[tabBarView setDelegate:self]`, and set your App delegate like this: 

	`@interface ENAppDelegate : NSObject <NSApplicationDelegate, ENTabBarViewDelegate>{`
	
You can implement these methods in your `tabBarView`'s delegate to get notified while these events are sent as the method name suggested.

`- (void)tabWillActive:(ENTabCell*)tab;`

`- (void)tabDidActived:(ENTabCell*)tab;`

`- (void)tabWillClose:(ENTabCell*)tab;`

`- (void)tabDidClosed:(ENTabCell*)tab;`

`- (void)tabWillBeCreated:(ENTabCell*)tab;`

`- (void)tabDidBeCreated:(ENTabCell*)tab;`

### ScreenShots

![image](https://raw.githubusercontent.com/aaron-elkins/ENTabBarView/master/ENTabBarView.png)

### Authors

[Aaron Elkins](http://blog.pixelegg.me)

[Email Me](mailto:threcius@yahoo.com)

### Buy me a cup of tea

If you like this chunk of code, please consider [buying me a cup of tea](https://www.pixelegg.me/buy_me_tea).

### License

ENTabBarView is licensed under [MIT](http://opensource.org/licenses/MIT) license.
