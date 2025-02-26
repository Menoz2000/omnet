import pandas as pd
import numpy as np

import matplotlib.pyplot as plt

def theoretical(N: int) -> float:
    mu, lam, cv = 10.0, 100.0, 3.0
    rho = lam / (N * mu)
    ret = 1 / mu + ((rho * (1 + pow(cv, 2))) / (2 * mu * (1 - rho)))
    return ret

data = "results/exam2002_third.data"
df = pd.read_csv(data, delimiter="\t")

n_sim = df["#N"].to_numpy()
time_sim = df["ResponseTime"].to_numpy()

n_ther = n_sim
time_ther = np.array([ theoretical(elem) for elem in n_ther ])


fig, ax = plt.subplots()
ax.set(xlabel='$N$', ylabel='Time [s]')

ax.plot(n_ther, time_ther)
ax.plot(n_sim, time_sim)
# pts=[x/10.0 for x in range(1, 10)]
# plot_line(ax, '-', None, 'Theoretical Curve', pts, [theoretical(x) for x in pts])
plt.legend()
plt.savefig('exam2002.png')
plt.show()