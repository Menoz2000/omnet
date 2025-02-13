##mako ci da la possibilita di costruire il .ini utilizzando codice simil-python

##esempio di lancio queuenet: ./queuenet -f MM1.ini -c MM1_rho08_K10 -r0

##vogliamo andare a analizzare un po di dati, fare più run alla volta -> make_runfile -f MM1.ini
##mi crea un runfile per fare i run di tutte le conf nel .ini ripetute per il valore di repeat impostato
##successivamente -> make -j $(nproc) -f Runfile
##cosi lanciamo la simulazione in modalità testuale
##results/MM1*.sca sono gli output di tutte le simulazioni
##prendere i dati e metterli in un formato più gestibile -> utilizzo un db sqllite da interrogare, istruisco in un file .json come prelevare i dati che mi servono dai file .sca risultati
##lancio lo script che memorizza i risultati su sqllite
##parse_data.py -c configMM1.json -d MM1.db -r results/MM1_rho0*.sca
##per vedere il db -> sqlitebrowser MM1.db
##voglio navigare il db per fare le mie analisi
##script che prende il database e la configurazione, carica tutte le analisi e produce i file di dati
##nalyze_data.py -d MM1.db -c configMM1.json
##posso guardare i dati -> es. less results/loadcurve_K7.data
##posso plottarli

##configurazioni di base
[General]

##dove cerco i file ned
ned-path = .;../queueinglib

##che rete voglio utilizzare
network = MM1

#cpu-time-limit = 60s

##quando faccio partire la simulazione, lui cerca di prendermi il nome di una configurazione
##gli do il nome della config piu semplice possibile
cmdenv-config-name = MM1Base##modalita linea di comando
tkenv-default-config = MM1Base
qtenv-default-config = MM1Base##modalita interfaccia grafica

##numero di ripetizioni che devo fare
repeat = 5

##tempo di esecuzione, per quanto voglio eseguire
sim-time-limit = 10000s

#debug-on-errors = true

## ** ->match su qualciasi modulo a qualsiasi livello
##disabilito a livello globale la creazione di vettori
**.vector-recording = false



## parameters of the simulation
##definisco uno scenario 
##metto alla fine il termine 'Base' perche gli script del prof che usiamo scartano dalla lista delle cose da eseguire
##le configurazioni che terminano in questo modo perche sa che è uno scenario che non voglio far davvero girare
[Config MM1Base]
description = "Global scenario"

##metto i parametri di config che non cambiano mai
##memorizzare alcuni parametri sottoforma di istogramma
**.srv.queueLength.result-recording-modes = +histogram ##lunghezza della coda del server memorizzato come istogramma
**.sink.lifeTime.result-recording-modes = +histogram ##tempo di risposta memorizzato come istogramma

##templating mako che produce linee di configurazione .ini
%for K in [5, 7, 10, -1]: ##in [] ci sono dei valori di coda (-1 è coda infinita), idero con k su questi valori
%for rho in [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]: ##quando il carico comincia a diventare alto, a fronte di piccole variazioni di rho, il tempo di risposta aumenta molto(possiamo infittire i punti nell'ultima fase per avere una esplorazione più accurata in questa fase)


##voglio che nel nome di ogni configurazione ci siano i parametri utilizzati per la conf corrente
##per far si che ogni configurazione erediti i dati dalla configurazione di base -> dichiaro che ogni conf estende MM1Base
[Config MM1_rho${"%02d" % int(rho*10)}_K${K if K>0 else "inf"}]
extends=MM1Base
**.K = ${K}
**.rho=${rho}


%endfor
%endfor