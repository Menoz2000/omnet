[General]
ned-path = .;../queueinglib

network = exam2002

cmdenv-config-name = exam2002Base

qtenv-default-config = exam2002Base

repeat = 5

sim-time-limit = 10000s

**.vector-recording = false

[Config exam2002Base]
description = "Global scenario"
**.sink.lifeTime.result-recording-modes = +histogram

%for N in [15, 20, 25, 30, 35, 40, 45, 50]:
[Config exam2002_N${"%03d" % int(N)}]
extends = exam2002Base
**.N=${N}
%endfor