[General]

ned-path = .;../queueinglib

network = exam

cmdenv-config-name = examBase
##tkenv-default-config = examBase
qtenv-default-config = examBase

repeat = 5

sim-time-limit = 10000s

**.vector-recording = false

[Config examBase]
description = "Global scenario"
**.sink.lifeTime.result-recording-modes = +histogram 


%for fl in [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]:
[Config exam_conf_fl${"%03d" % int(fl*100)}]
extends = examBase
**.fl=${fl}
%endfor