---
title: Science Communication with Notebooks
description: ''
date: 2022-12-09
---

[![CC BY 4.0][cc-by-shield]][cc-by]

:::{.callout-caution}

# DRAFT

This is a _rough_ `DRAFT`, aiming to provide recommendations and examples on how to use notebooks in publishing, including how to adapt and improve JATS and other standards.
:::

:::{.callout-note}

# Contributors

The AGU _Notebooks Now_ working groups will be participating and leading the creation of these documents.
Current contributors to these documents are:

Rowan Cockett
: **Roles**: Writing – Original Draft Preparation, Software, Visualization
: **Affiliation**: Curvenote Inc
: **GitHub**: @rowanc1

J.J. Allaire
: **Roles**: Writing – Original Draft Preparation, Software
: **Affiliation**: Posit Software PBC
: **GitHub**: @jjallaire

Charles Teague
: **Roles**: Writing – Original Draft Preparation, Software
: **Affiliation**: Posit Software PBC
: **GitHub**: @dragonstyle

Jeffrey Beck
: **Roles**: Writing – Review & Editing, Conceptualization
: **Affiliation**: National Center for Biotechnology Information, National Library of Medicine, National Institutes of Health, Bethesda, MD 20894, USA.
: **GitHub**: @jeffbeckncbi

:::

At AGU Notebooks Now, we looked at the academic publishing workflows around notebooks as a number of steps: (1) pre-submission, (2) submission & metadata, (3) editorial & peer review, and (4) production & post production. Each step of this workflow and how they fit together may be required to change or adapt when considering computational content in notebooks as a core publication artifact.

![](images/workflow.png)

To archive, host, and disseminate scholarly articles publishers typeset author submissions. This process not only creates PDFs and websites, it also adds structured information around citations, cross-references, and other important attribution metadata (ORCIDs, funding identifiers, RoRs, and other PIDs) which are distributed to other participants in the ecosystem (e.g. PubMed, CrossRef, indexers, archivers, etc.). In the context of open access, it is now common[^openaccessjats] that this Version or Record (VoR) includes the full text of the article as well as figures and tables; it is no longer just the abstract, authors, and references. The full text is most often stored in an XML format which can be used to create all other views of this content (PDF, HTML). The structure of this XML varies between publisher, with the most used open standard being JATS ([Journal Article Tag Suite](https://jats.nlm.nih.gov/)), a [NISO standard](https://www.niso.org/standards-committees/jats).

[^openaccessjats]: There are currently 5.8 million works with full-text XML available through CrossRef, for example. See [CrossRef’s API](https://api.crossref.org/works?filter=full-text.type:application/xml,full-text.application:text-mining&facet=publisher-name:*&rows=0).

When considering how to include notebooks in publishing, identifying how to include the notebook content in the VoR will unlock all current downstream providers, and allows the use of notebooks in publishing to be broadly adopted. Here we will discuss the constraints of JATS, suggest missing components, and recommend community standards to support notebooks in the VoR. These are designed to support various use cases of browsing, replication, and distribution of these articles as executable documents. We also consider how these processes fit into author-driven workflows to allow for continuous updates, feedback, and iterations throughout the process of creating this structured data.

## Contents

- [Approach](./01-approach.md)
- [Notebooks as JATS](./02-notebooks-as-jats.md)
- [Working Notes](./03-notes.md)

---

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg
