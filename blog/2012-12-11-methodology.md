The Methodology Luddite Manifesto

I'm a proud methodology hater. As soon as you guys start talking about 
process, about _how_ to build software, my eyes glaze over. I can't 
prove it, but I at least _hypothesize_ that the practical usefulness 
of a methodology is inversely correlated to how detailed and prescriptive 
it is. Therefore the most useful methodology is the simplest, least 
prescriptive one. That would be the _null methodology_, simply stated as:

> Please stop wasting valuable electrons with your silly amateur 
> philosophizing and go and do some real work!

An additional advantage of the null methodology is that it's usually 
quite inexpensive to implement. You don't need any certified scum masters 
or other such expensive accoutrements, just a couple of impatient, 
bad-tempered team mates who are sick of your shit. I'm sure all of us 
can find a couple of those in our immediate vicinity. Hell, in my case 
that would be, um, like, the whole rest of my team.

Now yes, certainly I recognize that in some environments the null 
methodology isn't _politically_ viable, and so we have to disguise it 
as something more prescriptive by putting it in a dress and painting 
lipstick on it. This, of course, is where Agile originally came from.
Sadly, what went wrong with agile was that a few folks mistook the 
dress and the lipstick for the essence of what was good about it: that 
it gave you ammunition to use against your idiot boss and against harmful 
shit like RUP, and then, by and large, got out of your way and let you 
get on with your work. 

I mean, if you read the agile manifesto, it's so fundamentally vague and 
platitudinal and hand-wavy as to be virtually indistinguishable from the 
null methodology. The harm comes about when people start trying to actually 
read meaningful shit into its platitudes. 

So, if I hate methodology so much, if I'm so entirely uninterested in 
process, in _how_, what do I worry about instead? Well, what happened is 
that I've freed up valuable stress glands for  worrying about the _what_, 
that is, the actual _product_ I'm building.

Since every unmethodology needs a manifesto, here's mine. Clearly it 
needs some work, since in this age of four-second attention spans, nobody 
will ever make it to the fifth, and most important, bullet point.

A good product:

(1) solves an interesting problem,
(2) with a set of feature that are as general and orthogonal as possible,
(3) whose behavior is sufficiently well-defined and well-tested,
(4) using tools and technologies that will help you change and extend the 
    product in the future, and
(5) and can be delivered to your users as fast as humanly fucking possible.

(I had to put a naughty word in my manifesto to let you guys know how 
serious I am about this and as a shout out to my GeeCON peeps.)

Since this post is already much too long for its URL to fit in bit.ly, and 
because I'm already running out of electrons, and because my fingertips are 
sore from all this rapid keypressing, I'm not going to bore your 
social-media-retarded brain with any substantial quantity of words explaining
what I mean by each bullets. Instead I'm just going to briefly boil it down 
to some dumb shit that would like almost fit in twitter if it were three 
times as dumb and brief:

* If the problem isn't interesting, don't work on it. Man up and quit.
* Your users are begging for bells and whistles and optional semicolons. Tell 
  them you're really busy with some other high-priority shit right now but 
  that you'll get right onto implementing their precious optional semicolons
  when you find the time. Never find the time.
* If "sufficiently well-defined" means a formal specification, go and write 
  a damn spec. Trust me, if you want to learn how to think more rigorously 
  about software semantics, writing down specifications in English is one of 
  the best ways ever to go about it. On the other hand, if a formal spec won't 
  help you understand your software, don't write it. Either way, write lots 
  and lots of tests for user-visible behavior. Oh and if you need to, write 
  some unit tests for really complex internal subsystems - but not too many, 
  'cos that's code you don't really absolutely need that you'll still have 
  to maintain and refactor.
* Sure, it's great to be able to get up and started quickly. But be careful
  with platforms that are inexpensive up front and get more expensive as the 
  system grows and evolves and the team members change *cough* dynamic typing *cough*.
* What are you even still doing here? Don't you have code to write?
