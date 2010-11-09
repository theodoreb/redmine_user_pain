User Pain bug triage for Redmine
=============================

As advertised on [Lost Garden](http://www.lostgarden.com/2008/05/improving-bug-triage-with-user-pain.html).


It's very alpha but it works. You need to create a custom list field named *Likelihood*


For exemple if an issue has the following values selected : 

### Tracker

* (7) Crash: Bug causes crash or data loss. Asserts in the Debug release.
* **(6) Major usability: Impairs usability in key scenarios.**
* (5) Minor usability: Impairs usability in secondary scenarios.
* (4) Balancing: Enables degenerate usage strategies that harm the experience.
* (3) Visual and Sound Polish: Aesthetic issues
* (2) Localization:
* (1) Documentation: A documentation issue

### Priority

* (5) Blocking further progress on the daily build.
* (4) A User would return the product. Cannot RTM. The Team would hold the release for this bug.
* **(3) A User would likely not purchase the product. Will show up in review. Clearly a noticeable issue.**
* (2) A Pain – users won’t like this once they notice it. A moderate number of users won’t buy.
* (1) Nuisance – not a big deal but noticeable. Extremely unlikely to affect sales.

### Likelihood

* **(5) Will affect all users.**
* (4) Will affect most users.
* (3) Will affect average number of users.
* (2) Will only affect a few users.
* (1) Will affect almost no one.

The user pain value for this issue would be : 

    100 * (6*3*5) / (7*5*5) = 51


The value is always fresh and computed on the fly. A css class name has been 
added to the issue row to facilitate styling.


Patches more than welcome.
