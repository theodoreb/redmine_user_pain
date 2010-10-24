User Pain bug triage for Redmine
=============================

As advertised here on [Lost Garden](http://www.lostgarden.com/2008/05/improving-bug-triage-with-user-pain.html).


It's very alpha but it works.

* Use tracker to set type of bug
* Priority, same here
* A custom field named *Likelihood* of type list
* A custom field named *User Pain* of type float or integer

User pain is the product of Tracker, priority and Likelihood position
where position is the position in the list for the field. If you have
3 tracker in this order the value is determined as :

* (3) Crash
* (2) Major
* (1) Task 


Patches more than welcome.
