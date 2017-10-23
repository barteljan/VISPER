#VISPER#

VISPER is al library to develop modular apps based on the VIPER Pattern.

[![CI Status](http://img.shields.io/travis/Jan Bartel/VISPER.svg?style=flat)](https://travis-ci.org/Jan Bartel/VISPER)
[![Version](https://img.shields.io/cocoapods/v/VISPER.svg?style=flat)](http://cocoapods.org/pods/VISPER)
[![License](https://img.shields.io/cocoapods/l/VISPER.svg?style=flat)](http://cocoapods.org/pods/VISPER)
[![Platform](https://img.shields.io/cocoapods/p/VISPER.svg?style=flat)](http://cocoapods.org/pods/VISPER)

---------------------------------------------------------------------------------------------------------

#API-DOCS#
The api docs can be found [here](http://htmlpreview.github.io/?https://github.com/barteljan/VISPER/blob/master/docs/index.html)

<!--
##Einführung##

VISPER ist eine Bibliothek welche die Entwicklung von modularen IOS Apps auf Basis des VIPER-Modells erleichtern soll. VISPER dient hierbei vornehmlich zur Organisation der Kommunikation der einzelnen Komponenten dieses Modells.
Dazu stellt es eine Beispielimplementierungen, Protokolle und Basisklassen zur Implementierung einzelner VIPER Komponenten zur Verfügung. Das Framework unterstützt den Aufbau modularen Features/Komponenten, welche erst später zu einer Gesamtapplikation zusammen gesetzt werden. 

Das Design des Frameworks wurde von folgenden Artikeln stark inspiriert:
[Introduction to VIPER - Mutual Mobile](http://mutualmobile.github.io/blog/2013/12/04/viper-introduction/)
[Architecting iOS Apps with VIPER - Architecture - objc.io issue #13](http://www.objc.io/issue-13/viper.html)
[Clean Architecture](http://www.objc.io/issue-13/viper.html)
[Using CocoaPods to Modularize a Big iOS App - Hubspot.com](http://product.hubspot.com/blog/architecting-a-large-ios-app-with-cocoapods)

---------------------------------------------------------------------------------------------------------

##Installation##

VISPER ist über [CocoaPods](http://cocoapods.org) verfügbar. Um es zu installieren müssen Sie einfach folgende Zeile zu Ihrem Repository hinzufügen. 

```ruby
pod "VISPER"
```

Um das Beispielprojekt auszuführen, clonen Sie bitte dieses Repository und führen dann `pod install` im Beispielrepository (./Example) aus.

---------------------------------------------------------------------------------------------------------

##Kurze Einführung in das VIPER Modell##

Das [VIPER Modell](http://mutualmobile.github.io/blog/2013/12/04/viper-introduction/) beschreibt eine Software-Architektur in Anlehnung an das Konzept der "[Clean Architecture](http://pfadzurcleanarchitecture.de)" von Autor zur Entwicklung von iOS-Apps. Dazu versucht es die einzelnen Bestandteile einer App nach dem [Single Responsibility Principle]() in kleine nur für eine einzelne Funktionalität verantwortliche Komponenten zu unterteilen und in Schichten, von einander unabhängig zu organisieren. Es wurde erstmalig im Artikel [Introduction to VIPER](http://mutualmobile.github.io/blog/2013/12/04/viper-introduction/) von Mutal Mobile vorgestellt. VIPER ist ein Akronym welches sich aus aus den fünf von ihm beschriebenen Softwareschichten zusammen setzt.

Die innerhalb einer VIPER Anwendung unterschiedenen Schichten sind im einzelnen:

* View
* Interactor
* Presenter
* Entity
* Routing 

###Die View-Schicht (View Layer) - View und Viewcontroller###

Der View einer Anwendung kümmert sich innerhalb des VIPER Modells um die konkrete Darstellung der einzelnen Benutzerinterfaces und die Annahme von Interaktionen mit dem Nutzer. Um dieser Aufgabe gerecht zu werden kommuniziert sie nur mit der Presenter-Schicht der Anwendung. Innerhalb von VISPER wird die Viewschicht durch ein Objekt der Klasse UIView und einen zugehörigen View-Controller übernommen. Ein ViewController kann hierzu die Basisklasse VISPERViewController oder das Protokol IVISPERViewController erweitern/implementieren, welche ihm verschiedene nützliche Standardfunktionalitäten/Schnittstellen zur Kommunikation mit anderen Komponenten des Frameworks zur Verfügung stellt. Typische Aufgaben der View Schicht sind zum Beispiel die Darstellung von UI-Elementen, Animationen, sowie die Annahme von Taps auf einen Button.

###Die Presentationsschicht (Presentation Layer) - Presenter###

Die Presentations Schicht verarbeitet die aus der Verarbeitungsschicht kommenden Daten zur Darstellung innerhalb der View und nimmt aus der View-Schicht Interaktionen des Nutzers entgegen um die darauf folgenden Aktionen/Funktionalitäten innerhalb der Routing- und Interaktionsschicht auszulösen. Innerhalb von VISPER können Presenter durch Objekte mit dem Protokol IVISPERPresenter, IVISPERControllerPresenter sowie den zugehörigen Basisklassen VISPERPresenter und VISPERControllerPresenter übernommen. Diese stellen Funktionalitäten zur Kommunikation mit anderen VISPERKomponenten zur Verfügung. Typische Aufgaben welche innerhalb der Presentationsschicht durchgeführt werden, bestehen in der Formatierung von Ausgabewerten, der Validierung von Eingabewerten und der Reaktion auf Benutzereingaben innerhalb der View-Schicht. View und Presenter sind in VIPER ähnlich wie im der oft bekannteren [MVVM-Model](http://www.objc.io/issues/13-architecture/mvvm/) organisiert.

###Die Verarbeitungsschicht (Interactor Layer) - Interactor, ComposedRepository und ComposedPersistenceStore###

Die Verarbeitungsschicht enthält die eigentliche Businesslogik der Anwendung. Sie enthält keinerlei Wissen über View und Routingschicht und kommuniziert einzig und allein mit der Presentationsschicht und Entity-Schicht. Dies führt dazu, dass das in dieser Schicht implementierte Domänenwissen von der Darstellung und Speicherung der enthaltenen und verarbeiteten Daten unabhängig ist. Innerhalb der Interaktionsschicht werden Daten verarbeitet, aus der Entityschicht geladen und gespeichert, und an die Präsentationsschicht weiter gegeben. 

###Die Entity-Schicht (Entity Layer) - Repository, PersistenceStore und Datenhaltung###


###Die Routing-Schicht (Routing Layer) - der Wireframe###


## Autor

Jan Bartel, barteljan@yahoo.de

## Lizenz

VISPER is available under the MIT license. See the LICENSE file for more info.
-->
