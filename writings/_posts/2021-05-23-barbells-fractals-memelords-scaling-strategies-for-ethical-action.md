---
title: 'Barbells, Fractals & Memelords: Scaling Strategies for Ethical Action'
date: 2021-05-23 14:16:31.000000000 Z
layout: post-external
original_link: https://medium.com/coemeta/barbells-fractals-memelords-scaling-strategies-for-ethical-action-cca9a868b8a1?source=rss-2d441c4de574------2
author: 101274
---

![](https://cdn-images-1.medium.com/max/1024/1*pYjVc0-f7aQrt6o2hdZ4GA.png)

#### Tinkering in graph theory, networks & numerical simulation

### Intro

This is in an exercise in quantitative tinkering around some ideas that are often treated more conceptually & qualitatively. I’m taking the opportunity to play with modeling tools & techniques I haven’t used much (& some I have).

I hope these (initially) simple models might demonstrate some angles & approaches, suggest further lines of inquiry, & serve as a basis for further exploration. I also include many references & resources I found useful.

### General Problem Statement

> **_Can apparent tensions between localism & globalism _** _— _[microsolidarity](https://www.microsolidarity.cc/) & [systems](https://thenextsystem.org/systems) [change](https://simpol.org/)_ — _ **_be reconciled by fractal strategies_** _, operative & effective at all scales? (self-similar, ‘scale-free’)_

> **_Or else by something like a barbell portfolio strategy_** _: mostly invested in the safer bets (high-probability, low-impact) of localism, but also exposed to asymmetric payoffs (low-probability, high-impact) at larger scales?_

> **_Or will memelords growth-hack the revolution?_**

_(these are not necessarily mutually-exclusive)_

### Contents & Caveat

_There’s a fair bit of blathering before the technical stuff & original work.   
Here’s a table of contents to navigate around that. (links only work on web)_

_(Far better: read this post in a collapsible Roam Research graph_ [**_here_**](https://roamresearch.com/#/app/dnlmc_public/page/1twp6v3Dm)_)  
(& find all the code used in this post in_ [**_this repo_**](https://github.com/dnlmc/bfm)_)_

- [**Intro**](#78fb)
- [**General Problem Statement**](#4b82)
- [**Motivation & Acknowledgments**](#bcda)
- [**Minimal Problem Specification**](#76ab)
- [**Technical Approach & Antecedents**](#0aed)
- [**Building the Network**](#4c0b)
- [**Simulating System Dynamics**](#b1a7)
- [**A final look at all simulations, grouped by strategy**](#ecd6)
- [**…And all simulations grouped by graph structure**](#ddf6)
- [**(Tentative) Conclusion & Future Directions**](#c812)

### Motivation & Acknowledgments

The contours of this semi-congealed research question have been coming into focus for me for some time, in several interrelated clusters:

**1. Taxonomies**  **of complexity, & related analytic & strategic methods**

> a la [Cynefin](https://en.wikipedia.org/wiki/Cynefin_framework), [Metamodernism & the Model of Hierarchical Complexity](https://metamoderna.org/what-is-the-mhc/), [Robust Decision Making](https://en.wikipedia.org/wiki/Robust_decision-making), the broader history of [complexity science](https://en.wikipedia.org/wiki/Complex_system), etc

![](https://cdn-images-1.medium.com/max/1024/1*XzPOokQLSjxIJWjygP0XqQ.png)
_sources: deepuncertainty.com_

**2.**  **Taxonomies of ethical & moral development, strategy & action**

> a la Human(e) [Metrics](https://medium.com/what-to-build/is-anything-worth-maximizing-d11e648eb56f) & [Systems](https://www.notion.so/FAQ-f4f7ad008c5043f6946e43544b328ecd) / [Tech](https://ledger.humanetech.com/), [Rooted Cosmopolitanism](https://prezi.com/f7-pgbr5xtn6/rooted-cosmopolitanism/), [Microsolidarity](https://www.microsolidarity.cc/), [Bildung](https://en.wikipedia.org/wiki/Bildung), [Spiral Dynamics](https://en.wikipedia.org/wiki/Spiral_Dynamics) (kinda), etc

![](https://cdn-images-1.medium.com/max/1024/1*V-NA2pvU-anAaE4ma7jEew.png)
_sources (top left to bottom right): Is Anything Worth Maximizing?, Rooted cosmopolitanism, Spiral Dynamics, Model of Hierarchical Complexity, Human Technology, Microsolidarity_

**3.** The topic of this post: **Scaling laws (or opportunities) for social change.**

> which entails all of the above (as mentioned: these are all interrelated)

![](https://cdn-images-1.medium.com/max/800/1*1Sgc3xlFnSJOGiHzyk6AjQ.gif)

![](https://cdn-images-1.medium.com/max/1022/1*oBa7KT4E3zCU5j9cLiOyvg.png)

I plan to write more on these themes, but they are not novel or original to me, as the many references in this post demonstrate. I’m motivated by & indebted to a confluence of related (if oblique & apophenic) material.   
(…as one does in the engineered serendipity of our _preferential attachments_, memetic meanderings & self-cultivated-yet-emergent information ecologies).

Some of the most salient references, in addition to those mentioned above:

- [Mutual Aid](https://en.wikipedia.org/wiki/Mutual_aid_(organization_theory)), [Solidarity economy](https://en.wikipedia.org/wiki/Solidarity_economy), [Commons Transition](https://commonstransition.org/), [Game ~B](https://www.gameb.wiki/index.php?title=Get_Started)
- Localism as expressed in ‘[think globally act locally](https://en.wikipedia.org/wiki/Think_globally,_act_locally)’, ‘[the personal is political](https://en.wikipedia.org/wiki/The_personal_is_political#Criticisms)’ & the place-basedness of [Indigenous Knowledge](https://www.harpercollins.com/products/sand-talk-tyson-yunkaporta?variant=32280908103714) [systems](https://anchor.fm/tyson-yunkaporta)  
(& again [Microsolidarity](https://www.microsolidarity.cc/) & [Rooted Cosmopolitanism](https://prezi.com/f7-pgbr5xtn6/rooted-cosmopolitanism/))
- [Optionality](https://thedeepdish.org/optionality-book/), [barbell strategies](https://en.wikipedia.org/wiki/Barbell_strategy), [Emergent Strategy](https://alliedmedia.org/speaker-projects/emergent-strategy-ideation-institute)
- [Scaling laws](https://www.penguinrandomhouse.com/books/314049/scale-by-geoffrey-west/)

While these are mostly conceptual & qualitative sources, [_qualitative_ & _quantitive_](https://statmodeling.stat.columbia.edu/2021/02/18/smell-the-data/) approaches are critical to holistic sensemaking & solutions. Quantitative methods are more my forte, & while there are many technical precedents to approaching these _sorts_ of questions, few (that I found) address it directly, so here it goes.

### Minimal Problem Specification

The [**general problem statement**](https://dnlmc.medium.com/barbells-fractals-memelords-scaling-strategies-for-ethical-action-cca9a868b8a1#4b82) above is …a lot. So we’ll distill it down to a much narrower form to design a minimum viable approach as proof of concept for further iteration.

> **We essentially want to know if there are strategies that work both locally & globally — at micro, meso, & macro scales — to direct ethical action & spur social change.**

Or in other words: _produce the feedback loop where the good gets better_

[![](https://cdn-images-1.medium.com/max/1024/1*pUQu4tz7iCPPZU6liuiWJQ.png)](https://twitter.com/Conaw/status/1353260858839687168)
_yes we’re also getting weird with it_

We need to concretely define all these terms, but first recall that we have 3 candidate strategies (not necessarily mutually exclusive):

1. **Fractal** : doing the same thing at all scales (roughly)
2. **Barbell** : e.g. 80–20 split of local & global ‘investments’
3. **Memelord** : a memetic vanguard of core actors, & peripheral propagation thru the system. _(suggested by_ [_this_](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4664236/) _&_ [_related_](https://youtu.be/bmZmAll9ao4)_ _[_work_](https://advances.sciencemag.org/content/7/17/eabf1211)_)_

Here’s a minimal specification as a start:

**Given**

- **a network with some realistic or empirically-useful structure**
- **some scarce resource distributed such that many lack while few have extreme excess**

**…can we design strategies of the sort suggested above, which result in a more optimal distribution (minimized precarity), yet are realistic or feasible to implement?**

This distills our original problem statement down to something resembling a toy econometric or resource planning problem. But as with any complex modeling task (or any task really), [starting simple](https://www.santafe.edu/research/results/working-papers/how-to-do-agent-based-simulations-in-the-future-fr) is the [only](https://developers.google.com/machine-learning/guides/rules-of-ml#rule_4_keep_the_first_model_simple_and_get_the_infrastructure_right) [sane](https://arxiv.org/abs/2011.01808) [way](https://betanalpha.github.io/assets/case_studies/principled_bayesian_workflow.html#Issues_with_Question_Four:_Model_Adequacy) to proceed\*, despite what trend hoppers, dilettantes & consultants might say.

_\* I realize there is also a_ [_philosophy of model_ **_contraction_**](https://projecteuclid.org/journals/statistical-science/volume-20/issue-2/On-Model-Expansion-Model-Contraction-Identifiability-and-Prior-Information/10.1214/088342305000000098.full)_, vs_ **_expansion_**

### Technical Approach & Antecedents

In addition to the many qualitative treatments already mentioned, there are myriad ways to approach & model this problem quantitatively:

- [Operations Research](https://en.wikipedia.org/wiki/Operations_research) & ([Combinatorial](https://en.wikipedia.org/wiki/Combinatorial_optimization)) [Optimization](https://en.wikipedia.org/wiki/Mathematical_optimization): [linear](https://en.wikipedia.org/wiki/Linear_programming) / [integer programming](https://en.wikipedia.org/wiki/Integer_programming), e.g. [transportation problem](https://towardsdatascience.com/operations-research-in-r-transportation-problem-1df59961b2ad#:~:text=The%20transportation%20problem%20is%20a,(e.g.%20warehouse%2C%20store).)
- [Evolutionary](https://en.wikipedia.org/wiki/Evolutionary_algorithm) / [genetic programming](https://en.wikipedia.org/wiki/Genetic_programming) & [Reinforcement Learning](https://en.wikipedia.org/wiki/Reinforcement_learning)
- [Agent-based modeling](https://en.wikipedia.org/wiki/Agent-based_model), [simulation](https://en.wikipedia.org/wiki/Computer_simulation), [systems dynamics modeling](https://en.wikipedia.org/wiki/System_dynamics)
- [Graph theory](https://en.wikipedia.org/wiki/Graph_theory), [network analysis](https://en.wikipedia.org/wiki/Social_network_analysis)

I initially thought OR was the logical place to start, but as I concretely conceptualized the problem, it was obviously **more important** to model _relationships, fuzzy stochasticity_ & _emergent dynamics_ than _clear static costs, constraints & objective functions_. This nudged me toward graph theory, network analysis & simulation, e.g. agent-based modeling & system dynamics.

I did some background research on similar approaches, & there are A LOT. This is not a literature review (though I might summarize some later), but **here’s a short list of the most relevant resources I consulted** , from most accessible to more technical:

#### Economic models

- [The AI Economist: Improving Equality and Productivity with AI-Driven Tax Policies](https://blog.einstein.ai/the-ai-economist/) (Salesforce blog)
- [Is Inequality Inevitable? Wealth naturally trickles up in free-market economies, model suggests](https://www.scientificamerican.com/article/is-inequality-inevitable/) (Scientific American)
- [The Emergence of Inequality](https://sites.google.com/view/scottepagestructuralinequality/home) (Scott E Page)
- [Emergent Inequality and Endogenous Dynamics in a Simple Behavioral Macroeconomic Model](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3415472) (SSRN, 2019)
- [How Market Ecology Explains Market Malfunction](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3696449) (PNAS, 2020)

#### Scaling, Networks & Agent-based models

- [Growth, innovation, scaling, and the pace of life in cities](https://www.pnas.org/content/104/17/7301.full) (PNAS)
- [Decision-Making in Agent-Based Modeling: A Current Review and Future Prospectus](https://www.frontiersin.org/articles/10.3389/fevo.2018.00237/full) (Frontiers in Evolutionary Ecology, 2019)
- [Social Simulation Week 2020 Workshop on Agent-based models of social networks](https://www.youtube.com/watch?v=ua411-GN9qM) (Youtube, 2020)
- [Introduction to stochastic actor-based models for network dynamics](http://www.stats.ox.ac.uk/~snijders/SnijdersVandeBuntSteglich2010.pdf) (Social Networks, 2010) [pdf]
- [Social network analysis and agent-based modeling in social epidemiology](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3395878/) (EP-I, 2012)
- [Best Friends Forever? Modeling the Mechanisms of Friendship Network Formation](https://www.researchgate.net/publication/348442740_BEST_FRIENDS_FOREVER_MODELING_THE_MECHANISMS_OF_FRIENDSHIP_NETWORK_FORMATION) (Winter Simulation Conference, 2020)
- [Intelligent Agents in Co‑Evolving Knowledge Networks](https://search.proquest.com/openview/2befad435ded2b6b70dad67deb88829c/1?pq-origsite=gscholar&cbl=2032364) (Mathematics, 2021)
- [Small and Other Worlds: Global Network Structures from Local Processes](https://www.journals.uchicago.edu/doi/abs/10.1086/427322#fn1) (American Journal of Sociology, 2005) [[pdf](http://www.stats.ox.ac.uk/~snijders/RobinsPattisonWoolcock2005.pdf)]
- [The Critical Periphery in the Growth of Social Protests](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0143611) (PLOS ONE, 2015)

#### Operations Research

- [Probability and Algorithms, chapters 8 & 9](https://www.nap.edu/read/2026/chapter/9) (Book, 1992)
- [Multi-commodity flow problem](https://en.wikipedia.org/wiki/Multi-commodity_flow_problem) (wikipedia)

### Building the Network

Finally, the main event.

But first some basic terminology:

![](https://cdn-images-1.medium.com/max/685/1*6AXzS9n5w3F7dtkN72Idvw.png)

Establishing the network architecture & data structures felt foundational to further iteration & simulation. So I decided on an initial stack of [**tidygraph**](https://tidygraph.data-imaginist.com/) (built on [**igraph**](https://igraph.org/)) & [**ggraph**](https://ggraph.data-imaginist.com/), in **R**  — _since it is the best data science language_, & I didn’t want to mess around with goofy software like [NetLogo](https://ccl.northwestern.edu/netlogo/).   
(I’m aware of the irony).

#### Random Graphs

Started with a few classic network architectures, so-called _random graphs_. While [not the most realistic representations of real world networks](http://networksciencebook.com/chapter/3#summary3), they have some [well-characterized empirical properties](https://www.pnas.org/content/99/suppl_1/2566) (as good simple models should):

- [**Erdős–Rényi**](https://en.wikipedia.org/wiki/Erd%C5%91s%E2%80%93R%C3%A9nyi_model) ([docs](https://igraph.org/r/doc/sample_gnp.html)) — the og & (near) simplest random graph, theorized in 1959. Nodes are randomly connected via a specified probability, producing a [Poisson](https://en.wikipedia.org/wiki/Poisson_distribution) degree distribution. (_degree_ = a node’s # of _edges_)
- [**Barabási–Albert**](https://en.wikipedia.org/wiki/Barab%C3%A1si%E2%80%93Albert_model) ([docs](https://igraph.org/r/doc/sample_pa.html)) — models the _scale-free_ character [posited](https://www.nature.com/articles/s41467-019-09038-8) of many real world networks, (a power-law degree distribution) via [preferential attachment](https://en.wikipedia.org/wiki/Preferential_attachment)
- [**Watts–Strogatz (small world)**](https://en.wikipedia.org/wiki/Watts%E2%80%93Strogatz_model) ([docs](https://igraph.org/r/doc/sample_smallworld.html)) — reflects the [small-world](https://en.wikipedia.org/wiki/Small-world_network) property (aka _six-degrees of separation_) of many real social networks. But like ER above, produces a Poisson degree distribution, rarer in real networks.

NB, it’s also not trivially obvious [what characteristics of real networks we _are_](https://advances.sciencemag.org/content/3/5/e1602548) or [_should be_ modeling](https://www.youtube.com/watch?v=ua411-GN9qM). E.g. Facebook friends or Twitter followers are probably not the most relevant topologies for actual individual outcomes in the world.

#### Code & outputs

> This is not a tutorial, so I won’t explain all the code, but these are good tutorials:

- [Tidygraph Example](http://rstudio-pubs-static.s3.amazonaws.com/307087_0a7a54f46d5d44b5829c6452484db638.html)
- [Introduction to Network Analysis with R](https://www.jessesadler.com/post/network-analysis-with-r/) — several packages
- [Graph analysis using the tidyverse](https://rviews.rstudio.com/2019/03/06/intro-to-graph-analysis/)
- [A Social Network Simulation In The Tidyverse](https://www.statworx.com/de/blog/a-social-network-simulation-in-the-tidyverse/)
- [Social Network Analysis in R part 1: Ego Network](https://link.medium.com/PK3KiBJ4Ldb)

For initial simplicity & visual clarity, **I’m keeping it** [**Dunbar**](https://en.wikipedia.org/wiki/Dunbar%27s_number) (150 nodes) **& static** (graph size & structure will not evolve)

```
library(tidyverse)
library(tidygraph)
library(ggraph)
library(igraph)
```

```
# initialize graph via {tidygraph} function
graph_er <- play_erdos_renyi(150, 0.03, directed = F)
```

```
# visualize via {ggraph}
ggraph(graph_er) +
geom_edge_link() +
geom_node_point() +
theme_graph()
```

![](https://cdn-images-1.medium.com/max/1024/0*Rs2KxtWmmDI1YISV)

```
graph_ba <- play_barabasi_albert(150, power = .01, directed = F)
```

```
ggraph(graph_ba, layout = "graphopt") +
geom_edge_link() +
geom_node_point() +
theme_graph()
```

![](https://cdn-images-1.medium.com/max/1024/0*i1rh19yylGke4WW-)

```
graph_sw <- play_smallworld(1, 150, 1, .2, loops = F, multiple = F)
```

```
ggraph(graph_sw, layout = 'nicely') +
geom_edge_link() +
geom_node_point() +
theme_graph()
```

![](https://cdn-images-1.medium.com/max/1024/0*XyyMYWsKvgKJW6Yg)

These are sightly enough little graphs, but I want to enrich them with more information & stochasticity, as a basis for further simulation.

(Recall our minimal specs above)

**Given**

- **a social network with some realistic or empirically-useful structure**
- **some scarce resource distributed such that many lack while few have extreme excess**

So in addition to the random distribution of edges (connections) between the nodes, I want to weight those connections as a representation of the ‘strength’ of relationship. Then: create asymmetrically-distributed ‘resources’ among the nodes, with an ‘endangered’ threshold indicating a level of resource precarity. I also add a ‘growth probability’ value to each node for later use.

[https://medium.com/media/a7036181b82a99d2d5e46c25588fc680/href](https://medium.com/media/a7036181b82a99d2d5e46c25588fc680/href)

Then let’s see what we got, reshaping nodes by their resources, & edges by weight:

[https://medium.com/media/0f1b0651e5bfe159729e7f8b2a889ced/href](https://medium.com/media/0f1b0651e5bfe159729e7f8b2a889ced/href)
![](https://cdn-images-1.medium.com/max/1024/0*9q-PnZo5_I8TdFLU)

mmmm…graphy.

After a similar approach with our other graphs:

![](https://cdn-images-1.medium.com/max/1024/0*GVXZOZoQzegUSt62)

![](https://cdn-images-1.medium.com/max/1024/0*PDeI-SNX4a8jWaDY)

We can see some of the respective attributes of each of these graph models mentioned above, but let’s quantify them with some summary statistics.

A look at the initial resource distribution, which is identical for all graphs:

```
as.list(graph_er)$nodes$resources %>% summary()
```

```
# Min. 1st Qu. Median Mean 3rd Qu. Max.
# 1.25 49.45 118.77 540.64 320.69 19337.38
```

```
as.list(graph_er)$nodes %>% as_tibble() %>%
ggplot() + geom_histogram(aes(resources), binwidth = 100) +
theme_minimal()
```

![](https://cdn-images-1.medium.com/max/1024/1*UUL8Esb4Mj1oBYlsVwGTiQ.png)

We see the steep lognormal decay with a median value of 119 & sparse outliers up to nearly 20k (hi elon).

Let’s zoom in a bit & plot the smoothed density to get a better view, along with a ‘precarity threshold’ below which nodes will be considered endangered:

[https://medium.com/media/caaf4aa0dc93edb64c57cfb53e761b24/href](https://medium.com/media/caaf4aa0dc93edb64c57cfb53e761b24/href)
![](https://cdn-images-1.medium.com/max/1024/1*oJEqzA9nwTM110cHZ_ub0Q.png)

![](https://cdn-images-1.medium.com/max/1024/1*Mf023FR7V3nFhTQ437HCuw.png)

We can also see the [degree distributions](https://en.wikipedia.org/wiki/Degree_distribution) of our graphs (i.e. the number of ‘edges’ or connections between nodes), which vary as described above. We’ll also include counts of total edges as well as ‘[cliques](https://en.wikipedia.org/wiki/Clique_(graph_theory))’, or groups of mutually-connected nodes. These are all basic indicators of the connectedness of a graph.

[https://medium.com/media/66de247a391778c6004c753a26521317/href](https://medium.com/media/66de247a391778c6004c753a26521317/href)[https://medium.com/media/043ef3cf2db752e79b98419a5805621d/href](https://medium.com/media/043ef3cf2db752e79b98419a5805621d/href)
![](https://cdn-images-1.medium.com/max/1024/1*dElNjnLPFChry3w3_GlRjQ.png)

Here we see the skewed, fat tailed power law distribution of the BA graph, & the more symmetrical Poisson distributions of the other graphs (but with considerably different spread & kurtosis). Later we’ll see how these differences in the ‘connectedness’ of nodes (& total number of edges) affects transactions throughout the network & overall system dynamics.

And a quick look at the distribution of edge weights, which we’ll use to indicate the ‘strength’ of relationships between nodes.

Although the number of edges & degree distributions vary across graphs, the edge weight distributions are consistent, as we defined them all as normal distributions:

```
as.list(graph_er)$edges$edge_weight %>% summary()
# Min. 1st Qu. Median Mean 3rd Qu. Max.
# 0.0000 0.3637 0.4661 0.4681 0.5697 1.0000
```

```
# plot edge weight histogram & density
as.list(graph_er)$edges %>% as_tibble() %>%
ggplot(aes(edge_weight)) + geom_histogram(aes(y=..density..), binwidth = .03) +
geom_density(aes(y=..density..)) +
theme_minimal()
```

![](https://cdn-images-1.medium.com/max/1024/1*dqJRrFnZXUuIGdO1iG7bFQ.png)

Ok, I’m happy with my little model graphworlds, ready to run some simulations

### Simulating System Dynamics

First we’ll program some baseline dynamics for our networks, prior to any resource-sharing solidarity strategies.

I’m still not going for ultra-realism here, just a simple model with recognizable emergent dynamics. So at each time-step, we’ll increment each node’s resources by a probabilistic cost & growth function:

[https://medium.com/media/b9079a297854b90d404e6e7fa91c5288/href](https://medium.com/media/b9079a297854b90d404e6e7fa91c5288/href)

Then we’ll implement & visualize our baseline simulation via the following function, which logs various values at each iteration & produces a series of plots which we’ll compile into an animated gif:

[https://medium.com/media/5d856221cf3514ec08fba79d62a96853/href](https://medium.com/media/5d856221cf3514ec08fba79d62a96853/href)
```
library(gifski)
```

```
# create gif via gifski::save_gif, for 7 'years' worth of 'monthly' iterations
save_gif(sim_gif_maker_er(7), gif_file = "sim_er_7.gif", width = 800, height = 850,
delay = .12, loop = TRUE, progress = TRUE, res=133)
```

Then lets see what we get:

![](https://cdn-images-1.medium.com/max/800/1*ZSXb_ja3PMSxtDLpQnHw7A.gif)

There’s a lot going on here, so bears a few views to take it all in, but here’s a rundown of the **major points** :

- The iteration counter at the top left enumerates the **discrete time-steps** in the the simulation: here meant to be analogous to ‘months’ in the 7 ‘year’ simulation (so 84 total iterations)
- The endangered counter & precarity proportion reflect the total number & relative proportion of nodes falling below our ‘ **precarity threshold** ’ of 15 resources
- On the graph itself, we see the **growth & contraction of individual nodes** according to their resource level (turning red when below the precarity threshold), per the probabilistic cost & growth function defined above
- The histogram / density chart at the bottom depicts the resource distribution of the entire network as it changes over time, along with median & mean indicators

Taken together, we see **a system with baseline dynamics in which** :

- The total number & relative proportion of **precarious nodes increases over time** (from \< 10% to \> 40%)
- **Few nodes experience tremendous resource growth while most contract — ** as indicated by the leftward lurch of the resource distribution peak (aka its mode), as well as the divergence of the median (leftward) & mean (rightward)

In other words we have **a system of exacerbating inequality** : rich get richer, poor get poorer. The [Matthew Effect](https://en.wikipedia.org/wiki/Matthew_effect) in motion, which should be broadly familiar to us (though not precisely realistic).

(We can also plot these dynamics statically via the log of iteration values we stored in the sim\_stats\_er dataframe):

```
l1 <- ggplot(data=sim_stats_er, aes(x=iteration, y=median_resources)) +
geom_line() + theme_minimal()
l2 <- ggplot(data=sim_stats_er, aes(x=iteration, y=log(mean_resources))) +
geom_line() + theme_minimal()
l3 <- ggplot(data=sim_stats_er, aes(x=iteration, y=precarity_proportion)) +
geom_area() + ylim(c(0,1)) + theme_minimal()
```

```
l1/l2/l3
```

![](https://cdn-images-1.medium.com/max/1022/1*WJlaoDckog7K63WmTAK6gg.png)

Right. So revisiting to our original research question:

> **_Given_**

> **_- a network with some realistic or empirically-useful structure_**

> **_- some scarce resource distributed such that many lack while few have extreme excess_**

> **_…can we design strategies of the sort suggested [below], which result in a more optimal distribution (minimized precarity), yet are realistic or feasible to implement?_**

…

> **_1. Fractal_** _: doing the same thing at all scales (roughly)_

> **_2. Barbell_** _: e.g. 80–20 split of local & global ‘investments’_

> **_3. Memelord_** _: a memetic vanguard of core actors, & peripheral propagation thru the system._ (suggested by [this](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4664236/) & [related](https://youtu.be/bmZmAll9ao4) [work](https://advances.sciencemag.org/content/7/17/eabf1211))

We’ve got our (crude, but hopefully) **empirically-useful network & baseline dynamics** of increasing precarity, which we hope to mitigate via the proposed strategies. So **let’s design & implement those strategies** , starting at the top.

#### Fractal Strategy

We defined our **Fractal Strategy** as: _doing the same thing at all scales (roughly)_

Since we kept our initial random graphs simple & [Dunbar](https://en.wikipedia.org/wiki/Dunbar%27s_number)-sized, there isn’t much of a meaningful notion of ‘scale’ at this point. I plan to explore that sort of complexity in future iterations of this study, but for now will just construct a one-size-fits-all strategy to apply across the scale-constrained graph as our **_fractal_** strategy.

In this strategy, all connected nodes will exchange resources according to the following solidarity-inspired rule:

> If a node has **3x more resources** than its peer node, it will send resources to that node in an amount determined by the **wealthier node’s current resources** , **scaled by the edge\_weight** (i.e. relationship strength) between nodes

In code:

[https://medium.com/media/45f393cd43420cab8593e65c88806175/href](https://medium.com/media/45f393cd43420cab8593e65c88806175/href)

Then our updated simulation & animation function:

[https://medium.com/media/9c1f07c536b583f6a8b698c4b8bf8932/href](https://medium.com/media/9c1f07c536b583f6a8b698c4b8bf8932/href)

Run it for 7 ‘years’:

```
# create gif via gifski::save_gif, for 7 'years' worth of 'monthly' iterations
save_gif(sim_gif_maker_er(7), gif_file = "fractal_er_7.gif", width = 800, height = 850,
delay = .12, loop = TRUE, progress = TRUE, res=133)
```

Output:

![](https://cdn-images-1.medium.com/max/800/1*jRSfjvnnZUybhJj746o4iQ.gif)

We see that our fractal solidarity strategy results in quite different dynamics than the baseline system:

- Both total endangered node count & relative precarity proportion **stabilize at levels slightly below initial conditions** , rather than spiking
- Resource distribution median & mean both steadily increase as network **resource growth is much more broadly distributed**

_(things seem to go off the rails & get a bit pathological at the end, at least graphically, but ok, we’re still just tinkering here)_

A final look at all relevant plots in parallel:

![](https://cdn-images-1.medium.com/max/800/1*ZSXb_ja3PMSxtDLpQnHw7A.gif)

![](https://cdn-images-1.medium.com/max/800/1*jRSfjvnnZUybhJj746o4iQ.gif)

![](https://cdn-images-1.medium.com/max/1022/1*zBvB5U16PtJnYHmBXcA4vg.png)

![](https://cdn-images-1.medium.com/max/1022/1*T7q-jNr8t3_J8y_MxqMtAQ.png)

So it seems our fractal strategy had roughly the desired effect on our Erdős–Rényi graph (although precarity is not eliminated).

But before implementing other strategies, let’s see how the above dynamics play out in our other graphs. (all code can be found in [this repo](https://github.com/dnlmc/bfm))

**Barabási–Albert**

![](https://cdn-images-1.medium.com/max/800/1*WO9RP7dMSlaHE5f-6XxPaA.gif)

![](https://cdn-images-1.medium.com/max/800/1*kl54VpghR1S0cW08PrpY8g.gif)

![](https://cdn-images-1.medium.com/max/1022/1*asr88czCvAh0xU2MqZrB1Q.png)

![](https://cdn-images-1.medium.com/max/1022/1*oBa7KT4E3zCU5j9cLiOyvg.png)

**BA notes** :

- similar baseline dynamics
- but due to power-law degree distribution (resulting in an overall less-connected graph), our **fractal strategy is not as effective** in mitigating precarity as it was in the Erdős–Rényi graph (Poisson degree distribution)
- — median network resources do not increase nearly as much, & the mode hardly moves, thus the precarity proportion still increases moderately

**Watts–Strogatz (small world)**

![](https://cdn-images-1.medium.com/max/800/1*HK21ILJjrbqr05RIw2Wkkw.gif)

![](https://cdn-images-1.medium.com/max/800/1*2_m82n1-3nRRxjUYI2JFsA.gif)

![](https://cdn-images-1.medium.com/max/1022/1*zBvB5U16PtJnYHmBXcA4vg.png)

![](https://cdn-images-1.medium.com/max/1022/1*RSzpwdl_pvdmlS6lIhBk9Q.png)

**WS notes:**

- again, **baseline dynamics consistent with our other graphs**
- & also again, a **less effective fractal strategy** , this time owing to the graph’s ‘small world’ nature, where nodes are connected in clusters or ‘neighborhoods’ with limited connections between clusters. (despite a Poisson degree distribution)
- — thus we see resource growth concentrated in lower left clusters & scarcely making it to some areas of the graph. (a dynamic we might again recognize in our own world)
- — & again, overall median network resources increase less, & the mode hardly moves, while the precarity proportion increases moderately

So we see initially that, **while consistently mitigating the worst of the baseline dynamics, our fractal strategy’s effectiveness appears to be dependent on the underlying network structure.**

Let’s see how our remaining 2 strategies fare.

#### Barbell Strategy

We defined our **Barbell Strategy** as: _80–20 split of local & global ‘investments’._

To implement, we’ll simply add logic on top of the **fractal strategy** which **diverts 20% of the resources** that would have been allocated to individual nodes from their wealthier connections, & **allocate them ‘globally’ to the entire graph**. A sort of graphworld [UBI](https://en.wikipedia.org/wiki/Universal_basic_income).

This requires only a few additional lines of code, which can be found in the full codebase [here](https://github.com/dnlmc/bfm).

The outputs:

![](https://cdn-images-1.medium.com/max/800/1*xJUY_khJ_YuIpNPkg44Olw.gif)

![](https://cdn-images-1.medium.com/max/800/1*mNUBVM5_aam0AtPQfLLhZA.gif)

![](https://cdn-images-1.medium.com/max/800/1*jDjYJ7WBdLjiBe1HT1Zfzg.gif)

![](https://cdn-images-1.medium.com/max/1022/1*nui5kAT6Q3sv9rjcput3-w.png)

![](https://cdn-images-1.medium.com/max/1022/1*WA57hz2tIKRIfqJiTEFYPw.png)

![](https://cdn-images-1.medium.com/max/1022/1*3sMR2-SyU8IDGPnvZza4nQ.png)

**Barbell strategy notes:**

- The **80–20 local / global split** of _fractal strategy_ resource reallocations has an **immense impact** on the overall network, **eliminating precarity in the first few iterations** in all graph structures, making the optimal strategy so far
- _(also, I clearly need to implement some sort of growth constraints in the more realistic iterations of this study to come)_

But let’s see our final strategy.

#### Memelord Strategy

We defined our **Memelord Strategy** as: _a memetic vanguard of core actors, & peripheral propagation thru the system._

This required a more complex implementation than our other strategies, including adding **_core-periphery_** metadata to the nodes of our graphs, inspired by [some](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4664236/) [previous](https://youtu.be/bmZmAll9ao4) [work](https://advances.sciencemag.org/content/7/17/eabf1211). **Core-periphery detection** methods attempt to identify **more connected or influentia** l **_core_** nodes in the network, as well as **less connected & influential _periphery_** nodes. There are [a variety of approaches, but as yet no consensus](https://advances.sciencemag.org/content/7/12/eabc9800), so again I kept it fairly simple initially, using [Kleinberg’s hub centrality scores](https://rdrr.io/cran/igraph/man/hub_score.html) as measures of **core_ness._**

[https://medium.com/media/a2ff5ff7ca0189fd0d898dfc38c11f0e/href](https://medium.com/media/a2ff5ff7ca0189fd0d898dfc38c11f0e/href)

To get a sense of what this did, we can plot our graphs & size by hub score rather than resources as we previously did:

![](https://cdn-images-1.medium.com/max/700/1*qo5boTSMBvr1D-dGpf1DwQ.png)

![](https://cdn-images-1.medium.com/max/700/1*5x_PX3dm1dg-LC5B7-2E9A.png)

![](https://cdn-images-1.medium.com/max/700/1*491OdJnqQMDhoQWJt6O8aQ.png)
_Predictably, nodes with higher hub scores are closer to central cores or nexuses in the networks_

We can also plot the hub score distributions & compare to our previously plotted degree distributions (which are obviously related):

![](https://cdn-images-1.medium.com/max/1024/1*g5SOrwJIb_ZYi3_wEkkttg.png)

![](https://cdn-images-1.medium.com/max/1024/1*dElNjnLPFChry3w3_GlRjQ.png)
_Also predictably, most nodes have fairly low hub scores, while few are highly connected / influential_

So with this additional network information, we can implement our **Memelord Strategy** logic as follows:

- Nodes are influenced to reallocate their resources based on:
- — the strength of their connection (edge weight) to “influencer” nodes
- — in combination with the the _influencer_ nodes’ clout (hub\_score)
- — as well as the strength of the influencer nodes’ connection to other nodes, which are candidates to receive the resource

So in this strategy, **_nodes do not (necessarily) send resources to their direct connections (adjacent nodes),_ but rather to _other nodes_** who are mutually connected to influencer ‘hub’ nodes (proportionate to their hub_ness_ & connection strengths across the full edge path).

Otherwise, the same ‘3x resource’ evaluation is made as in the other strategies.

Again, the code can be found in the full codebase [here](https://github.com/dnlmc/bfm).

Here’s what we get:

![](https://cdn-images-1.medium.com/max/800/1*um4GwacRR910LhjMrA19aA.gif)

![](https://cdn-images-1.medium.com/max/800/1*ciukTKBS7wU03oIoL1xSMA.gif)

![](https://cdn-images-1.medium.com/max/800/1*uadLFuPW3bbR7hjkBlcjXw.gif)

![](https://cdn-images-1.medium.com/max/1024/1*ugu56a5HtxKP19oOPIo3rg.png)

![](https://cdn-images-1.medium.com/max/1024/1*JrQQp5UN6jc040UZq3eyJg.png)

![](https://cdn-images-1.medium.com/max/1024/1*TMF9gDFnEhzkXv0Gp5P7RQ.png)

**Memelord strategy notes:**

- Similar to the **Fractal Strategy** , **resource reallocation is much more constrained** than in the **Barbell Strategy** , with influencers acting as chokepoints or bottlenecks, resulting in **limited mitigation of precarity**
- **Network structure has an obvious impact** here, as less _hubby_ (interconnected) structures result in less _influencer_ reach, which further constrains resource flows

So let’s see all our simulations stacked up against each other.

### A final look at all simulations, grouped by strategy

#### Baseline simulations

![](https://cdn-images-1.medium.com/max/800/1*ZSXb_ja3PMSxtDLpQnHw7A.gif)

![](https://cdn-images-1.medium.com/max/800/1*WO9RP7dMSlaHE5f-6XxPaA.gif)

![](https://cdn-images-1.medium.com/max/800/1*HK21ILJjrbqr05RIw2Wkkw.gif)

![](https://cdn-images-1.medium.com/max/1022/1*zBvB5U16PtJnYHmBXcA4vg.png)

![](https://cdn-images-1.medium.com/max/1022/1*asr88czCvAh0xU2MqZrB1Q.png)

![](https://cdn-images-1.medium.com/max/1022/1*zBvB5U16PtJnYHmBXcA4vg.png)

To reiterate baseline simulation dynamics notes from above, which are fairly consistent across graphs:

- The total number & relative proportion of **precarious nodes increases over time** (from \< 10% to \> 40%)
- **Few nodes experience tremendous resource growth while most contract — ** as indicated by the leftward lurch of the resource distribution peak (aka its mode), as well as the divergence of the median (leftward) & mean (rightward)

#### Fractal Strategy Simulations

![](https://cdn-images-1.medium.com/max/800/1*jRSfjvnnZUybhJj746o4iQ.gif)

![](https://cdn-images-1.medium.com/max/800/1*kl54VpghR1S0cW08PrpY8g.gif)

![](https://cdn-images-1.medium.com/max/800/1*2_m82n1-3nRRxjUYI2JFsA.gif)

![](https://cdn-images-1.medium.com/max/1022/1*T7q-jNr8t3_J8y_MxqMtAQ.png)

![](https://cdn-images-1.medium.com/max/1022/1*oBa7KT4E3zCU5j9cLiOyvg.png)

![](https://cdn-images-1.medium.com/max/1022/1*RSzpwdl_pvdmlS6lIhBk9Q.png)

**Fractal strategy notes:**

- **This strategy stabilizes & mitigates**  **precarity across all graphs** , compared with baseline dynamics, but **its effectiveness is constrained by network structure & overall connectedness** , with precarity ultimately increasing in the latter 2 graphs
- A similar dynamic applies to median & total graph resource growth, where we see growth concentrated in certain ‘neighborhoods’ more than others

#### Barbell Strategy Simulations

![](https://cdn-images-1.medium.com/max/800/1*xJUY_khJ_YuIpNPkg44Olw.gif)

![](https://cdn-images-1.medium.com/max/800/1*mNUBVM5_aam0AtPQfLLhZA.gif)

![](https://cdn-images-1.medium.com/max/800/1*jDjYJ7WBdLjiBe1HT1Zfzg.gif)

![](https://cdn-images-1.medium.com/max/1022/1*nui5kAT6Q3sv9rjcput3-w.png)

![](https://cdn-images-1.medium.com/max/1022/1*WA57hz2tIKRIfqJiTEFYPw.png)

![](https://cdn-images-1.medium.com/max/1022/1*3sMR2-SyU8IDGPnvZza4nQ.png)

**Barbell strategy notes** from above **:**

- The **80–20 local / global split** of _fractal strategy_ resource reallocations has an **immense impact** on the overall network, **eliminating precarity in the first few iterations** in all graph structures, making the optimal strategy so far
- _(also, I clearly need to implement some sort of growth constraints in the more realistic iterations of this study to come)_

#### Memelord Strategy Simulations

![](https://cdn-images-1.medium.com/max/800/1*um4GwacRR910LhjMrA19aA.gif)

![](https://cdn-images-1.medium.com/max/800/1*ciukTKBS7wU03oIoL1xSMA.gif)

![](https://cdn-images-1.medium.com/max/800/1*uadLFuPW3bbR7hjkBlcjXw.gif)

![](https://cdn-images-1.medium.com/max/1024/1*ugu56a5HtxKP19oOPIo3rg.png)

![](https://cdn-images-1.medium.com/max/1024/1*JrQQp5UN6jc040UZq3eyJg.png)

![](https://cdn-images-1.medium.com/max/1024/1*TMF9gDFnEhzkXv0Gp5P7RQ.png)

**Memelord strategy notes** from above **:**

- Similar to the **Fractal Strategy** , **resource reallocation is much more constrained** than in the **Barbell Strategy** , with influencers acting as chokepoints or bottlenecks, resulting in **limited mitigation of precarity**
- **Network structure has an obvious impact** here, as less _hubby_ (interconnected) structures result in less _influencer_ reach, which further constrains resource flows

### …And all simulations grouped by graph structure

#### Erdős–Rényi

_Baseline simulation & reference graphs, followed by strategy simulations:_

![](https://cdn-images-1.medium.com/max/800/1*ZSXb_ja3PMSxtDLpQnHw7A.gif)

![](https://cdn-images-1.medium.com/max/1022/1*zBvB5U16PtJnYHmBXcA4vg.png)

![](https://cdn-images-1.medium.com/max/1024/1*dElNjnLPFChry3w3_GlRjQ.png)

![](https://cdn-images-1.medium.com/max/800/1*jRSfjvnnZUybhJj746o4iQ.gif)

![](https://cdn-images-1.medium.com/max/800/1*xJUY_khJ_YuIpNPkg44Olw.gif)

![](https://cdn-images-1.medium.com/max/800/1*um4GwacRR910LhjMrA19aA.gif)

![](https://cdn-images-1.medium.com/max/1022/1*T7q-jNr8t3_J8y_MxqMtAQ.png)

![](https://cdn-images-1.medium.com/max/1022/1*nui5kAT6Q3sv9rjcput3-w.png)

![](https://cdn-images-1.medium.com/max/1024/1*ugu56a5HtxKP19oOPIo3rg.png)

**Erdős–Rényi notes:**

- The interconnected nature of the ER graph makes it **among the most amenable network structure**  **to each of our solidarity strategies**
- Unfortunately, it is also considered **among the least empirically accurate with regard to real-world networks**
- In a recurring theme, the **Barbell Strategy performs best** on this graph

#### Barabási–Albert

_Baseline simulation & reference graphs, followed by strategy simulations:_

![](https://cdn-images-1.medium.com/max/800/1*WO9RP7dMSlaHE5f-6XxPaA.gif)

![](https://cdn-images-1.medium.com/max/1022/1*asr88czCvAh0xU2MqZrB1Q.png)

![](https://cdn-images-1.medium.com/max/1024/1*dElNjnLPFChry3w3_GlRjQ.png)

![](https://cdn-images-1.medium.com/max/800/1*kl54VpghR1S0cW08PrpY8g.gif)

![](https://cdn-images-1.medium.com/max/800/1*mNUBVM5_aam0AtPQfLLhZA.gif)

![](https://cdn-images-1.medium.com/max/800/1*ciukTKBS7wU03oIoL1xSMA.gif)

![](https://cdn-images-1.medium.com/max/1022/1*oBa7KT4E3zCU5j9cLiOyvg.png)

![](https://cdn-images-1.medium.com/max/1022/1*WA57hz2tIKRIfqJiTEFYPw.png)

![](https://cdn-images-1.medium.com/max/1024/1*JrQQp5UN6jc040UZq3eyJg.png)

**Barabási–Albert notes:**

- The _scale-free_ nature of the BA graph (power-law degree distribution) puts it somewhere between our other two graphs in terms of connectedness, which results in a similar **middling effectiveness for our strategies**.
- While [disputed](https://www.nature.com/articles/s41467-019-09038-8), many real world networks appear to at least [resemble power-law](https://projecteuclid.org/journals/internet-mathematics/volume-1/issue-2/A-Brief-History-of-Generative-Models-for-Power-Law-and/im/1089229510.full) dynamics, making it an especially empirically useful model
- Again, **Barbell outperforms**

#### Watts–Strogatz (small world)

_Baseline simulation & reference graphs, followed by strategy simulations:_

![](https://cdn-images-1.medium.com/max/800/1*HK21ILJjrbqr05RIw2Wkkw.gif)

![](https://cdn-images-1.medium.com/max/1022/1*zBvB5U16PtJnYHmBXcA4vg.png)

![](https://cdn-images-1.medium.com/max/1024/1*dElNjnLPFChry3w3_GlRjQ.png)

![](https://cdn-images-1.medium.com/max/800/1*2_m82n1-3nRRxjUYI2JFsA.gif)

![](https://cdn-images-1.medium.com/max/800/1*jDjYJ7WBdLjiBe1HT1Zfzg.gif)

![](https://cdn-images-1.medium.com/max/800/1*uadLFuPW3bbR7hjkBlcjXw.gif)

![](https://cdn-images-1.medium.com/max/1022/1*RSzpwdl_pvdmlS6lIhBk9Q.png)

![](https://cdn-images-1.medium.com/max/1022/1*3sMR2-SyU8IDGPnvZza4nQ.png)

![](https://cdn-images-1.medium.com/max/1024/1*TMF9gDFnEhzkXv0Gp5P7RQ.png)

**Watts–Strogatz (small world) notes:**

- The **segregated nature** of small-world ‘neighborhoods’ (clusters of nodes with short-path connections within but few connections between clusters) **present challenges for most of our network strategies** , as resource flows become concentrated among few clusters & bottlenecked across the graph
- While this graph’s **overall connectedness** (e.g. thin-tailed Poisson degree-distribution) appears to be [**less common in real networks**](http://networksciencebook.com/chapter/3#summary3), the [**small-world**](https://en.wikipedia.org/wiki/Small-world_network) **property has been observed in many real-world social networks** , & we should beware of the **impact of similar parochial dynamics on solidarity & equity efforts**.
- _— (so membership in, or bridge-building between, multiple_ [_memetic tribes_](https://github.com/TheExGenesis/memetic_tribes) _might truly be god’s work)_
- Once again, even the aforementioned constraints are overcome by the **Barbell Strategy**

### (Tentative) Conclusion & Future Directions

![](https://cdn-images-1.medium.com/max/1024/1*rsErWJz4BngVUUcywdMj-g.png)

We set out to do some initial quantitative tinkering around scaling dynamics for ethical actions, exploring tensions between ‘localist’ & ‘globalist’ orientations & some candidate strategies to navigate those tensions:

1. **Fractal** : doing the same thing at all scales (roughly)
2. **Barbell** : e.g. 80–20 split of local & global ‘investments’
3. **Memelord** : a memetic vanguard of core actors, & peripheral propagation thru the system

Our initial simulations, while not aiming for realism or empirical precision, demonstrated some potential strategies & their effectiveness across different basic network topologies.

**Two salient provisional observations:**

1. **Network structures** which result in similar dynamics & outcomes under a baseline simulation, nonetheless appear to **differentially impact the effectiveness of proposed solidarity strategies.**   
 — The most impactful characteristics appear related to **connectedness & the nature of connection formation** (e.g. degree distribution & hub dependence)
2. A **Barbell Strategy** (80–20 split of local & global activity) appeared to be the **most robust & invariant to network-specific constraints** affecting other strategies.   
 — Intuitively, even **simple, relatively small global efforts easily scaled to overcome the local choke-points, bottlenecks & parochialism** that constrained the other single-path, less diversified strategies

Still, this was a very preliminary investigation into emergent dynamics in toy mechanistic models. Network science is a young but deep field & I’ve only scratched the surface here, not to mention the intersections with Complex Systems theory, agent-based modeling, etc.

#### Future Directions

In addition to related clusters of research questions mentioned in the [**Motivation**](https://dnlmc.medium.com/barbells-fractals-memelords-scaling-strategies-for-ethical-action-cca9a868b8a1#bcda) section above, there are several obvious directions for future iterations & refinements:

_(Also appreciate any feedback, commentary or suggestions)_

- More realistic, empirically-driven network models & dynamics
- More sophisticated implementation of conceptual strategies (as well as new qualitative strategies, & interactions beyond ‘resource’ exchange )
- Dynamic evolution of network structures (e.g. temporal dynamics in graph size, connections & edge weights, also responsive to stochastic strategies)  
_ — (Tyson Yunkaporta_ [_mentioned somewhere_](https://anchor.fm/tyson-yunkaporta)_: representing_ the land _as an agent in agent-based model simulation)_
- Larger networks & scaling structures, & many more stochastic simulation runs with ensembled results
- More formal mathematical descriptions & [measures](https://transportgeography.org/contents/methods/graph-theory-measures-indices)
- Codebase refactoring & optimization

Until then, let’s keep working towards _the feedback loop where the good gets better._

_Find all the code used in this post in_ [**_this repo_**](https://github.com/dnlmc/bfm)

_See the Roam version of this post for a full reference / resource list _[**_here_**](https://roamresearch.com/#/app/dnlmc_public/page/1twp6v3Dm)

_Thanks for reading,_ [_follow me_](https://medium.com/@dnlmc) _&_ [_check out my other posts_](https://medium.com/@dnlmc)_. Also, please comment with thoughts, suggestions or corrections!_

—   
Follow on twitter: [@dnlmc](https://www.twitter.com/dnlmc)  
LinkedIn: [linkedin.com/in/dnlmc](http://www.linkedin.com/in/dnlmc)  
Github: [https://github.com/dnlmc](https://github.com/dnlmc)

 ![](https://medium.com/_/stat?event=post.clientViewed&referrerSource=full_rss&postId=cca9a868b8a1)
* * *

[Barbells, Fractals & Memelords: Scaling Strategies for Ethical Action](https://medium.com/coemeta/barbells-fractals-memelords-scaling-strategies-for-ethical-action-cca9a868b8a1) was originally published in [Coεmeta](https://medium.com/coemeta) on Medium, where people are continuing the conversation by highlighting and responding to this story.

