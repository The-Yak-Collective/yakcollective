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

{{site.data.build_date | date_to_rfc822}}

or

{{site.data.build_date | date_to_string}}





and thats it

