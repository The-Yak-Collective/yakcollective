---
layout: minimal
title: Testpage to show github issues and maybe also recations, as part of automatic proposals process
---

# list of proposals read from github 
right now, reading yakcollective. will need its own site

{% for issue in site.data.issues %}
**Issue number:** {{issue.number}}     **title:** {{issue.title}}

**labels:** {% for label in issue.labels %} <span style="background-color:#{{label.color}};"> {{label.name}} </span> {% endfor %}

**reactions:** {% for reaction in issue.reactions %} {{reaction.content}}  {% endfor %}

**Content:** {{issue.body}}

---

{% endfor %}
