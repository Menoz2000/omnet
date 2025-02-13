[General]

## dove cerco i file ned
ned-path = .;../queueinglib

## che rete voglio utilizzare
network = esame

#cpu-time-limit = 60s

## quando faccio partire la simulazione lui cerca di prendermi il nome di una configurazione
## gli do il nome della configurazione più semplice possibile
cmdenv-config-name = esame_base #modalità linea di comando
#tkenv-default-config = esame_base
qtenv-default-config = esame_base ## modalità interfaccia grafica

## numero di ripetizioni che devo fare
repeat = 3

## tempo di esecuzione, per quanto voglio eseguire
sim-time-limit = 300s

## debug-on-errors = true

**.vector-recording = false


## configuriamo lo scenario del nostro esperimento
## in questo scenario inserisco parametri che non cambiano mai, perchè poi ereditati dalle configurazioni che voglio utilizzare
[Config esame_base]
description = "global scenario"

## memorizzo alcuni parametri sottoforma di istogramma
**.srv.queueLength.result-recording-modes = +histogram ##lunghezza della coda del server memorizzato come istogramma
**.sink.lifeTime.result-recording-modes = +histogram ##tempo di risposta memorizzato come istogramma

%for rho in [0.7, 0.9]:
        %for cv in [0.5, 1.0, 1.5]:
[Config esame_rho${"%03d" % int (rho * 100)}_cv${"%03d" % int (cv * 100)}]
extends = esame_base
**.cv = ${cv} 
**.rho = ${rho}
%endfor
%endfor