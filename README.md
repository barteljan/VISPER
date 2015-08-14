#VISPER 

[![CI Status](http://img.shields.io/travis/Jan Bartel/VISPER.svg?style=flat)](https://travis-ci.org/Jan Bartel/VISPER)
[![Version](https://img.shields.io/cocoapods/v/VISPER.svg?style=flat)](http://cocoapods.org/pods/VISPER)
[![License](https://img.shields.io/cocoapods/l/VISPER.svg?style=flat)](http://cocoapods.org/pods/VISPER)
[![Platform](https://img.shields.io/cocoapods/p/VISPER.svg?style=flat)](http://cocoapods.org/pods/VISPER)

VISPER ist eine Bibliothek welche die Entwicklung von modularen IOS Apps auf Basis des VIPER-Patterns erleichtern soll.
Dazu stellt sie eine Beispielimplementierung, Protokolle und Basisklassen für die Implementierung der einzelnen VIPER Komponenten zur Verfügung. Das Framework unterstützt außerdem die Implementierung von einzelnen modularen Komponenten, welche erst später zur Gesamtapplikation zusammen gesetzt werden. Dadurch soll eine erhöhte Wiederverwendbarkeit und Testbarkeit der einzelnen Komponenten (ComposedApplications) erreicht werden.


Das Design des Frameworks wurde von folgenden Artikeln stark inspiriert:
[Introduction to VIPER - Mutual Mobile](http://mutualmobile.github.io/blog/2013/12/04/viper-introduction/)
[Architecting iOS Apps with VIPER - Architecture - objc.io issue #13](http://www.objc.io/issue-13/viper.html)
[Using CocoaPods to Modularize a Big iOS App - Hubspot.com](http://product.hubspot.com/blog/architecting-a-large-ios-app-with-cocoapods)

#Installation

VISPER ist über [CocoaPods](http://cocoapods.org) verfügbar. Um es zu installieren müssen Sie einfach folgende Zeile zu Ihrem Repository hinzufügen. 

```ruby
pod "VISPER"
```

Um das Beispielprojekt auszuführen, clonen Sie bitte dieses Repository und führen dann `pod install` im Beispielrepository (./Example) aus.

## Autor

Jan Bartel, barteljan@yahoo.de

## Lizenz

VISPER is available under the MIT license. See the LICENSE file for more info.
