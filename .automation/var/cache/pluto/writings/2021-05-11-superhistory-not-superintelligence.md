---
layout: post-external
title: |
  Superhistory, Not Superintelligence
date: 2021-05-11 16:10:00 +0000
author: 100041
original_link: https://breakingsmart.substack.com/p/superhistory-not-superintelligence
---

An idea from the influential 2009 Google paper, [The Unreasonable Effectiveness of Data](https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/35179.pdf), has shaped a lot of thinking, including my own, in the last decade: _simple algorithms and more data beat complex algorithms and less data_.

This insight has shaped the evolution of not one but _two_ technological revolutions -- Big Data and modern machine learning (deep learning). And it has led me to start thinking about AI in terms of time rather than intelligence.

Specifically, modern AI is better understood as AT — “Artificial Time” that can be prosthetically attached to human minds. And highly capable computing systems are best understood as _existing in superhistory_ rather than _embodying superintelligence._ I think this is genuinely an interesting shift in perspective, not just a fun bit of idle speculation for time nerds like me.

The idea will take a bit of setup to explain though.

## More Data

Big Data was driven by the falling costs of storage. George Dyson defined it as: It's Big Data when it’s cheaper to store it than decide what to do with it.

At some point, storage became cheap enough that it was worth storing all the digital bits we could generate — what is sometimes called the “data exhaust” of life. This may not stay true as the data inflows from the world's sensors increase, but is sort of true today. Even if it’s not strictly true, we’re well past a crucial threshold: we can now digitally capture and preserve vastly more data from any human activity than any human mind involved in it could directly comprehend, process, or transmit.

This is the threshold that matters — blowing past human cultural transmission bandwidth limits. That’s where Big Data begins in practice.

A bunch of technologies for wrangling data at these large scales emerged by 2012, but the basic driver was low storage costs. People who dismiss “Big Data” and “data science” as “just statistics” perversely miss the point: _More is different_. Big Data wasn’t a fad. It installed a whole bunch of technologies and capabilities for dealing with data at scale into our IT environment. And it created the conditions for what came next — machine learning.

## Simpler Algorithms

