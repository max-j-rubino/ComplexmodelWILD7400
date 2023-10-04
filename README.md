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



