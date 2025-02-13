import org.omnetpp.queueing.Queue;
import org.omnetpp.queueing.Sink;
import org.omnetpp.queueing.Source;

network esame {
    parameters:
        //processing rate - service time (server)
        double mu = default(100);   // media: 1/mu = 10ms => mu = 100 r/s 
        
        //system load
        double rho = default(0.7);  //input da config
        
        //tasso di arrivo
        double lambda = rho * mu;   


        //coefficiente di variazione del tempo di servizio delle richieste
        double cv = default(0.5);    //input da config


        //intervallo di inter-arrivo
        src.interArrivalTime = 1.0s * exponential(1/lambda);

        //tempo di servizio delle richieste 
        //lognormal(mean,stdev): Log normal distributio
        //mean -> rappresenta il valore medio mu sulla scala logaritmica
        //stdev -> indica quanto varianoi valori intorno alla media
        srv.serviceTime = 1.0s * lognormal(log(1.0/(mu * sqrt(1 + cv^2))), sqrt(log(1 + cv^2)));        
        
    submodules:
        src: Source;
        srv: Queue;
        sink: Sink;

    connections:
        src.out --> srv.in++;
        srv.out --> sink.in++;
        
}