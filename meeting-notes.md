---
title: Questions, Thoughts, Presentations, & Feedback
description: ''
date: 2022-12-09
---

# April 25, 2023

Meeting: Rowan, Franklin, Charles, J.J.

- Inline execution
  - This looks good.
- Showing progress on unit tests for feedback on utility
  - Looks like a good start, continue! 🚀
- Moving to a single format for representing articles and sub-articles
  - Need to figure out the outputs as figures/standalone, which might be different

Notebook values (e.g. glue or json):

```xml
<p>p = <xref ref-type="custom" custom-type="notebook" rid="nb1">0.04</xref></p>
```

**Question:** Should we duplicate the content out of the article, and have a companion article that is notebook-shaped?

**Thinking:** This is about publishing rich articles based on notebooks.

article
: if this includes code, it is in the paper

- paper (with cross refs) similar to the PDF
  notebooks
  : these serialize the content
- sub article (this is the article, duplicated)
- sub article
- sub article

Scientific discourse that is notebook backed.

Project:

- paper.qmd
- notebook.ipynb
- notebook1.ipynb

**Conclusion:** Our conclusion out of the meeting is to try and make articles and sub-articles the same, without duplicating the code or content.

# April 21, 2023

Meeting: Rowan, Franklin, Charles

**Agenda**

- boxed-text --> sections
  - https://github.com/curvenote/notebooks-in-publishing/pull/19
  - sec "content-type" --> sec-type
- Don't nest outputs in new section
  - https://github.com/curvenote/notebooks-in-publishing/pull/20
- figure supplementary-material (xref not allowed)
  - https://github.com/curvenote/notebooks-in-publishing/pull/21
- Propose inline variables as notes
  - https://github.com/curvenote/notebooks-in-publishing/pull/22

**Discussion**

- articles vs sub-articles, what is a section (e.g. narrative takes priority)
  - hide the cells?
  - backmatter cells?
  - Action: get further, show examples, then decide.
- Transform graphics to figures in sections? Should remove this?
  - Action: Wait till we have more examples.
- show jats-xml validation
  - jats validate myJats.xml
- discussion on schematron (examples, and why)
  - difficult to use, and not helpful for source document errors

**Next Steps**

- Get back to examples, and move slightly more into end-to-end tests
  - math, graphics
- Metadata next week (general JATS improvements)

# Presentation by J.J. and Charles:

[December 09, 2022](./2022-12-09_Publishing_Notebooks_Using_JATS_%20and_MECA.pdf)

# Rowan's Comments (Dec 9):

I think we need to keep a copy of the notebook in the XML, and not only in the `supplemental-material`. (but I like your approach there!)

I don't think the XML will ever capture enough information or be flexible enough to be the canonical execution format, and I don't think it is _worth_ doing that. However, there is value in getting _some_ of the content as data into the XML.

I think this probably means a copy of the notebook, which is not the canonical form, but has enough that you could probably reconstruct something close if the XML was all you had.

eLife (and others) have `sub-articles`, which I think is a really good approach to take.
They are currently putting things like editor reviews in here.

In this approach we don't have to overload the current `article`, which is going to have a lot of existing practices, but we can add new `sub-articles` with a type fairly easily?!

One thing I am not sure about is if this makes it over to pubmed, (eLife for example strips some of their XML when they submit).

This probably means that there are two formats: (1) MECA container as you describe & the JATS notebook duplicate. The execution environment should just read directly from the `ipynb`, `requirements.txt` etc. but the viewing environment might benefit from the XML, as well as stripping down various outputs for viewing (e.g. each interactive encapsulated HTML like a plotly or altair).

## Viewing Requirements

I quite like the idea of stripping out the pieces of a notebook into smaller pieces (e.g. the image in an output that is represented as a PNG, not base64). I think this same approach can be used for other mime types (e.g. html, widgets).

This also means that the load-time is faster, and downstream applications don't have to know how to parse notebooks.

i.e.

```xml
<!-- Move from: -->
<media
  id="nb-cell-id-tbl"
  mimetype="application/x-ipynb+json"
  specific-use="source-notebook"
  xlink:href="notebooks/source.ipynb#cell-id-tbl" />
<!-- To something like: -->
<media
  specific-use="original-format"
  mimetype="application"
  mime-subtype="vnd.altair.v1+json"
  xlink:href="nb1-cell-3-altair.json" />
<!-- Because this is in the XML, it is now an xref: -->
<xref ref-type="custom" custom-type="notebook" rid="nb1" />
<xref ref-type="custom" custom-type="code" rid="nb1-cell-3" />
<!-- With the data for the notebook source being stored in the `front-stub`: -->
```

## Questions

- How does quarto "import" figures into other documents?
- What portions of the dependencies should be included in the JATS? I think there is _some_ value in this.
- What would be the best way to represent inline execution in JATS?

### Small Things

I think `mime-subtype` is used not `mimetype` with both things in there.

For some of these I think we need to recommend a `specific-use` maybe "execution"?
