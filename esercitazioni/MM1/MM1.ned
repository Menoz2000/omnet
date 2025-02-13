//carico i moduli gia deviniti in queuinglib
//nella libreria queuinglib posso trovare questi moduli semplici
import org.omnetpp.queueing.Queue;//servitore con coda
import org.omnetpp.queueing.Sink;
import org.omnetpp.queueing.Source;	

network MM1
{
	//parametri da utilizzare
	parameters:

		//dimensione della coda
		int K=default(10);

		//voglio rappresentare la curva di carico del mio server
		//variabile indipendente che voglio usare per pilotare la mia simulazione -> rho
		//asse x-> rho = lambda/mu
		double rho=default(0.8);
		double mu =default(10);//tasso di arrivo
		double lambda = mu * rho;

		//tempo di interarrivo dei pacchetti della sorgente
		//volatile-> ogni volta viene ricalcolato il valore della variabile
		src.interArrivalTime = exponential(1s/lambda);

		//quanto tempo viene impiegato per eseguire quel dato job dal server
		srv.serviceTime = exponential(1s/mu);
		srv.capacity = K;	

		//ho mappato le variabili definite per il mio problema sui parametri interni del simulatore

	//dichiaro i sottomoduli
	submodules:
		src: Source;
		srv: Queue;
		sink: Sink;

	
	connections:
		//l'array di ingressi non è delimitato
		//devo dire che quando creo un link tra uscita e inresso devo aumentare la dimansione dell'array
		//(in modo che ci sia posto)
		src.out --> srv.in++;
		srv.out --> sink.in++;
}

