---
title: "\U0001F331 complex criteria comparison in Dataview"
date: 2022-09-27 00:00:00.000000000 Z
layout: post-external
original_link: https://person-al.github.io/%F0%9F%8C%B1/2022/09/27/complex-criteria-comparison-in-dataview.html
author: 100646
---

If you use Obsidian and have basic familiarity with SQL, [Dataview](https://blacksmithgu.github.io/obsidian-dataview/) is one of the most powerful tools you can use. Dataview allows you to run SQL queries across your vault, using not only intrinsic file properties but also any metadata you choose to add.

Let’s say you write movie reviews and have your reviews in files like so:`movie1.md`:

```
---
movie: Movie1
crit1:
  criteria: overall
  explanation: overall score
  score: 7
  note: not a killer movie, but such a fun one to watch
crit2:
  criteria: humor
  explanation: how funny was it?
  score: 3
crit3:
  criteria: cinematography
  explanation: scene blocking, visuals, costumes, etc
  score: 10
  note: absolutely stunning
crit4:
  criteria: plot
  explanation: was it well-constructed? Were there any plotholes?
  score: 8
crit5:
  criteria: soundtrack
  explanation: did the music match the movie? Would you listen to it again? Did it carry a particular meaning?
  score: 7
---
```

Dataview makes it easy to create tables like so:

| File | movie | crit1.critera | crit1.explanation | crit1.score | crit1.note | crit2.critera | crit2.explanation | crit2.score | crit2.note |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| movie1 | Movie1 | overall | overall score | 7 | not a killer movie, but such a fun one to watch | humor | how funny was it? | 3 | - |
| movie2 | Movie2 | overall | overall score | 3 | - | humor | how funny was it? | 9 | - |

With the following syntax:

```
TABLE movie,crit1.criteria,crit1.explanation,crit1.score,crit1.note,crit2.criteria,crit2.explanation,crit2.score,crit2.note FROM "<path>" WHERE movie
```

You’ll notice two problems here:

1. It’s impossible to read, and I’ve only added 2 of our 5 criteria here.
2. This isn’t how you’d want to compare movies. You want to compare the movies by criteria.

In other words…you want to rotate the table around so the rows are the criteria and the columns are the individual movie information. So how can we turn this:

| File | movie | crit1.critera | crit1.explanation | crit1.score | crit1.note | crit2.critera | crit2.explanation | crit2.score | crit2.note |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| movie1 | Movie1 | overall | overall score | 7 | not a killer movie, but such a fun one to watch | humor | how funny was it? | 3 | - |
| movie2 | Movie2 | overall | overall score | 3 | - | humor | how funny was it? | 9 | - |

into this:

| criteria | explanation | Movie1 score | Movie1 note | Movie2 score | Movie2 note |
| --- | --- | --- | --- | --- | --- |
| overall | overall score | 7 | not a killer movie, but such a fun one to watch | 3 |   |
| humor | how funny was it? | 3 |   | 9 |   |
| cinematography | scene blocking, visuals, costumes, etc | 10 | absolutely stunning | 4 |   |
| plot | was it well-constructed? Were there any plotholes? | 8 |   | 2 | This was the unforgivable part. I couldn’t even rewatch it. |
| soundtrack | did the music match the movie? Would you listen to it again? Did it carry a particular meaning? | 7 |   | 3 |   |

?

## the answer

The answer is your same movie documents as called out above. Plus the following document as your “score card”. Note that this document is designed so that _most_ people only need to modify the metadata to meet their use case. So don’t be afraid of the dataview part:

```
---
perPageColumns: [score, note]
keyInValidPages: movie
numCrits: 5
critProperties: [criteria, explanation]
crit1:
  criteria: overall
  explanation: overall score
crit2:
  criteria: humor
  explanation: how funny was it?
crit3:
  criteria: cinematography
  explanation: scene blocking, visuals, costumes, etc
crit4:
  criteria: plot
  explanation: was it well-constructed? Were there any plotholes?
crit5:
  criteria: soundtrack
  explanation: did the music match the movie? Would you listen to it again? Did it carry a particular meaning?
---

```dataviewjs 
// Select related pages  
// Currently the below checks all pages in your vault.
// But you can limit to a folder, a tag, or any combination of the two.
// For for details, check out the docs: https://blacksmithgu.github.io/obsidian-dataview/api/code-reference/#dvpagessource
const pages = dv.pages()
const supportedPages = [];
const validityKey = dv.current().keyInValidPages;
const perPageColumns = dv.current().perPageColumns;

// Only keep valid pages 
const relevantPages = pages.map((page) => {
    // If there are other fields, keep this page 
    if (validityKey != undefined && page[validityKey] != undefined) {
	    supportedPages.push(page[validityKey]);
        return page;
    }
    // otherwise, return undefined  
    return undefined;
}).where((p) => p) // this removes "undefined" items.  

// These are the table headers
const critProperties = dv.current().critProperties;
const headers = critProperties.concat(supportedPages.map(p => perPageColumns.map(c => `${p} ${c}`))).flat();
const numColumns = headers.length;
const numSetHeaders = critProperties.length;

// Get the static info you need for each criteria
const critInfo = Array(dv.current().numCrits).fill(undefined).map((_, index) => {
	const result = [];
	critProperties.forEach(val => result.push(dv.current()[`crit${index+1}`][val]));
	return result;
});
const numRows = critInfo.length;

// Create table of correct size.  
let entries = Array(numRows).fill(undefined).map(x => Array(numColumns).fill(undefined))

// Fill the 2D array from "left to right"
for (let c = 0; c < numColumns; c++) {
    for (let r = 0; r < numRows; r++) {
	    // If we're in the critProperties section, grab from the info we saved
		if (c < numSetHeaders) {
			entries[r][c] = critInfo[r][c];
		} else {
			// Figure out which file & property cell we're on
			// Column order is F1P1, F1P2, F2P1, F2P2
			const numColumnsPerFile = perPageColumns.length;
			const currFileIndex = Math.floor((c-numSetHeaders)/numColumnsPerFile); // Current Column, minus the set headers, divided by the number of columns per file, floored 
			const currPropertyIndex = (c-numSetHeaders)%numColumnsPerFile;
			const currProperty = perPageColumns[currPropertyIndex];
	        const critNum = r+1;
	        const page = relevantPages[currFileIndex];
	        entries[r][c] = page[`crit${critNum}`] && page[`crit${critNum}`][currProperty];
		}  
    }
}

// Create the table.  
dv.table(headers, entries)
\```
```

(Note that this query started from the fantastic work of @dbarenholz in the Obsidian discord server. I made modifications to match my use case while keeping it general enough for others)

## how does it work?

The metadata section in your scorecard file tracks all the assumptions your dataview query makes. In most cases, you should be able to modify the metadata _only_ to make this work for you:

- **perPageColumns** tracks how many columns you need per file. In our example we want to display the score and the note fields from each criteria. You can limit this to 1 property or expand it to 12. But remember, too many and your table becomes unreadable again. Better to limit it and have multiple tables to show different kinds of information.
- **keyInValidPages** limits to all the pages with a given key in their metadata. In our example, it allows us to limit to movie review files.
- **numCrits** is how many criteria we need to keep track of. It’ll always equal the numbers of criteria you list below.
- **critProperties** tells the query what information about each criteria you’ll need displayed
- **crit1 … crit5** stores all the immutable information for the criteria you care about.

The query uses dataview’s javascript feature to construct the table:

1. It looks for all pages that meet your search criteria. 
  1. This is the only place you'll want to change the javascript. The `dv.pages()` call currently searches your whole vault. You can limit it the same way you would a `TABLE File WHERE <condition>` query. More details [here](https://blacksmithgu.github.io/obsidian-dataview/api/code-reference/#dvpagessource)
2. It generates a list of headers based on both the criteria properties you called out in **critProperties** and the columns you wanted to each page as listed in **perPageColumns**.
3. It then creates a list of information for each row in your table, filling out the information from your pages as described.

## example modifications

Here are some easy modifications you can make using just the metadata listed in your scorecard file.

### criteria properties

Let’s say you only care about the criteria name, you can do something like this:

```
critProperties: [criteria]
```

to get the following table:

| criteria | Movie1 score | Movie1 note | Movie2 score | Movie2 note |
| --- | --- | --- | --- | --- |
| overall | 7 | not a killer movie, but such a fun one to watch | 3 |   |
| humor | 3 |   | 9 |   |
| cinematography | 10 | absolutely stunning | 4 |   |
| plot | 8 |   | 2 | This was the unforgivable part. I couldn’t even rewatch it. |
| soundtrack | 7 |   | 3 |   |

You can even change the criteria information like so:

```
critProperties: [name, example, importance]
```

as long as you modify your criteria list to match:

```
crit1:
  name: overall
  example: 
  importance: high
```

It’ll work fine. Just remember to leave the criteria list as crit1, crit2, etc. The dataview query uses the `crit` keyword and the `numCrits` value to find the metadata it’s looking for.

### per-file property

Note that the same can be done for the per-file properties.

For readability purposes, we may only want `perPageColumns: [score]` to get a nice compact table like so:

| criteria | explanation | Movie1 score | Movie2 score |
| --- | --- | --- | --- |
| overall | overall score | 7 | 3 |
| humor | how funny was it? | 3 | 9 |
| cinematography | scene blocking, visuals, costumes, etc | 10 | 4 |
| plot | was it well-constructed? Were there any plotholes? | 8 | 2 |
| soundtrack | did the music match the movie? Would you listen to it again? Did it carry a particular meaning? | 7 | 3 |

## try it out!

Give it a try! Let me know what you think and how it works for you. Send me a link to your issue in the comment box below or reach out on the Obsidian discord in the `#dataview` channel. Someone will be able to help.

**Info** :

- **Related to:**
  - [[🧪 Obsidian Experiment]]
