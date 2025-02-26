import org.omnetpp.queueing.Queue;
import org.omnetpp.queueing.Sink;
import org.omnetpp.queueing.Source;
import org.omnetpp.queueing.Router;

network exam2002{
    parameters:

        int N = default(44);

        double lambda = default(100.0);
        
        double mu1 = default(10.0);
        
        double rho = lambda / mu1;

        double cv = default(3.0);

        src.interArrivalTime = 1.0s * exponential(1 / lambda);

        srv[*].serviceTime = 1.0s*lognormal(log(1.0/(mu1*sqrt(1+cv^2))), sqrt(log(1+cv^2)));    

    submodules:
        src: Source;
        router: Router;
        srv[N]: Queue;
        sink: Sink;

    connections:
        src.out --> router.in++;

        for i=0..N-1 {
    		router.out++ --> srv[i].in++;
    		srv[i].out --> sink.in++;
    	}

}
