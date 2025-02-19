import org.omnetpp.queueing.Queue;
import org.omnetpp.queueing.Sink;
import org.omnetpp.queueing.Source;
import org.omnetpp.queueing.Delay;

network exam{
    parameters:

        double lambda = default(10.0);
        double fl = default(0.7);

        double lambdal = lambda * fl;
        double lambdac = lambda * (1-fl);

        double mul = default(10.0);
        
        double deltac = default(0.1);
        double muc = mul;

        

        srcl.interArrivalTime = 1.0s * exponential(1 / lambdal);
        srcc.interArrivalTime = 1.0s * exponential(1 / lambdac);

        srvl.serviceTime = 1.0s * exponential(1 / mul);
        srvc.delay = 1.0s * exponential(1 / muc);
        
        delay.delay = 1.0s * exponential(deltac);
        

    submodules:
        srcl: Source;
        srvl: Queue;

        srcc: Source;
        delay: Delay;
        srvc: Delay;

        sink: Sink;
    connections:
        srcl.out --> srvl.in++;
        srvl.out --> sink.in++;

        srcc.out --> delay.in++;
        delay.out --> srvc.in++;
        srvc.out --> sink.in++;

}