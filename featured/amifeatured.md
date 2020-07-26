---
layout: minimal
---
                {% assign nummembers = site.members | size %}
                {% assign featuredone= site.data.featured | modulo: nummembers %} 
                {% assign memb=site.members[featuredone] %}
## {{memb.title}}

follow: @{{memb.twitter}}

image: <img src="{{memb.avatar}}">

## vs

 {% include member-card-include.html member=memb %} 
 
 
 
##date format test

{{site.time | date_to_rfc822}}

or

{{page.date | date_to_string}}

or

{{Time.now}}



and thats it

