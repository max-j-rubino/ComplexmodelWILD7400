# ComplexmodelWILD7400
This is a complex model following the ODD description

Class project: a summary and outline for an agent-based fisheries model, following the ODD protocol. The purpose of this model is to evaluate the potential effects of the long-term harvest of the most vulnerable fish in the population. This model is inspired by the findings of Phillip et al. (2009). If angling removes the most vulnerable fish in the population, and if there is a genetic component of vulnerability we could expect high pressure angling to result in a population of fish with low angling vulnerability. 

Key model attributes:

1. There is a heritable component to fish vulnerability. Fish with low vulnerability are less likely to be caught. Fish with high vulnerability are more likely to be caught and harvested.

2. Fish grow following a Von Bertalanffy growth equation. The larger a fish is the more eggs that fish will produce.  Fish recruit with ricker stock-recruitment dynamics.

3. Fishing and natural mortality happen at the same time.

4. The number of spawners per egg is not related to fish vulnerability to angling.

5. Fish vulnerability to angling is bound between 0.1 and 0.9.

Purpose: The purpose of this model is to see if angling pressure could artificially select fish that are less vulnerable to angling. I hypothesize that under high angling pressure, the average vulnerability of fish will decrease as will catch per unit effort.

Overview: 

Entities, state variables, and scales: This model has one entity which is fish. Each fish is described by two continuous variables: size (mm) and vulnerability (0-1). The environment that the fish exist in is described by two additional continuous variables: angling effort (hours) and natural mortality (M). Growth trajectories come from the Von Bertalanffy growth equations and the number of spawners per spawner. Spawners per spawner are lagged one year to account for time to mature. This model only uses adult fish. We assume juveniles are invulnerable to angling. 

Processes: The probability of an individual surviving to spawn is the probability of a fish surviving to the month (S). S is defined as -exp(Z), where Z is the monthly survival rate. Z is equal to v[i]*Fp*(1-vr)+v[i]*Fp*vr*alpha+M. Fp is the instantaneous probability of capture for each individual which is equal to q*hours, where q is a constant and hours are the number of angling hours. v[i] is the individual probability of capture. vr is the voluntary release rate, alpha is the post-release mortality rate, and M is the instantaneous monthly mortality rate. Length at age will be determined from a von Bertalanffy growth equation L(a)=Linf(1-exp(-k((a-t0))) where Linf is the asymptotic length, k is the growth coefficient, t0 is the age at which size is 0, and alpha is age. Weight is determined by the relationship log (W) = log (a) + b log (L), where W is weight, a is the intercept, b is the slope and L is length. At the end of each year, fish will be paired randomly. The number of adult progeny they produce is determined as P=a+b*weight where P is the number of spawners produced, a is the intercept, and b is the slope. Weight refers to the females' weight. Proginey vulnerability is drawn from a normal distribution centered around their parents' mean vulnerability with a SD of 0.1. 

Design Concepts:

Basic principles: This model describes concepts outlined in Phillip et al. (2009). If vulnerability to capture is heritable, we can expect angling to artificially select for fish less likely to be caught. This can lead to lower catch rates.  We assume that there is a heritable component to each fish's probability of capture.

Emergence: The results of this model are the average  vulnerability of fish in  the population, the total mortality  rate  Z, and  catch  per unit effort.  Decreased  catch per unit effort and  decreased vulnerability  demonstrate selective pressure towards less  vulnerable individuals. 

Adaptation: No direct objective seeking exists in this model. Indirect objective seeking exists that fish with higher vulnerability are less likely to reproduce. Fish that have low vulnerability are less likely  to be  caught and thus are more likely to have  a higher contribution to  the next generation. 

Objectives: There is  a  tradeoff between  angling effort and catch per  unit effort. At first, the more angling hours there are  the more fish will be  caught. But as the selective pressure begins to take effect, we could see catch per unit effort decrease dramatically. If fisheries managers want more fish  to  be caught, there may be an advantage  to lowering angling effort. 

Learning: This model does not allow fish to make adaptive changes over time. A component could be added to  allow anglers to make  adaptive changes. Perhaps when  catch rates are  low they could  leave.

Sensing: There is not a sensing component to this model. 

Interactions: Fish interact when they reproduce, and when the carrying capacity  of the pond  begins to approach. As the  population gets closer to  K, reproductive success and  growth slows.

Stochasticity: Stochasticity in this model results  in the fish's weekly fates (caught and harvested, caught and released survivor, caught and released dead, not caught alive, not caught dead).  These in turn result in  whether  or not the fish spawns or grows. Stochasitisty comes from  these fates being  drawn from  a categorical distribution. Many of  the  probabilities  in the  categorical  distribution are also derived from other distributions.  For  example, vulnerability  is drawn from  a normal  distribution centered  around the parents' mean vulnerability.  There is also  randomness in  which individuals are paired to mate.  Stochasticity is used to represent processes that are impossible to represent mechanically. These processes are either poorly understood or limited by computing power.

Collectives:  Collectives  are not represented  in this model.  However,  there is density  dependence in the number of eggs that survive to  spawners, and the growth coefficient of fish. 

Observations: Outputs  from the model needed to  observe  population level change are: catch per unit effort, population age and  size structure, population size,  and mean vulnerability of fish. 

Initialization: We assume  equal sex  ratios, size,  and age structure.  Fishes vulnerability  will be drawn from  a  BETA(1,1) distribution. Effort is constant, although we may explore adaptive effort. We will  start  with a  burn-in  period of 1000 fish, and run the model until  equilibrium  is reached with effort turned  off. We will use  this as  the control.

Input Data: There is no input  data for this model.

Subroutines: The model will have several subroutines. Weekly there will  be the option  for fish to be caught or not, and die or survive. Fish cannot be caught  twice in the same week. Fish that are not caught will have  a  greater survival, and be  more likely to move to the  next  period.  Yearly each  fish will grow, and then  redproduce. The reproduction  will  result in progeny. These progeny will not  enter  the population  until the  year  after  reproduction  to  avoid  having to model   individual fish reproduction. All year 1 +  fish can reproduce, but the fecundity of smaller fish is lower. Mate  pairing  is random.

