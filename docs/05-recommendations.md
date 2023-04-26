---
title: Recommendations
description: ''
date: 2023-04-26
---

## Dedicated tags for computational content

### Notebook Cell

There is a specialized tag that should be introduced for a notebook cell. We are currently using `boxed-text` with a specialized `content-type="notebook-code"`. We also considered using `sec` for representing this element, however, it is often nested inside of other sections which is not valid if interspersed with other narrative content.

```xml
<notebook-cell content-type="code" id="cell-1">
```

This should have children of `(code, (notebook-output)*)`, and should be able to be used anywhere a `boxed-text` can be included.

`content-type`
: This should be recommended to be `code` or `raw` or a custom string. Markdown cells should not be represented in JATS as `notebook-cells`; if the markdown structure is required to be preserved, `milestone-start` should be used.

Notebook code can also be hidden, which should be

`specific-use`
: This should be `execution`, meaning the cell should be hidden (or collapsed) from print/web versions.

### Notebook Output

Similar to the `notebook-cell`, the outputs should be represented as a bundle of alternatives.

```xml
<notebook-output id="cell-1-output-1" rid="cell-1">
  <alternatives>
    <media specific-use="original-format" mimetype="application" mime-subtype="vnd.altair.v1+json" xlink:href="nb1-cell-3-altair.json" />
    <media specific-use="web" mimetype="text" mime-subtype="html" xlink:href="nb1-cell-3.html" />
    <graphic specific-use="print" mimetype="image" mime-subtype="jpeg" xlink:href="nb1-cell-3.jpg"/>
  </alternatives>
</notebook-output>
```

## Preserving Markdown Cells

In JATS it is not possible to represent both a narrative structure (i.e. nested sections) as well as preserve the markdown cell boundaries. For example, the following

```md
---
# Section 1

content
---

## A nested section

With content in this cell

---

And the next cell!

---
```

This should be possible with `milestone-start` and `milestone-end` which are created for this purpose, however, those are only allowed in typographical elements not in the body or in a section. If JATS allowed milestones in the sections and bodies, then a structure like this would be possible:

```xml
<body>
  <milestone-start rationale="Markdown cell boundary" specific-use="notebook-content" id="nb-cell-1"/>
  <sec id="section-1">
    <title>Section 1</title>
    <p>Content</p>
    <milestone-end rid="nb-cell-1"/>
    <milestone-start rationale="Markdown cell boundary" specific-use="notebook-content" id="nb-cell-2"/>
    <sec id="a-nested-section">
      <title>A nested section</title>
      <p>With content in this cell</p>
      <milestone-end rid="nb-cell-2"/>
      <milestone-start rationale="Markdown cell boundary" specific-use="notebook-content" id="nb-cell-3"/>
      <p>And the next cell!</p>
      <milestone-end rid="nb-cell-3"/>
    </sec>
  </sec>
</body>
```

As it stands in JATS 1.3, there is no way to represent both the narrative structure and preserve the authors original intent for markdown cells.

The milestones are advantageous as most renderers can safely ignore this element when rendering, and only those applications that require this information can act on it.
