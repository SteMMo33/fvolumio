# fvolumio

A Flutter application to control Volumio device

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Prima compilazione
Se la compilazione ed il deploy da Android Studio appaiono molto lenti e soprattutto fermi alla scritta 'Initializing gradle..'
provare con il deploy da line di comando 'flutter run'.
Una volta ha restituito un errore sul controllo dell'accettazione di licenze dell'SDK.
Aggiustato con 'flutter doctor'.

Inoltre c'era un problema con gradle.
La piattaforma stava scaricando una versione di gradle in .gradle/wrapper/gradle-x.y
Per non scaricare un'altra versione ho fato puntare una versione già scaricata alla variabile *distributionUrl* nel file android/gradle/wrapper/gradle-wrapper.properties

## Modifiche

### Richiesta asincrone

Per aggiungere le ricerche in Internet ho seguito l'articolo: https://flutter.dev/docs/cookbook/networking/fetch-data

Aggiunto un modulo nel file pubsec.yaml
Per sapere la versione di riferimento è possibile guardare sul sito:
https://pub.dev/packages/http#-installing-tab-

### Lista
