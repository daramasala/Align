Align
=====

A lua alignment library for Corona SDK.
* align.lua is the library
* See main.lua for usage example

If you want to align a health bar on top of an object and in its center you can do:
 
```
Align.onTop(player, 10, healthBar) -- put the health bar display object 10 pixels above the player object's top
Align.center(player, healthBar) -- align the centers of the player and health bar
```
Something else you can do is spacing objects vertically or horizontally.
For example, let's say you want to create a toolbar with 3 buttons inside a frame (a rectangle or image or any other display object):
 
```
Align.spaceHorizontally(frame, btn1, btn2, btn3) -- this will space the 3 buttons horizontally inside frame
Align.top(frame, btn1, btn2, btn3) -- this will align the tops of the 3 buttons with the top of the frame
```
You can also use padding. Let's say you have a Corona Container object and you want to align components inside of it. But you don't want buttons and stuff to touch the borders of the dialog because it will be ugly. So you will do this:
 
```
local dialog = display.newContainer(...) -- create a new container
dialog.ref = Align.newReference(dialog, {padding=20}) -- this creates a new reference from dialog's dimensions
local btn1, btn2 = newButton(...), newButton(...) -- create buttons
dialog:insert(btn1)
dialog:insert(btn2)
Align.insideRight(dialog.ref, btn1) -- align the first button to the right of the dialog with padding
Align.onLeft(btn1, 10, btn2) -- align the second button on the left of the first button with 10 pixel space between them
Align.insideBottom(dialog.ref, btn1, btn2) -- align both buttons to the bottom of the padded dialog
```
The `newReference()` call is required here because the buttons are children of the container and the Align library can't take this into consideration. So we create a reference that can be used to align display objects against the container regardless of whether the align objects are children of the container or not.
