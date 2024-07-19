# Relazione Progetto d'Esame

## BooksApp

L'applicazione **BooksApp** permette all'utente di cercare libri e salvarli come preferiti.

### Funzionalità Implementate

* **Barra di ricerca per libri** che sfrutta l'API Google Books
* Possibilità di salvare localmente libri come preferiti tramite pulsante
* Possibilità di cercare libri per categoria (genere)
* Pagina home con libri consigliati e popolari
* Pagina opzioni con pulsante per la dark mode
* Barra di navigazione tra le schermate principali

### Possibili Implementazioni Future

* Implementazione Login e gestione Account utente
* Implementazione sistema di notifiche per nuovi libri
* Implementazione libri popolari sfruttando un punteggio di rating
* Implementazione ulteriori impostazioni nella schermata Settings

## Analisi del Dominio applicativo

La pagina principale è **MainScreen** che permette di navigare verso le altre schermate tramite barra di navigazione posizionata sul fondo.

### HomeScreen

L'applicazione, tuttavia, parte da una **HomeScreen** che mostra due widget:
    - Il primo widget contiene un singolo libro consigliato.
    - Il secondo consiste in una lista di libri popolari.

### SearchScreen

**SearchScreen** permette di visualizzare due widget atti alla ricerca di libri:
    - Il primo è una griglia di icone che rappresentano i vari generi di libri su cui ricercare.
    - Il secondo è un bottone che porta ad una barra di ricerca che permette di ottenere libri basandosi sul titolo.
Entrambi gli widget restituiscono una lista di libri con annesso bottone che rende possibile la loro aggiunta ai preferiti.

### FavouriteBooksScreen

**FavouriteBooksScreen** permette di visualizzare i libri salvati come preferiti tramite apposito bottone presente nella altre schermate.
Questa funzione di salvataggio è stata implementata tramite l'utilizzo di SharedPreferences.

### BookPage

Pagina accessibile non tramite barra di navigazione, ma cliccando su un libro ottenuto da qualsiasi widget delle schermate sopra citate.
Dà ulteriori informazioni sul singolo libro, se disponibili, come:
    - Descrizione
    - Rating

### SettingsScreen

**SettingsScreen** implementa funzionalità di utility varie.
L'unica funzionalità effettivamente implementata è la possibilità di passare alla modalità scura di visualizzazione delle varie schermate.
Le altre funzionalità sono semplici placeholder per implementazione futura.

## Migliorie Possibili

### Migliore salvataggio dei dati

L'utilizzo di SharedPreferences è stato prediletto, in quanto più semplice e meno time consuming, tuttavia per un'implementazione ottimale del salvataggio dati si potrebbe utilizzare la libreria Flutter ORM.
ORM permetterebbe una maggiore persistenza dei dati delle API tramite PrismaEngine (PrismaJS/TS Client).

## Commenti Finali

Abbiamo utilizzato una sola API (GoogleBooks), in quanto altre API sarebbero state, a nostro avviso, ridondanti o poco pertinenti.\
\
Ci siamo avvalsi dell'utilizzo dei Flutter Isolate come alternativa, per la gestione del MultiThreading (Foreground e Background Thread), a WorkManager, in quanto più più semplice e meno time consuming.\
\
Abbiamo utilizzato Flutter perché che sta riscuotendo maggiore successo nelle implementazioni odierne, in più con un singolo sviluppo il codice può essere buildato e testato su più piattaforme.
