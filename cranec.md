---
layout: minimal
title: Testpage to show github issues and maybe also recations, as part of automatic proposals process
---

# list of proposals read from github 
right now, reading from a public repository re covid-19.

{% for issue in site.data.issues %}
**Issue number:** {{issue.number}}     **title:** {{issue.title}}

**labels:** {% for label in issue.labels %} <span style="background-color:#{{label.color}};"> {{label.name}} </span> {% endfor %}

**Content:** {{issue.body}}

---

{% endfor %}
