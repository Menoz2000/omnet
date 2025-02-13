import org.omnetpp.queueing.Queue;
import org.omnetpp.queueing.Sink;
import org.omnetpp.queueing.Source;
import org.omnetpp.queueing.Delay;

network MG1
{
	parameters:
		int N=default(5); //numero di nodi
		
		double rho=default(0.8);
		double mu=default(10.0);
		double cv=default(1.0);//coefficiente di variazione
		double delta=default(0.1);
		double lambda = mu * rho;

		//sorgente continua a mandarmi traffico con un intervalli 1/lambda, ancora esponenziale qui
		src[*].interArrivalTime = exponential(1s/lambda);

		//formula data(magica)
		srv[*].serviceTime = 1.0s*lognormal(log(1.0/(mu*sqrt(1+cv^2))), sqrt(log(1+cv^2)));
		//srv[*].serviceTime = 1.0s*exponential(1.0/mu);

		//non usiamo gaussiana perchè ammette valori negativi
		//
		delay[*].delay=1.0s*truncnormal(delta, 0.1*delta);
		//delay[*].delay=0s;

	submodules:
		src[N]: Source;
		srv[N]: Queue;
		delay[N]: Delay;
		sink: Sink;
	connections:
	    for i=0..N-1 {
    		src[i].out --> delay[i].in++;
    		delay[i].out --> srv[i].in++;
    		srv[i].out --> sink.in++;
    	}
}