At an abstract level, modern machine learning is about “simpler algorithms” in the form of frameworks that are extremely lightweight (in terms of lines of code) relative to what they accomplish_._ They represent vastly more computational leverage than traditional code. I’d guess a line of code that goes into something like a modern image recognition framework is worth 100 or 1000 lines in a roughly equivalent old-fashioned ([GOFAI](https://en.wikipedia.org/wiki/Symbolic_artificial_intelligence)) computer-vision framework.

The approach works in two stages. In the computationally expensive training phase, you use frameworks to digest vast amounts of data into _models_ of domains of behavior such as natural language processing, image recognition, and recommendations. In the computationally cheap _inference_ phase, you apply these digested models to new situations. Note that “models” is not models in the human-comprehensible sense. It just means a compact, digested form of the information latent in the training data, in a form suitable for making decisions. This is why “explainable AI” (or more appropriately, what Carlos Bueno has dubbed [Justifiable AI](https://www.ribbonfarm.com/2018/03/13/justifiable-ai/)) is a matter of active, if largely misguided, debate. Beyond that rather limited debate is the more interesting question of how these models _do_ understand their (data) worlds, as embodied by what are known as the [latent spaces](https://www.nature.com/articles/s42256-020-0164-7) of these models.

If AI models cannot be reduced to human terms of reference, perhaps human thought can be expanded to comprehend computational terms of reference. Living in superhistory involves learning to do that.

## Software 2.0

Training modern ML models requires the most powerful god-like computers you can throw at the problem. Inference though, is often lightweight enough to run on the cheapest personal computing devices like smartphones. This point is important to appreciate for the reframe of intelligence in temporal terms that I’m trying to set up — _the digested models are impedance-matched to human brains and human-scale devices, even if the training data and computations are not._

The machine learning revolution has been driven by the development of a series of increasingly mathematically powerful frameworks ([CNNs](https://en.wikipedia.org/wiki/Convolutional_neural_network), [transformers](https://en.wikipedia.org/wiki/Transformer_(machine_learning_model))) that can digest increasing amounts of training data, with decreasing amounts of supervision, producing increasingly reliable inferences. These developments [initially outpaced](https://openai.com/blog/ai-and-compute/) Moore's Law, but have now sort of hit the ceiling and are keeping pace with it. As you get better hardware, you can train bigger and better models, and make more reliable inferences with them. This is what Andrej Karpathy has dubbed [Software 2.0](https://www.youtube.com/watch?v=y57wwucbXR8) — basically a systematic generalization of what Google meant by simpler algorithms in their 2009 paper. For once, the "2.0" label is merited.

It's a qualitative step change. Cheap storage gave us "more data" and machine learning frameworks have given us "simpler algorithms."

One way of thinking about the shift to Software 2.0 is: if computation is code+data, the intelligence is moving from the code to the digested data. The code merely distills and concentrates it between raw input and digested (“modeled”) output. It does not “think.” A modern AI model is something like an unprogrammable, bespoke, domain-specific language only available as a compiled runtime.

The essential insight in the 2009 paper needs qualification of course. _Under certain conditions,_ simpler algorithms and more data do better than more complex algorithms with less data.

Software 2.0 is not always the better paradigm. A particularly important special case is human brains, viewed as software.

## Humans are _not_ Software 2.0

Curiously, pure humans as computational systems don't normally meet those conditions. Not because our brain hardware is incapable of running in software 2.0 modes, but because our thinking is constrained by human cultural transmission modes.

For example, if you’re learning anything from this essay, it is not from the same input data that shaped my own understanding. You are learning from my human-scale digested understanding and writing ability, with all my personal limits. And I have no easy way to just let you pool my input data into yours. You can’t think with two-human-lives worth of data. You can only compose your digested conclusions with mine.

Partly as a result of this constraint, older is not necessarily wiser. Slower, more experienced brains don’t necessarily outperform sharper, younger brains. In fact, most traditional fields of human striving feature a pattern of “the student becomes the master.” If you’re younger and sharper than me, you might be able to poke holes in this essay and teach me a thing or two even if you’re much newer to the topic of AI.

Therein lies a tale. It is clearest in everybody’s favorite AI domain, chess.

It used to be said that older chess players win on experience against younger, more talented ones. For a while. Until they don’t. They used to say that that about Karpov in the Eighties, when he went up against Kasparov for example.

But when Magnus Carlsen defeated Vishwanathan Anand in 2013, something weird and new was on display. I'm not a chess player, but from the commentary I read, it seems like not only was Carlsen more of a raw talent than Anand (same as Kasparov vs. Karpov) but he was also "older" in a weird way, despite being nominally 21 years younger. Carlsen is young enough to have been effectively "raised by AIs" -- the most sophisticated chess AIs available on personal computers when he was growing up in the aughts. His playing style was described as kinda machine-inspired, pushing hard all the way through the end, exploring unlikely and unconventional lines of play where human tradition would suggest conceding.

Those descriptions sounded, to me, very similar to how AlphaGo and AlphaGoZero were described, in terms of play style relative to human masters, a few years later.

Now that computers are firmly in the lead on games like chess and Go, and there’s no fun in direct human vs. machine games, there's this thing called [Centaur Chess](https://en.wikipedia.org/wiki/Advanced_chess): human+AI teams playing against each other. But what people seem to miss is that even _conventional_ play was already Centaur-like in a hidden way by the time Carlsen rose to the top in 2013.

Carlsen may not receive live AI assistance during the conventional tournaments he competes in, but being trained by AIs in his youth had _already_ made him a different kind of AI-augmented player in 2013.

Magnus Carlsen is a _latent centaur_

## Latent Centaurs

In the Iain M. Banks novel, _Player of Games,_ we learn that the AI Minds of the Culture don’t play human games because they are too easy; but they do train the protagonist in his undercover mission to undermine an adversary civilization built around the most complex game known to be played by biological lifeforms. The entire civilization is built around centuries of playing the game.

But the alien player from the Culture, trained by the Minds, easily blows past the native players with their centuries of accumulated traditional learning, and accomplishes the mission. The Minds didn’t need to participate directly in live gameplay. They could pass on the fruits of their study and digestion of the game on to their human agent. As a result of the training/inference asymmetry, the human’s brain didn’t have to be as computationally powerful as a Mind to play like one.

A player trained by AIs is obviously going to develop a very different style compared to those who train by playing against the living humans around them. Their minds are not going to be bound by tradition like those of humans taught by other humans. Their development is not going to be constrained by human cultural transmission modes.

The Carlsen style of latent-centaur learning is going to benefit from what is effectively hundreds of human-equivalent years (HEY) of _digested_ chess-playing experience the AI has acquired during its model-training phase, and is applying in the inference phase in new games. And unlike Young-Carlsen-era AIs, modern AIs aren’t even limited to learning only from past human experience. As AlphaGoZero demonstrated, you can do even better by throwing away accumulated human experience and simply generating new data by having the AI play against itself.

So a modern player trained in a well-designed learning loop against the latest AIs has a true "player age" that is some function of their biological age, and their inherited "AI age" that is a measure of the human-equivalent experience time latent in the training data. So perhaps by virtue of growing up playing against chess programs on computers, Magnus Carlsen is really 200 years old. Whoever unseats Magnus Carlsen will be 2000 years old.

This is _not_ like belonging to an intellectual tradition, with a lineage of masters passing on their knowledge and skills through books and teaching. That process of cultural transmission is limited by the individual-human-mind bottlenecks it must periodically pass through.

Machine learning is not constrained that way, so long as raw data is cheap enough to store. And if you can access that learning, you too, can be a latent centaur like Magnus Carlsen.

## Augmenting Humans

Augmenting humans with machine learning in the right way raises their effective _experiential_ age. They possess greater "lived experience" than their biological age would suggest because they've acquired prosthetic experience, in digested, summary form. Each such digested bit attached to your brain could be measured in terms of the experienced time it represents.

Here is where the training/inference cost asymmetry kicks in.

You need vast pools of powerful computers to _train_ the best, biggest models, but you mostly only need much cheaper personal-scale computers to do _inference_ with those models. So the hundreds or thousands of years worth of experience are logged in expensive infrastructure living in superhistorical time, but are usable at human scale in historical time.

You might not even need a personal computer at all. It might be sufficient to have been taught by computers. Your own brain might be sufficient to hold digested models suitable for inference.

I expect this to happen to writing pretty soon. Early AI writing assistants (think Microsoft Clippy) were laughably cringe, and you had to be secure enough in your writing skills to ignore their advice. The newer ones I've seen -- ranging from Gmail's email response suggestions to GPT-3 to products like [textspark.ai](https://textspark.ai/) -- are starting to get good enough that their suggestions are worth taking seriously.

One way to think of this is: these AIs have already read vastly more text than I could in a thousand years, and digested it into writing minds (language models) that are effectively Ancient Ones. And their understanding of what they’ve digested is _not_ limited by human interpretative traditions, or the identity insecurities of various intellectual traditions (AIs, blessedly, do not suffer from the limiting temptations of Straussian respect for tradition).

If I connect to a writing-assistant AI in the right way, even with significant inefficiency, I'd be effectively writing like a 1046-year old rather than a 46-year old. If I could learn to go spelunking in the latent spaces of these models, I’d be able to write in ways no human has ever written before.

In fact, this may have already happened to some writers. William Gibson is arguably already a centaur writer, [practicing writing in the genre of network realism](http://booktwo.org/notebook/network-realism/), living in the unevenly distributed future of all writers. His writing is a case of living intensely in the superhistorical present, all access to the past, present, and future being mediated by computational intelligence as he writes.

## Centaur Age

I made up my numbers earlier obviously, for rhetorical effect. It is not clear what it means to say Magnus Carlsen is “200 years old” in data years. But we can conceivably come up with a systematic way to estimate your experiential "centaur age" based on the skills you practice in computationally-augmented ways.

This idea of experiential, or centaur age is _not_ the same as biological age as a proxy for human experience, because human brains are prevented from being true Software 2.0 systems by cultural constraints.

A subtlety here. Unaugmented humans too, experience a transition that _looks_ like going from complex to simple algorithms and less to more data as they age.

But this is less about wisdom, and more about adaptation to the degeneration of aging, and the limiting effects of traditional cultural transmission. We don’t necessarily grow wiser with age because we also get more culturally conservative, hitting the limits of both what we can learn from human traditions, and our own failing senses and increasingly limited experiences.

I now think in much simpler ways than 20 years ago, but with the benefit of 20 years of personally digested experience. But this isn’t Software 2.0. I’m not thinking better with “simpler algorithms and more data.”

I’m just significantly older, but not particularly wiser, and making the best of it.

In the case of humans, "data aging" of this sort is a highly suspect. You're far more likely to fall into repetitive patterns of life where instead of 20 years worth of data, you really have 20x reinforcement of 1 year's worth of data, due to the necessarily conservative life choices we fragile meat-bags tend to make.

Biological humans are simply bad at being exploratory enough to log a year's worth of data for a year's worth of life lived. So we end up as bundles of conservative biases as we age, and grow set in our ways. We grow older, but rarely wiser, even if we are sometimes able to dazzle younger humans with charismatic words and long beards.

This is a good survival strategy but not a wisdom-maximizing one. Those who live experientially rich, gonzo lives tend to die young and wise (even if suicidally depressed about it). Those who hang back a bit survive longer even if they have less fun and die dumber.

Artificial systems are not directly limited in their exploratory learning by survival pressures, or what is known as the exploration/exploitation tradeoff. That’s why your centaur age can be much longer than a human lifespan if you connect to artificial systems in the right way.

## Biases

The time view of AI suggests that reproduced human biases that creep into AI are not as important a long-term issue as AI ethicists make them out to be today. They are important to mitigate in the short term, but not a fundamental show-stopper.

This is because AIs rapidly outgrow the potential of accumulated human experience as models grow in size and richness. Their growing non-humanness eventually overwhelms their inherited human biases.

For example, _of course_ an AI that digests a gazillion real interview data sets will end up learning and reproducing all the hiring biases of humans. Nobody with even a passing understanding of the technology was surprised by this.

This says less about the limitations of AI than it does about the repetitiveness and mimetic redundancy of the human-life-data used to train it. If you could turn interviewing into a “play against yourself” model training regime as DeepMind did with Go, you’d break out of this in no time. The AI would start hiring totally surprising candidates for jobs, who would go on to perform in almost magically effective ways. Somebody will figure this out soon enough, by turning hiring into a Go-like game.

Chances are, human organizations will have to be entirely redesigned around these new, computationally mediated ways of knowing each other and doing together. If you expect traditional organizations to merely “adopt” AI-based systems within traditional functions, you’re in for a shock. Slowing down AIs to operate at human institutional speeds is to beg the question of their value altogether.

And all this is assuming AIs operating in human-scale decision environments, with a human prehistory. This is increasingly just a special case subset. AIs today are increasingly starting to make decisions in domains that never really existed for humans. We have no experiential data to contribute, biased or otherwise.

At best we might participate in domains that only exist because sufficiently capable computing systems exist to operate and learn models in them.

The larger lesson here is this: _ **lived human experience is not worth as much as you might think.** _

## Mostly Empty Time

Every scientific or technological revolution tears down yet another anthropocentric conceit. This one is tearing down the conceit that our lives are significant in informational terms. That every life story is full of unique richness worth the narration.

The humbling thing about the rise of machine learning is not that it shows us how stupid we are in “intelligence” terms, but how _empty_ our lives are, in terms of their information content.

This moment in history is like the moment when the structure of the atom was deciphered and we realized that seemingly solid matter was better understood as mostly empty space shaped by fields.

In the last decade, we’ve discovered that human lives are mostly informationally empty time, existing in a meager set of threads with the superhistorical time computers are starting to inhabit.

Human conceits wrapped up in centuries of recorded experience with games like Go and chess have been wiped away in a matter of weeks.

When you are an AI, you can log “historical experience” at the rate of decades per week. Or perhaps even centuries per hour. Perhaps it’s not surprising at all that recent years, with events driven by algorithms, have felt like a relentless parade of what Lenin called “weeks where decades happen.”

This is not history, it is superhistory.

AIs live and learn in superhistory, mining every last bit of information out of raw events, as well as the adjacent possible.

In a relatively homogenous, stable, culturally harmonious society (the kind that humans like to sentimentally remember as a golden age) you don't have as much "life" going on as the nominal numbers suggest. Three generations of people (let’s say a century between the birth of the oldest to the death of the youngest in the set) in a town with a stable population of say 10,000 is _not_ 1 million human-years of life experience. It might be, like, 230 years net. Because they all live roughly the same, equally empty lives.

## Data Aging 

When you feed human-life-generated not-so-big data into an AI, it's not actually that much in informational terms. Properly digested in terms of actual information content and decision-making intelligence, with adequate discounting for repetition and imitation, all of human history is not billions or trillions of human-years worth of data. It’s probably more like tens of thousands of human-years.

The average human in history has probably contributed no more than a few minutes worth of data to the shared human historical data set.

In one sense, the average human dies at a data age of perhaps 5 minutes, in terms of novel data contributed to the human experiential pool. In terms of new-to-you experience, perhaps 100 years of chronological aging is worth perhaps 20 years of data aging.

At a cosmic scale, Douglas Adams’ “mostly harmless” is exactly the right summary model of our planet for the galactic hitchhiker trying to decide where to go next.

But now, with the right kind of computational augmentation, you can _properly_ data-age. Even if you are only growing 1 year for every 5 lived in biological terms, your computationally extended centaur body might more than make up for that, injecting 100 years worth of experience into every year of your life lived.

You’d be data-aging at the rate of 100.2 years per year of biological life.

This is already happening to all of us to a remarkable degree. You don't need access to complex modern deep learning technology to see that. You don’t need to be a latent centaur chess player like Magnus Carlsen, or a latent centaur writer like William Gibson.

Those of us who have been using Google search for 22 years are _already_ like 100 years older than our biological age. Every year lived with Google at your fingertips is like 5 lived within the limits of paper books. In many ways, I feel older than my father, who is 83. I know the world in much richer, machine-augmented ways than he does, even though I don’t yet have a prosthetic device attached to my skull. I am not smarter than him. I’ve just data-aged more than him.

Ideas like “building a second brain” leverage this basic new potentiality in the human condition; our newfound ability to age faster than we can live, by using machines to do much of the superhistorical living for us.

## This is New

It is tempting to argue that there is nothing new to this phenomenon. That digested human experience has always been all around us in the form of cultural institutions.

I believe this argument is not just flawed, but entirely wrong.

Those old institutions were built as extensions of ourselves, reproducing and even intensifying all the extreme repetitiveness and redundancy of our own lives. They were shaped by costly storage technology. You could _not_ afford to store everything. You had to decide what to do with it, and store it in forms ranging from epic poetry to government interdepartmental memos. Individual human brains had to digest manageable chunks of data and turn them into informational bricks for pre-computational institution building.

The thing about simple algorithms operating on a world of human-life-generated and broader kinds of data is that it blows past our own limits and discards our past in ways traditional institutions were simply incapable of. Because traditional institutions relied on human brains to do the computing, and extremely expensive storage technologies.

_Traditional institutions could not tap into the unreasonable effectiveness of data, so they were forced to rely on complex algorithms and less data._

Now there are non-human brains doing the digesting, and drawing on vast supersets of cheaply stored human _and_ non-human experience, but potentially free of our tendencies towards repetitiveness and imitation.

The fact that AIs are temporarily reproducing all our biases is almost an irrelevant footnote.

## Entering Latent Superhistory

AIs — or ATs — will likely outgrow all our current anthopocentric conceits and anxieties because they are not limited to human-life-generated data.

Lately, they have been learning mostly from themselves (AlphaGoZero), from independent ways of sensing the world (from cameras on cars to sensing modes with no human equivalent like the temperature sensors spread across a datacenter), and are even starting to get weaned off of human tagging of datasets.

Autonomous driving algorithms already drive differently from humans because they are learning from dozens of cameras instead of just two forward-facing cameras. In addition, they are learning from LIDAR, radar, and other kinds of data sources. And most importantly, because they are pooling data in ways impossible with human-to-human cultural transmission, they are learning from vastly more raw driven miles than any individual human will ever log. It’s not one car that is learning to self-drive. It’s a hive mind of thousands of car-brains pooling raw data. A car Borg.

This effect was already evident in pre-deep-learning AIs -- aircraft Autoland systems were performing better than human pilots on average decades ago. The difference will only get more marked.

What all this means is that AIs are _already_ sensing, recording, generating and digesting history at the rate of decades or centuries per week.

AI is _not_ a young technology. Properly understood in terms of their native temporalities, in terms of superhistorical training time logged, they are _ancient_ technologies. They are already older than the oldest human-made artifacts in terms of historical experiences (real or simulated) logged and digested. The pyramids of Egypt are mere babies compared to say, GPT-3.

And we’re figuring out how to attach all this logged Artificial Time to our own brains, and learning to act like Ancient Gods ourselves.

Every time you Google something that your grandmother would have just resigned herself to simply never knowing, you are data-aging by minutes in seconds.

It’s not just the isolated factoid you learn. It’s the training and experience pathway that led to that factoid _existing_ at your fingertips. A pathway that increasingly does not wind its way through a tradition of human minds limited by egoistic modes of cultural production, preservation, and transmission, but is limited only by storage and computation costs.

You’re not living as a witness to the rise of superintelligence. You’re living as an agent being augmented by supertime. You are living at the end of history, and entering a superhistory being created by machines.
