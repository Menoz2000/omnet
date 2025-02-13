[General]
ned-path = .;../queueinglib
network = MM1_LB0
#cpu-time-limit = 60s
cmdenv-config-name = MM1Base
#tkenv-default-config = MM1Base
qtenv-default-config = MM1Base
repeat = 5
sim-time-limit = 10000s
#debug-on-errors = true
**.vector-recording = false

# parameters of the simulation
[Config MM1Base]
description = "Global scenario"
**.srv1.queueLength.result-recording-modes = +histogram
**.srv2.queueLength.result-recording-modes = +histogram
**.sink1.lifeTime.result-recording-modes = +histogram
**.sink2.lifeTime.result-recording-modes = +histogram


##unico scenario in cui il carico non è bilanciato
[Config MM1_Unbalanced_Source_NOBAL]
extends=MM1Base
**.Balance="NoBal"  ##parametro fittizio per aggiungere l'equivalente di un tag all'interno del file sca

**.mu1=5.0
**.mu2=5.0
**.lambda1=4.5  ##carico al 90%
**.lambda2=2    ##carico al 40%

