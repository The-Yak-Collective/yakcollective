---
title: From Information to Action with Quantitative Decision Science
date: 2020-01-01 23:40:42.000000000 Z
layout: post-external
original_link: https://medium.com/coemeta/from-information-to-action-with-quantitative-decision-science-9752b6c969d5?source=rss-2d441c4de574------2
author: 101274
---

#### [Trust the Process, Doubt the Procedure](http://towardsdatascience.com/tagged/ttp-dtp)

#### Decision theory & NBA playoff strategy

> This is a parable about simple, straightforward questions of fact, & how they often devolve into complex matters of data processing, analysis & decision-making under fragile epistemic limits, in the real world.

> It uses NBA data as a toy framing device to explore more complex data science concepts & techniques. Obviously, this is not remotely how actual NBA strategy or analytics works.

> (This is **Part 4 of 4** , exploring decision theoretic approaches.   
> [**Parts 1**](https://towardsdatascience.com/probability-will-only-break-your-heart-or-trust-the-process-doubt-the-procedure-nba-playoff-aff8e01936ad?source=friends_link&sk=e3f810d248637fbdd6dfaebed58383e0) ** ,** [**2**](https://towardsdatascience.com/trust-the-process-doubt-the-procedure-nba-playoff-win-chances-379ad92e20a0?source=post_page---------------------------&sk=867f3c54c4e3d2f26beb1f1f90df8ac4) **&** [**3**](https://towardsdatascience.com/nba-playoff-win-chances-via-bayesian-inference-83a6595fb95f?source=friends_link&sk=7f000033a2c217792b5ae1abbc048f7e) are summarized in the brief recap below.   
> Each post stands on its own. )

### Run it Back: The Threepeat (Parts 1–3 recap)

**_Wagers, Probability, Data Wrangling & Frequentist vs Bayesian Inference_**

![](https://cdn-images-1.medium.com/max/1024/0*jchAP15OleJrZq8Z.jpg)
_via clutchpoints_

In [**Part 1**](https://towardsdatascience.com/probability-will-only-break-your-heart-or-trust-the-process-doubt-the-procedure-nba-playoff-aff8e01936ad?source=friends_link&sk=e3f810d248637fbdd6dfaebed58383e0), I described a bet between myself & my friend / colleague [Nat](https://twitter.com/Natsbballstats), in which he asserted that _away teams in NBA Playoff series are_ **_more likely to win the series_** _if they_ **_WIN & THEN LOSE_** _the first two away games, than if they split the first two games in the opposite order_, despite an identical series score heading into game 3. I demurred, sensing a [**_gambler’s fallacy_**](https://en.wikipedia.org/wiki/Gambler%27s_fallacy) at play:

![](https://cdn-images-1.medium.com/max/1024/0*e6t_2xp1CUjZyOoZ.png)

I go on to describe my reasoning & the fundamental probability theory underlying it, which I won’t repeat here.

I also describe the semi-complex data collection & processing required to address the question at hand, utilizing 538’s excellent [Historical NBA Elo](https://github.com/fivethirtyeight/data/tree/master/nba-elo) dataset ([CC BY license](https://creativecommons.org/licenses/by/4.0/)), then surfaced the results & initial summary statistics in an interactive Data Studio [dashboard](https://datastudio.google.com/s/kpmnyARYjj0), reproduced below (with default filters set to conditions best suited to the original wager, under modern NBA Playoff rules — post-2002).

[https://medium.com/media/ec26ab4725d1e285b32df95acdda4632/href](https://medium.com/media/ec26ab4725d1e285b32df95acdda4632/href)

As can be seen, between 2003–2015, over 84 playoff series, away teams splitting the first 2 games of the series had **essentially the same win %** , _regardless of the order of the win & loss_ (39.1% to 39.5%).

I was tempted to declare victory here, but decided to try to salvage the 1984–2002 _best of 7_ playoff series to increase the sample size. You can see for yourself by adjusting the filters above, but here’s the topline results:

![](https://cdn-images-1.medium.com/max/1024/0*DgClSylvLtZPzq5g.png)

Now things get a bit muddled. At a sample size of 134 total series, the **_win-then-lose_** segment has pulled into a 43% to 36% advantage, all of which accrued between 1984–2002 (since we’ve already seen it was tied since 2002):

![](https://cdn-images-1.medium.com/max/1024/0*ZOG_s0IFJhPq_dkh.png)
_Between 1984–2002, the first round of NBA Playoffs were best of 5 series, which are excluded here & thus explains some of the lower incidence of series beginning with split results over that period. (The first round is also by nature the round with the most total series in play, & thus results in the most series lost from our sample by excluding it)._

**But is this advantage _real_? Or simply expected random fluctuation around otherwise equal winning chances?**

This sounds like a question about **_statistical significance_** , but, as you might have heard, [scientists are rising up against it](https://www.nature.com/articles/d41586-019-00857-9), as the (mostly Bayesian) [statisticians](https://www.nature.com/news/scientific-method-statistical-errors-1.14700) [have](https://statmodeling.stat.columbia.edu/2016/05/25/the-difference-between-significant-and-not-significant-is-not-itself-statistically-significant-education-edition/) [long](https://statmodeling.stat.columbia.edu/2015/03/02/what-hypothesis-testing-is-all-about-hint-its-not-what-you-think/) [advocated](https://statmodeling.stat.columbia.edu/2017/09/26/abandon-statistical-significance/).

In [**Part 2**](https://towardsdatascience.com/trust-the-process-doubt-the-procedure-nba-playoff-win-chances-379ad92e20a0?source=post_page---------------------------&sk=867f3c54c4e3d2f26beb1f1f90df8ac4) I explored why, showing how traditional frequentist statistical tests unanimously support my side of the bet, but suffer from chronic issues of hidden assumptions, misunderstanding & mechanical misapplication.

![](https://cdn-images-1.medium.com/max/966/0*eqNjjx0pcgm4_GPU.png)
_via xkcd_

Cool cool. Traditional so-called [**_Null Hypothesis Significance Testing_**](https://www.fharrell.com/post/nhst-never/) (NHST) is on the outs, but surely the Bayesian alternatives (explored in [Part 3](https://towardsdatascience.com/nba-playoff-win-chances-via-bayesian-inference-83a6595fb95f?source=friends_link&sk=7f000033a2c217792b5ae1abbc048f7e)) will save us?

![](https://cdn-images-1.medium.com/max/1024/0*HNXVnjOzQ4Ikn6GN.png)

…[oh](https://statmodeling.stat.columbia.edu/2011/04/02/so-called_bayes/)…oh no.

Well then.

How to proceed?

**Bets must be settled. Decisions must be made. Science must advance.**

Enter the hairy field of [**_decision science_**](https://chds.hsph.harvard.edu/approaches/what-is-decision-science/) **_/_** [**_theory_**](https://en.wikipedia.org/wiki/Decision_theory#Choice_under_uncertainty) **_/_** [**_analysis_**](https://en.wikipedia.org/wiki/Decision_analysis) **_._**

> This post will introduce the basic elements of quantitative decision science, then demonstrate what a very basic application might look like, given our question of interest. We’ll then suggest directions & resources for further investigation.

### Intro to Decision {Science, Theory, Analysis}

![](https://cdn-images-1.medium.com/max/1024/0*7W_yeV-3GPtwOYdc.jpg)
_via clutchpoints_

#### Action vs Understanding

Statistics & data analysis help us make sense of information, to **_learn_** from it. This is often _passive_ learning, for the purpose of advancing scientific understanding or calibrating our own beliefs (_…or settling bets_). But sometimes we’re interested in more than passive, academic learning: we must make a **_decision_** _&_ drive some **_action_**. As alluded to above, this is the province of [**decision science**](https://chds.hsph.harvard.edu/approaches/what-is-decision-science/) (variously termed [**decision theory**](https://en.wikipedia.org/wiki/Decision_theory#Choice_under_uncertainty) or [**decision analysis**](https://en.wikipedia.org/wiki/Decision_analysis)).

#### Descriptive vs Prescriptive

> Decision science / theory can be broadly described as “_the study of decision-making”_.

… It has both **_descriptive_** & **_prescriptive_** approaches.

**_Descriptive_** decision science is primarily a philosophical & psychological field of social science, studying how decisions are made **in practice**.

**_Prescriptive_** decision science (often called _decision analysis_), aims to provide a principled (usually quantitative) framework for **optimal** decision-making given some objectives, constraints & available information. It attempts to capture the universe of possible decisions & outcomes, then evaluates the consequences of each decision-outcome combination. The decision / action with the optimal estimated consequences, given potential outcomes & objectives, is then chosen.

#### Approaches

Decision science has a long history with diverse applications across many disciplines: from **statistics** to [**operations research**](https://en.wikipedia.org/wiki/Operations_research) / [**management science**](https://en.wikipedia.org/wiki/Management_science) / [**decision support**](https://en.wikipedia.org/wiki/Decision_support_system) to [**game theory**](https://en.wikipedia.org/wiki/Game_theory), **economics,**  **finance** & **risk management** to **machine learning** , etc.

Its various approaches are again complicated by divergent ([though reconcilable](https://www.youtube.com/watch?v=b1GxZdFN6cY)) [**frequentist** & **Bayesian**](https://www.cse.wustl.edu/~garnett/cse515t/spring_2015/files/lecture_notes/3.pdf) methods, as well as alternate approaches inspired by [heuristics](https://en.wikipedia.org/wiki/Fast-and-frugal_trees) as well as [machine learning](https://en.wikipedia.org/wiki/Decision_tree_learning).

Alternate approaches also exist for probabilistic & non-probabilistic scenarios, as well as scenarios with & without empirical data.

We’ll largely avoid these complications by adopting as generic a framework as possible, but see the “further reading” section at the bottom of this piece to go deeper.

#### Procedural framework

As mentioned above, a typical decision analysis proceeds as follows:

1. Specify possible **decisions / actions**
2. Specify potential **outcomes**
3. Quantify **consequences** of possible action / outcome combinations   
_(sometimes requires estimation from data, as well as specifying_ [_loss_](https://en.wikipedia.org/wiki/Loss_function) _/_ [_cost_](https://en.wikipedia.org/wiki/Cost_function) _/_ [_utility_](https://en.wikipedia.org/wiki/Utility#Utility_function) _/_ [_objective_](https://en.wikipedia.org/wiki/Mathematical_optimization) _functions)_
4. Specify & apply an appropriate [**decision criterion**](https://people.richland.edu/james/summer02/m160/decision.html) or “[rule](https://en.wikipedia.org/wiki/Decision_rule)”, given particular context, risk tolerance, etc

> If parts of this sound eerily similar to traditional statistics, [optimization](https://en.wikipedia.org/wiki/Mathematical_optimization) & machine learning approaches, there’s a good reason: many of the same techniques apply.

> The main distinction here is the **explicit evaluation of multiple possible decisions / actions** , as well as an **explicit choice of a decision rule** , which provides a deliberate, logical basis for choosing between different actions & their estimated consequences.

Let’s make this more concrete by applying this framework to our original wager.

### Decision Analysis Example: NBA Playoff Strategy

> (To reiterate the disclaimer from the beginning of this piece: what follows is, obviously, not remotely how actual NBA strategy or analytics works.)

So far in this series we’ve been discussing our wager & question of interest as a matter of _fact_ or _belief_. We’ve seen how various applications of **frequentist** & **Bayesian** statistical hypothesis testing provided varying, unsatisfying & ultimately inconclusive findings.

Such is often the world of academic pondering. But what if we treated our question as a concrete, real world problem? What if some **_decision_** had to be made & a corresponding **_action_** taken, with actual consequences to follow? This moves us beyond mere hypothesis testing, into the world of decision science.

#### NBA Eastern Conference semi-finals: Game 3 approaches

![](https://cdn-images-1.medium.com/max/775/0*KYihMXhwEG4CWiiU.jpg)
_Brett Brown, via wip_

In order to translate our original wager into a matter of decision analysis, let’s put ourselves in the shoes of our heroes’ head coach, Brett Brown, in the scenario that gave rise to our initial wager: having _lost then won_ the first 2 away games of a best-of-7 playoff series.

One assistant coach, we’ll call him _Coach Nat_, is in our ear lamenting the fact that if we’d only split the first 2 games in the reverse order, we’d be more likely to win the series. _Thus_ **_we should undertake a shift in strategy to alter these odds_** _._

Another (far handsomer & more modest) assistant coach disagrees, saying we should **stay our current course** , because our odds should be the same either way. **_Switching strategies now means we’ll expend needless effort & lose the chance to double down on a strategy that has produced a desirable outcome already_** : having won 1 out of 2 initial away games, restoring home court advantage to ourselves.

Whose advice do we follow?

Being the empirical-minded bearers of [Hinkie’s legacy](https://www.si.com/nba/2016/11/30/sam-hinkie-after-the-process-philadelphia-76ers) that we are, we summon our analytics nerd staff to help settle the question. Following the simplified decision analytic framework above, they lay out the following:

1. Specify possible **decisions / actions**  
 —  **decision\_c** = change in strategy   
 —  **decision\_n** = no change in strategy
2. Specify potential **outcomes**   
 —  **outcome\_w** = win the series  
 —  **outcome\_l** = lose the series
3. Quantify **consequences** of possible action / outcome combinations   
_(sometimes requires estimation from data, as well as specifying_ [_loss_](https://en.wikipedia.org/wiki/Loss_function) _/_ [_cost_](https://en.wikipedia.org/wiki/Cost_function) _/_ [_utility_](https://en.wikipedia.org/wiki/Utility#Utility_function) _/_ [_objective_](https://en.wikipedia.org/wiki/Mathematical_optimization) _functions)  
 — _ …here’s where art meets science…

#### Expected value & base rates

![](https://cdn-images-1.medium.com/max/1000/0*zj53j2f1ANJKKiYJ)
_via Julian Hochgesang on Unsplash_

Assuming we trust the historical record since 1984, we can establish our [base rates](https://en.wikipedia.org/wiki/Base_rate) of expected success. As we’ve repeatedly noted, away teams that _lose then win_ (L\_W) have a 36% historical win rate, while _win then lose_ (W\_L) teams have a 43% win rate.

This data allows us to set some initial [expected value](https://en.wikipedia.org/wiki/Expected_value) baselines for success, per basic probability theory.

In our scenario, our outcome is binary (win or lose the series), which we can value as win = 1 & lose = 0. (A quintessential [zero-sum game](https://en.wikipedia.org/wiki/Zero-sum_game)).

**_Expected value_** is simply defined as the value of an outcome, weighted by its probability of occurring:

> _𝔼[__outcome\_w|__ L\_W] =_ _outcome\_w \* 𝐏( __outcome\_w|__ L\_W) =_ _1 \* .36 = __.36_

> _𝔼[__outcome\_l|__ L\_W] =_ _outcome\_l \* 𝐏( __outcome\_l|__ L\_W) =_ _0 \* .64 = __0_

All we’ve done here is define the expected value (𝔼) as the value of a series win or loss (1 or 0) multiplied by its probability of occurring (aka historical win rate), given that fact that we _lost then won_ the first 2 games (L\_W).

Notice that the _expected value_ of winning the series is simply equal to the _probability_ of winning it, since the total value of a series win = 1, and 1 \* x = x. Similarly, the value of a series loss = 0, & 0 \* x = 0. If we had outcomes with non-binary values (e.g. point differentials or expected wins), things would be different. As it is, we can simplify this all:

> _𝔼[__outcome\_w|__ L\_W] = 𝐏( __outcome\_w|__ L\_W) = __.36_

> _𝔼[__outcome\_l|__ L\_W] =_ _outcome\_l = __0_

For Coach Nat’s sake, we can also compute the expected value of a W\_L team in our situation:

> _𝔼[__outcome\_w|__ W\_L] = 𝐏( __outcome\_w|__ W\_L) = __.43_

> _𝔼[__outcome\_l|__ W\_L] =_ _outcome\_l = __0_

So far we haven’t discovered much more than we already knew: given historical data, we have an estimated 36% chance of winning the series, while we’d have a 43% chance if we split the first 2 games in the reverse order.

So what do we  **_do_**?

#### Actions & Cost functions

![](https://cdn-images-1.medium.com/max/1000/0*QRaKnW8LLxZI5xOL)
_via Scott Webb on Unsplash_

To answer that, we have to quantify some assumptions about our possible decisions / actions (change strategy or not), & how those decisions will interact with the base rates above to produce ultimate consequences, given potential outcomes (win or lose the series). We call this sort of quantification a “cost” function (among [other things](https://en.wikipedia.org/wiki/Loss_function)).

Recall our potential actions:  
— **decision\_c** = change in strategy   
 —  **decision\_n** = no change in strategy

…And also remember that this is the _real world_, where actions are not free but require effort, incur some costs, & prevent us from taking other contrary actions.

For instance, if we decide to change our game strategy mid-series, we can’t simply flip a switch & execute a different strategy. Rather, we need to _learn_ the new strategy, _practice_ it, & _unlearn_ our old strategy. These things all have costs.

We can define such **_costs_** in conventional economic lingo as:

- [**switching costs**](https://en.wikipedia.org/wiki/Switching_barriers): _the time & effort (i.e. practice, study) required to change from one strategy to another_
- [**opportunity costs**](https://en.wikipedia.org/wiki/Opportunity_cost): since we’re now spending time & effort on switching, _we also incur the cost of what we might have done with this time & effort instead_, such as reinforcing an existing strategy that had some success & would require less effort than switching, or using that time to rest & recover, etc

So we might define a simple cost function (𝒞) of a decision as follows:

> _𝒞(__decision,_ _s,_ _o) =_ _decision \* (s + o)_

where: s = the switching cost & o = the opportunity cost.

This simply specifies that the cost of a given action is the sum of the costs, multiplied (i.e. scaled) by the decision.

Then we must give them values.

So let:

> _decision\_c =_ _1 (since an action is taken, this will activate the cost function)_  
> _decision\_n =_ _0 (no action, negates the cost associated with the action)_

> _s = __.05 (the switching cost, to be applied to the expected value)_  
> _o = __.05 (the opportunity cost, to be applied to the expected value)_

This would result in the following costs:

> _𝒞(__decision\_c,_ _s,_ _o) =_ _decision\_c \* (s + o) =_ _1 \* (.05 + .05) = __.1  
> 𝒞(_ _decision\_n,_ _s,_ _o) =_ _decision\_n \* (s + o) =_ _0 \* (.05 + .05) = __0_

But this isn’t quite fair, since the _change_ decision incurs only _costs_ but no _benefits_. In reality, we (read: Coach Nat) might conjecture that a change of strategy will have the intended benefit of swapping the L\_W base rate win % for the W\_L win %, at the price of _switching_ & _opportunity_ costs.

So then our cost function would become:

> _𝒞 =_ _decision\_c \* (s + o — [𝐏(outcome\_w | W\_L) — 𝐏(outcome\_w | L\_W)])_

This looks gnarly, but just simply takes the difference in W\_L & L\_W win probabilities, then subtracts it from the other costs, as an offsetting benefit.

Plugging in our values gives:

> _𝒞(__decision\_c,_ _s,_ _o) =_ _1 \* (.05 + .05 — [.43 — .36]) = __.1 — .07 = __.03_

And since we already know that decision\_n = 0 & negates the rest of the cost function, we can just compare costs:

> _𝒞(__decision\_c,_ _s,_ _o) = __.03  
> 𝒞(_ _decision\_n,_ _s,_ _o) = __0_

Thus _the total estimated_ **_cost_** _of the decision to_ **_change strategies_** _is_ **_greater_** _than the_ **_cost_** _of_ **_staying the course_** _._

You can probably see where this is going, but recall that we’re still on step 3 out of 4. So we’ll bring it all home in the final step for completeness:

> _4. Specify & apply an appropriate_ [**_decision criterion_**](https://people.richland.edu/james/summer02/m160/decision.html) _/_ [_rule_](https://en.wikipedia.org/wiki/Decision_rule)_, given particular context, risk tolerance, etc_

As we’ve seen, this sort of probabilistic decision analysis enables the use of _expected value_ estimates for each action taken, which implies an especially simple & straightforward decision rule: **choose the option with the greatest expected value.**

We haven’t yet incorporated our cost function from step 3 into our expected values, so let’s do that now:

> _𝔼[__L\_W |_ _decision\_c] = 𝐏(__outcome\_w |_ _L\_W) __— 𝒞(__decision\_c,_ _s, __o)_

This is the **expected value of a**  **L\_W team** given that they decide to change strategies, which we arrive at by subtracting the cost function from the base rate win probability.

Plugging in values from above gives:

> _𝔼[__L\_W |_ _decision\_c] = __.36 — .03 = __.33_

Doing the same for our decision to make “no change”:

> _𝔼[__L\_W |_ _decision\_n] = __.36 – 0= __.36_

Thus, 𝔼[L\_W | decision\_n] \> 𝔼[L\_W | decision\_c]

...or “no change” gives a greater expected win % than the “change” decision, thus **the expected value decision rule compels us to choose “no change”**.

#### Evaluating multiple “states of nature”

![](https://cdn-images-1.medium.com/max/1000/0*UOfne5s5FeyI92Fn)
_via João Silas on Unsplash_

The preceding analysis might strike you as little more than a simple [cost-benefit analysis](https://en.wikipedia.org/wiki/Cost%E2%80%93benefit_analysis) (CBA), where probabilistic _expected value_ is substituted for traditional monetary value. You would be correct, in that CBA can be thought of as a special case of decision analysis. But decision theoretic frameworks provide a much richer extension of this sort of evaluation, through the inclusion of probability theory, alternate decision rules, flexible cost functions & consideration of multiple outcomes or **_states of nature_**.

Referring to outcomes as **_states of nature_** evokes the fact that these outcomes are typically beyond our control, or at least cannot be perfectly predicted. Explicit inclusion of _states of nature_ in our decision framework **forces us to consider the range of potential outcomes, & their potential impact on ultimate consequences**. This informs our decision-making, even influencing the decision rule we choose, contextualizing it all in terms of the larger _consequence-space_ we’re operating within.

**_How can we incorporate more states of nature into our analysis, for a richer result?_**

#### NBA states of nature

![](https://cdn-images-1.medium.com/max/1000/0*lJhYv1PRu1foqKt2)
_via Dave on Unsplash_

So far, we’ve only considered two outcomes:

> _—_ **_outcome\_w_** _= win the series  
>  — _ **_outcome\_l_** _= lose the series_

But we can approach these with greater granularity if we think one level deeper, in terms of what sub-outcomes affect these outcomes. An obvious option here would be the most direct cause of wins or losses: _total points scored_, or more specifically, the _point differential_. This is perhaps too granular for our purposes (but I invite readers to undertake this exercise, utilizing any version of the data made available in [**Part 1**](https://towardsdatascience.com/probability-will-only-break-your-heart-or-trust-the-process-doubt-the-procedure-nba-playoff-aff8e01936ad?source=friends_link&sk=e3f810d248637fbdd6dfaebed58383e0)).

A more appropriate level of abstraction might be our team’s **_quality of play_** , or how well the team _executes_ the strategy. This could be impacted by all sorts of factors, such as individual players’ physical health, mindstate, gym conditions, etc. All of which are not entirely within our control (otherwise we’d never see subpar play in the NBA). We might define 3 levels for our **_quality of play_** states of nature:

- below average play
- average play
- above average play

But how to quantify their expected values?

Recall that our previous expected value of a series win for L\_W teams simplified down to their historical win rate: 36%. We might naively or arbitrarily assume performance contributes +/- 5% around the average expected value, but we can be a bit more empirical than this by leveraging the estimation from our Bayesian models in [Part 3](https://towardsdatascience.com/nba-playoff-win-chances-via-bayesian-inference-83a6595fb95f?source=friends_link&sk=7f000033a2c217792b5ae1abbc048f7e).

Revisiting results from our application of an _informative prior_ to our data via the bayesAB package:

```
library(bayesAB)
```

```
# fit model
AB_strongprior <- bayesTest(w_l_wins, l_w_wins,
priors = c('alpha' = 12, 'beta' =17),
distribution = 'bernoulli')
```

```
# display summary output
summary(AB_strongprior)
```

```
# produce plots
plot(AB_strongprior)
```

Output:

```
Quantiles of posteriors for A and B:
```

```
$Probability
$Probability$A
0% 25% 50% 75% 100%
0.2270689 0.3930053 0.4264228 0.4609739 0.6679833
```

```
$Probability$B
0% 25% 50% 75% 100%
0.1842002 0.3410363 0.3739977 0.4076374 0.6115122
```

```
--------------------------------------------
```

```
P(A > B) by (0)%:
```

```
$Probability
[1] 0.77255
```

```
--------------------------------------------
```

```
Credible Interval on (A - B) / B for interval length(s) (0.9) :
```

```
$Probability
5% 95%
-0.1473586 0.5354154
```

```
--------------------------------------------
```

```
Posterior Expected Loss for choosing B over A:
```

```
$Probability
[1] 0.02552246
```

![](https://cdn-images-1.medium.com/max/1024/1*xGIXZjRzZ3cg2Dv4095U2Q.png)

![](https://cdn-images-1.medium.com/max/1024/1*1zHpgroYpegW6XJ1u6OBtQ.png)

![](https://cdn-images-1.medium.com/max/1024/1*d-Frrz0XFnDnpgWbbHTiAQ.png)

This model produced full posterior distributions around our sample historical win rates for W\_L (“A”) & L\_W (“B”) groups (see middle image above). The summary output also helpfully annotates the quartile thresholds of these distributions:

```
$Probability$A
0% 25% 50% 75% 100%
0.2270689 0.3930053 0.4264228 0.4609739 0.6679833
```

```
$Probability$B
0% 25% 50% 75% 100%
0.1842002 0.3410363 0.3739977 0.4076374 0.6115122
```

With this more empirical information, let’s define our _states of nature_ as follows:

- below average play = 1st quartile (𝑸_1_) aka 25th percentile
- average play = 2nd quartile (𝑸_2_) aka 50th percentile
- above average play = 3rd quartile (𝑸_3_) aka 75th percentile

This allows us to construct a **_payoff table_** , comparing the estimated win probability of each decision under different states of nature:

[https://medium.com/media/daa5cfb2bff0c2fedb2f783f4fd31a6a/href](https://medium.com/media/daa5cfb2bff0c2fedb2f783f4fd31a6a/href)

Extrapolating our cost function & plugging in values gives:

[https://medium.com/media/fa3e4fd5cc1ed5d51e1cf9381118d1b2/href](https://medium.com/media/fa3e4fd5cc1ed5d51e1cf9381118d1b2/href)

Since all **_No Change_** payoffs are higher than their **_Change_** counterpart under each state of nature, we aren’t left with a very interesting decision problem, as all imaginable rational decision rules would lead us to again choose the **_No Change_** decision. So I’m going to fudge some of these numbers for the sake of more meaningfully demonstrating alternate **_decision criteria_**.

#### Selecting a decision criterion under many states of nature

![](https://cdn-images-1.medium.com/max/1000/0*n-CYKlIAIyoYKoLk)
_via by Lena Bell on Unsplash_

Let’s pretend these are our payoffs:

[https://medium.com/media/66f03fc61fbcb360660f9e4cec4cc38c/href](https://medium.com/media/66f03fc61fbcb360660f9e4cec4cc38c/href)

This breakdown of win probabilities under different decision + outcome combinations paints a much murkier picture as to the “best” option. On the one hand, **_No Change_** contains the highest possible value, but on the other hand, there is less variance & a higher floor on the **_Change_**  side.

_Which is optimal?_ It depends on our risk tolerance, gambling disposition, etc.

These are encapsulated in so called **_decision criteria_** or **_decision rules_**.

At first blush, with monikers like **minimax** , **maximin** & **maximax** , the most common decision criteria can appear inscrutable (or indistinguishable). But they’re actually quite lucidly & logically named, once understood. They also help us **_explicitly consider, select & express a decision-making logic_** appropriate for our context.

Here’s a quick rundown, which we’ll make more concrete by applying to our data below:

- **Maximax** : Choose the decision which contains the **_maximum_** of all **_maximum_** payoffs across decision alternatives.   
(This is an **optimistic** strategy, which optimizes for the _best case_ scenario, ensuring maximum possible payoff if all goes well).
- **Maximin** : Choose the decision which contains the **_maximum_** of all **_minimum_** payoffs across decision alternatives.   
(This is a **pessimistic** , or risk-averse strategy, which optimizes for the _worst case_ scenario, ensuring the _best of the worst_ possible payoffs).
- **Minimax** : Choose the decision which contains the **_minimum_** of all **_maximum_** payoffs across decision alternatives.   
(This doesn’t actually make sense for payoffs, but as the inverse of the **maximin** criterion, is used as a **pessimistic** strategy when dealing with **losses** rather **payoffs** ).
- **Minimax Regret** : Choose the decision which contains the **_minimum_** of all **_maximum_**  **regrets** across decision alternatives. **_Regret_** or “opportunity loss” is defined as _the difference between a given payoff & the highest possible payoff for a given state of nature, if a different decision was made_.  
(This becomes clearer with a concrete example below, but is again a more **conservative** approach, optimizing for the decision whose maximum possible “regret” across all states of nature is the smallest).

This is a short list of non-deterministic or non-probabilistic decision criteria, because they do not attempt to account for the _likelihood_ of possible states of nature. (And there are [more](https://courses.cs.washington.edu/courses/cse573/12sp/lectures/25-decisiontheory.pdf)).

Once we bring in probabilities, we get into a richer world of **expected value** (as seen above), risk & **_perfect information_** , which we’ll also explore below.

So let’s see how they work.

#### Maximax

We’ll start with the optimist’s criterion, the  **maximax** :

> Choose the decision which contains the **_maximum_** of all **_maximum_** payoffs across decision alternatives. (This is an **optimistic** strategy, which optimizes for the best case scenario, ensuring maximum possible payoff if all goes well).

On our payoff table, this can be demonstrated like this:

![](https://cdn-images-1.medium.com/max/1024/1*oItIHIXpayPNHMl9sNTwXQ.png)

The maximum payoff under the **Change** decision is .37, while the maximum **No Change** payoff is .41. The **maximax** is the _maximum_ of these two _maximums_, or .41, which pertains to the **No Change** decision. So the **maximax** criterion would lead us to choose **No Change** to optimize for the largest possible payoff, or _best of the best_ scenarios.

#### Maximin

Now to the pessimist’s criterion, the  **maximin** :

> Choose the decision which contains the **_maximum_** of all **_minimum_** payoffs across decision alternatives.   
> (This is a **pessimistic** , or risk-averse strategy, which optimizes for the worst case scenario, ensuring the _best of the worst_ possible payoffs).

![](https://cdn-images-1.medium.com/max/1024/1*vw1sctYcJy2ckb4s95is8Q.png)

The minimum **Change** payoff is .35, while the minimum **No Change** payoff is .34. The **maximin** is the _maximum_ of these two _minimums_, or .35, which pertains to the **Change** decision. So the **maximin** criterion would lead us to choose **Change** to optimize for the largest minimum payoff, or the _best of the worst_ scenarios.

#### Minimax Regret

As mentioned above, the **minimax** criterion only applies to losses, & as such is the counterpart to **maximin** for rewards (seen immediately above). So we move on to a slightly different sort of criterion, the **minimax regret** :

> Choose the decision which contains the **_minimum_** of all **_maximum_**  **regrets** across decision alternatives. **_Regret_** or “opportunity loss” is defined as _the difference between a given payoff & the highest possible payoff for a given state of nature, if a different decision was made_.  
> (This is again a **conservative** approach (at least psychologically), optimizing for the decision whose maximum possible “regret” across all states of nature is the smallest).

![](https://cdn-images-1.medium.com/max/1024/1*waZGBV66k6mcw4wDibp6_A.png)

There’s a bit more going here, since we have to first compute the **regrets** , then choose the **maximum** of the **minimums**. So one step at a time:

1. The **regret** is _the difference between a given payoff & the highest possible payoff for a given state of nature, if a different decision was made_. This is represented in the blue boxes. For instance, within the **Below Avg** state of nature (first row), there is **no regret** associated with the **Change** decision, because it is the highest possible payoff across decisions. But if we chose **No Change** within that state of nature, we’d experience a regret of .01, because its payoff is .34, but we could have a payoff of .35 if we chose **Change**. We perform this calculation for each row.
2. Next we find the **maximum** regret within each decision (red boxes). We see that the **Change** decision has a **maximum regret** of .04, while **No Change** has a **maximum regret** of .01.
3. We then choose the **minimum** among these **maximum**  **regrets** , to limit the maximum regret we can feel, given our decision. That leads us to choose the **No Change** decision, with a **maximum regret** of .01 vs .04 for  **Change**.

That’s it for our basic _non-probabilistic_ decision criteria, but what if we brought in probability for finer grain estimation?

#### Expected Value

We’ve already seen a basic application of the **expected value** criterion in our initial demo analysis with only one state of nature (technically there were two: “winning” & “losing” the series, but since losing brought a value of 0, it negated itself).

If we want to apply expected value to our current framing with multiple states of nature, the first thing we have to do is assign probabilities to each state. In lieu of a more empirical approach, we might reason: this is the playoffs & our team is healthy, we know they are disciplined & motivated enough to give their full efforts for the rest of the series, thus a **_below average_** performance should be less likely than an **_average_** or **_above average_** showing. So we arrive at these probabilities:

- **below average** : 20%
- **average** : 40%
- **above average** : 40%

We can now compute **expected values** for each decision, across states of nature, which is simply the mean weighted by probabilities:

[https://medium.com/media/c83ab71b99e6707aa16f6c8e252a3863/href](https://medium.com/media/c83ab71b99e6707aa16f6c8e252a3863/href)

So the E.V. of our **Change** decision is simply:   
(.35 \* 0.2)+(.36 \* 0.4)+(.37 \* 0.4) = .36

The **expected value** criterion requires us to simply choose the decision with the greatest value, which is **No Change** here (.38 vs .36).

#### Expected Value of Perfect Information

In all our action-oriented decision-making mania, as good empiricists we should never lose sight of one ever-present (if under-utilized) option: to collect more information for an even better decision.

There are many [principled approaches](https://forum.effectivealtruism.org/posts/8w2hNT5WtDMzoaGuy/when-to-find-more-information-a-short-explanation) to this decision, but the application of **expected value** leads naturally to one in particular, encapsulated by the (frankly, \*chef’s kiss\*) phrase: the **_expected value of perfect information_** ( **EVPI** )_._

We’re already familiar with the **expected value** part, so what is **_perfect information_**?

Somewhat related to the concept of **regret** , **_perfect information_** simply implies the decision we would make for each state of nature, if we knew _perfectly_ that it would occur. In other words, it is simply _the decision with the greatest payoff_ (i.e. no **regret** ) _in each state of nature_.

We can then take the expected value of those decisions under perfect information, which gives the **expected value _with_ perfect information** , from which we can determine the **expected value _of_ perfect information:**

[https://medium.com/media/b68c82bd6a302917a0180f0a180329e0/href](https://medium.com/media/b68c82bd6a302917a0180f0a180329e0/href)

So here the **EV w/ PI** is .382. This is essentially the payoff we’d expect if we always chose perfectly, regardless which state of nature occurred. We can treat this as the _upper bound of expected value_, given an uncertain future in which we choose correctly every time.

We can then use this to determine **how much additional information is worth to us** , by finding the difference between this E.V. under perfect conditions (.382) & our original E.V. _without_ perfect information (.38):

> .382 — .38 = .002

So our **EVPI** is .2%.

**Notice what this is saying** : we know the best we can do with perfect information is .382, this is our E.V. ceiling, given uncertain states of nature occurring with the specified probabilities. We also know that the expected value criterion already advised us to choose **No Change** , which carries an expected value of .38. This is our E.V. baseline. So the EVPI is simply the difference between this baseline & the ceiling. In other words: **_what would we gain from perfect information?_**

This gives us a rational basis to decide whether collecting more information is worth it. In this case, **the absolute best that more information can provide to us (given our conditions) is**  **+ .2% in additional win probability**. So, _in practice_, more information will almost always get us less than that, as perfect information rarely exists in the real world.

#### Decision Criterion recap

Let’s round up our various decision determinations across criteria:

- **Maximax** (optimistic): choose **No Change**
- **Maximin** (pessimistic): choose  **Change**
- **Minimax regret** (opportunistic/conservative): choose **No Change**
- **Expected Value** (realistic): choose **No Change**
- **Expected Value of Perfect Info** : gain _at most_ .2% with more info

(Of course, given our example, we shouldn’t take any of these too seriously, since the info was mostly made up!)

### Part 4 Conclusion, Qualifications & Addendums

![](https://cdn-images-1.medium.com/max/1024/0*8SSnST2m5yIRfDtx.jpg)
_via clutchpoints_

This was an oversimplified demonstration of a **decision analytic approach** to what had previously been cast as a more academic matter. My hope was to show how **this approach can help frame, concretize & rationalize** “simple questions of fact” that devolve into much more complex matters, **especially those which require a decision be made** , with real consequences to follow.

That said, this post barely scratched the surface, & the following qualifications & possible further directions must be noted:

- Clearly, assuming a different cost structure would likely lead to different ‘optimal’ decisions
- We might attempt to learn cost functions or state of nature probabilities more empirically, looking to the historical record for clues
- We might add more nuanced decision options, e.g. a “partial strategic shift”, which cuts the costs in half but also shrinks the benefit. Or else a continuous “shift” range (between 0–1), with proportionate costs & benefits, etc.
- I glossed over & fudged many details of decision theoretic frameworks & probability machinations, given the triviality of our toy example & for the sake of concision & a desperate attempt at clarity. See the **further resources** section below for deeper accounts.

### 🎬 🎬 🎬 Series Conclusion 🎬 🎬 🎬

The title of this series is: [**Trust the Process, Doubt the Procedure**](https://towardsdatascience.com/tagged/ttp-dtp). This is both an [allusion to our protagonists](https://bleacherreport.com/articles/2729018-the-definitive-history-of-trust-the-process) as well as an overarching theme & mantra for sound empirical work, imo.

The **_Process_** is the scientific method, broadly & robustly construed. **_Procedures_** are narrow, usually fragile applications or approaches to (a piece of) that process.

Understood this way, we _must_ doubt our procedures, if we are to truly trust the process.

- In [**Part 1**](https://towardsdatascience.com/probability-will-only-break-your-heart-or-trust-the-process-doubt-the-procedure-nba-playoff-aff8e01936ad?source=friends_link&sk=e3f810d248637fbdd6dfaebed58383e0), we introduced our wager & **question of interest** , framed it via **basic probability theory** , **collected** & **processed our data** , & produced simple **summary statistics** , which we determined were insufficient to settle the matter.
- In [**Part 2**](https://towardsdatascience.com/trust-the-process-doubt-the-procedure-nba-playoff-win-chances-379ad92e20a0?source=post_page---------------------------&sk=867f3c54c4e3d2f26beb1f1f90df8ac4), we approached the question through the framework of traditional statistics, via frequentist **Null Hypothesis Significance Testing**. These tests unanimously supported my side of the bet, but we showed how they suffer from chronic issues of **hidden assumptions** , **misunderstanding** & **mechanical misapplication**.
- In [**Part 3**](https://towardsdatascience.com/nba-playoff-win-chances-via-bayesian-inference-83a6595fb95f?source=friends_link&sk=7f000033a2c217792b5ae1abbc048f7e), we explored **Bayesian alternatives** to frequentist NHST, which provided **much richer & more interpretable** probabilistic assessments of our question of interest, but still left us without an unequivocal binary determination: **_am I right or is Nat?_**
- In **Part 4** (this post), we showed how translating our question from an idle academic matter to a **matter of action & decision** helps to **clarify, concretize & rationalize** our approach. Basic **decision theoretic frameworks** allowed us to cast our question in terms of **costs & consequences** , & gave us a rigorous method to **assess the relative value of decisions & information**.

It has been a journey. And yet, we still haven’t put our question to rest:

**So who wins the bet?**

Here’s where I make my confession, if it hasn’t been obvious already: I’ve only been using this question as a thin conceit to enable detailed exploration of these analytic concepts & approaches, which I’ve wanted to undertake for a while. So, really, **_we all win_**. (\*troll face\*)

That said, I will just reiterate that, from the outset, **our two groups’ win % was actually tied**  **since 2002** (with slight advantage to L\_W teams). So, if you really want to argue about NBA dynamics between 1984–2002, I have but one response:

Ok boomer.

_Thanks for reading, see below for further resources,_ [_follow me_](https://medium.com/@dnlmc) _&_ [_check out my other posts_](https://medium.com/@dnlmc)_. Also, please comment with thoughts, objections or corrections!_

—   
Follow on twitter: [@dnlmc](https://www.twitter.com/dnlmc)  
LinkedIn: [linkedin.com/in/dnlmc](http://www.linkedin.com/in/dnlmc)  
Github: [https://github.com/dnlmc](https://github.com/dnlmc)

### Further Decision Science Resources

- [**Decision Theory**](https://people.richland.edu/james/summer02/m160/decision.html) (simple definitions of decision criteria & a worked example)
- [**Bayesian Decision Theory Made Ridiculously Simple**](http://www.statsathome.com/2017/10/12/bayesian-decision-theory-made-ridiculously-simple/)
- [**Intro to Decision Theory: Bayesian Methods & Modern Statistics**](http://www2.stat.duke.edu/~rcs46/lecturesModernBayes/601-module2-decision-theory/lecture3-decision-theory.pdf) (pdf)
- [**Fundamentals of Decision Theory**](https://courses.cs.washington.edu/courses/cse573/12sp/lectures/25-decisiontheory.pdf) (pdf, includes additional criteria: equal likelihood, Hurwicz, as well as utility functions)
- [**Basic Decision Theory**](http://planning.cs.uiuc.edu/node426.html) (chapter of online textbook for a class in “Planning Algorithms, lots of math formalism)
- More lecture notes: [one](http://home.ubalt.edu/ntsbarsh/ECON/DecisionAnalysis.pptx) (.ppt), [two](https://www.cse.wustl.edu/~garnett/cse515t/spring_2015/files/lecture_notes/3.pdf) (pdf)
- [**Short post on seeking more information**](https://forum.effectivealtruism.org/posts/8w2hNT5WtDMzoaGuy/when-to-find-more-information-a-short-explanation) (related to EVPI)
- Bunch of stuff on [**Fast & Frugal Trees**](https://en.wikipedia.org/wiki/Fast-and-frugal_trees), which I couldn’t explore here: [R package](https://ndphillips.github.io/FFTrees.html), [vignette](https://cran.r-project.org/web/packages/FFTrees/vignettes/guide.html), [shiny app](https://econpsychbasel.shinyapps.io/shinyfftrees/), [blog post](https://learncuriously.wordpress.com/2019/05/05/fast-and-frugal-trees-vs-machine-learning-trees/), journal article [1](https://www.frontiersin.org/articles/10.3389/fpsyg.2015.01672/full) & [2](http://journal.sjdm.org/17/17217/jdm17217.pdf)
 ![](https://medium.com/_/stat?event=post.clientViewed&referrerSource=full_rss&postId=9752b6c969d5)
* * *

[From Information to Action with Quantitative Decision Science](https://medium.com/coemeta/from-information-to-action-with-quantitative-decision-science-9752b6c969d5) was originally published in [Coεmeta](https://medium.com/coemeta) on Medium, where people are continuing the conversation by highlighting and responding to this story.

