[General]
ned-path = .;../queueinglib
network = MG1
#cpu-time-limit = 60s
cmdenv-config-name = MG1Base
#tkenv-default-config = MG1Base
qtenv-default-config = MG1Base
repeat = 5
sim-time-limit = 10000s
#debug-on-errors = true
**.vector-recording = false

# parameters of the simulation
[Config MG1Base]
description = "Global scenario"
**.srv[*].queueLength.result-recording-modes = +histogram
**.sink.lifeTime.result-recording-modes = +histogram
**.rho=0.8


##coefficente di variazione che varia tanto 
%for cv in [0.5, 0.75, 1.0, 1.25, 1.5]:

[Config MG1_cv${"%03d" % int(cv*100)}]
extends=MG1Base
**.cv=${cv}
%endfor

