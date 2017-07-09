# Glasgow
[![Version](https://img.shields.io/cocoapods/v/Glasgow.svg?style=flat)](http://cocoapods.org/pods/Glasgow)
[![Swift 3.1](https://img.shields.io/badge/Swift-3.1-green.svg?style=flat)](https://swift.org/)
[![License](https://img.shields.io/cocoapods/l/Glasgow.svg?style=flat)](http://cocoapods.org/pods/Glasgow)
[![codecov.io](https://codecov.io/github/inacioferrarini/Glasgow/coverage.svg?branch=master)](https://codecov.io/github/inacioferrarini/Glasgow)
[![Documentation Coverage](https://github.com/inacioferrarini/glasgow/blob/master/docs/badge.svg)](https://github.com/realm/jazzy)
[![CI Status](http://img.shields.io/travis/inacioferrarini/Glasgow.svg?style=flat)](https://travis-ci.org/inacioferrarini/Glasgow)
[![Platform](https://img.shields.io/cocoapods/p/Glasgow.svg?style=flat)](http://cocoapods.org/pods/Glasgow)


# What is it?
Glasgow is a basic set of classes, designed to work well together or not.
Every class has one responsibility and one responsibility only, being fully adherent to S.O.L.I.D. principles.

# Goals
* Dramatically reduce ViewControllers' size.
* Provide an easy project startup and reduce project startup time.
* Through the usage of a well designed base classes, provide a standard that will keep the project as standardized as possible.

This way, glasgow is divided in five domains (subspecs):
* Core: Basic elements used by more specific domain.
* Networking: Basic Api consuption.
* Transformer: Basic value transformation classes.
* UIKit: UIKit related classes.
* Arrow: Extension using 'Arrow' to generically convert ArrowParseable objects.

## Requirements
* iOS 8.0+

## Installation
Glasgow is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Glasgow"
```

## Author
Inácio Ferrarini, inacio.ferrarini@gmail.com

## License
The MIT License (MIT)

Copyright (c) 2016 Inácio Ferrarini

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
