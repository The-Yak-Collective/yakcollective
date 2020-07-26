---
layout: minimal
---
                {% assign nummembers = site.members | size %}
                {% assign featuredone= site.data.featured | modulo: nummembers %} 
                {% assign memb=site.members[featuredone] %}
## {{memb.title}}

follow: @{{memb.twitter}}

sorry, no "special skill" field yet

image: <img src="{{memb.avatar}}">

## vs

 {% include member-card-include.html member=memb %} 
 


