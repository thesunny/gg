# HiLogger

## WARNINGS! Could not determine CONTENT-LENGTH of response body

The warning "Could not determine content-length of response body" is a
Webrick bug and not a HiLogger bug. In production, if you use Thin, this
bug will disappear.


## Overview

HiLogger is a debugging tool like FireBug for Ruby Rack applications
like Rails and Sinatra. It lets you log variables/values to the browser while
you work on and debug your web application.

To use it, simply call "gg" from anywhere in your application.
gg stands for the "gg" in "logger" but was also chosen because it is easy to
type, even when your right hand is on the mouse. 

```ruby
gg "Hello World" 
```

Of course, it would be more useful to see the value of a variable:

```ruby
msg = "Hello World"
gg msg 
```

HiLogger will output to the screen the "gg msg" call, the call position and
the data.

It properly works with Hash and Array values as well as custom objects.

```ruby
gg [ 1, 2, 3]
gg( :a => 'alpha' ) # note: you can't use gg{ :a => 'alpha' } because Ruby thinks its a block
gg MyObject.new( 'cool object' )
```

## Choosing Injection Points

HiLogger always adds the required CSS file at the top of the <head> tag.
If there is no <head> tag then it adds it to the top of the content.

HiLogger tries to add the logging information in the HTML where it finds
<!--hi_logger-->.

If it cannot find <!--hi_logger--> then it adds the HTML to the top of the
page after the css link.


## Non-HTML requests

If you call gg during a non-HTML request like a txt, js or css file, HiLogger
does not return the value to the screen since this would mess up your
application. When this happens, you can access your dump at:

  /hi_logger/history/0
  
Currently, HiLogger is set up to store 10 dumps at:

  /hi_logger/history/0
  ...
  /hi_logger/history/9
  

## Build

  rake build

## Install

  rake install
