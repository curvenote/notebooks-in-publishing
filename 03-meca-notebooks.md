---
title: Notebooks in MECA
date: 2022/12/12
---

The goal of this article is to recommend community standards for including Notebooks in MECA files. This is intended to be complementary to our proposal regarding the [inclusion of computational notebooks within JATS XML files](https://github.com/curvenote/notebooks-now/blob/main/02-notebooks-as-jats.md).

::: callout-note
This is a very rough `DRAFT`, as we get more authors, we can add stonger language like "we recommend" etc. That may have leaked in already.
:::

## MECA Overview

MECA is a National Information Standards Organization (NISO) project which outlines a common means to easily transfer manuscripts and accompanying files between manucript systems.

A MECA file is a single zip file which contains:

A manifest.xml file which describes the contents of the bundle A single manuscript as a JATS XML file A transfer.xml which includes information about the sending and receiving systems Content files (arbitrary dependency files) which must be listed in the manifest.xml There are other optional files as well, read more here

## MECA and Notebooks

While JATS XML provides a standard way to encode a journal article metadata and ocntents, it does not provide a mechanism for bundling or including externally referenced files with the JATS XML file. MECA files provide a way to combine a JATS article with the files it references into a single file that be sumbitted to manuscript systems or shared with others.

We specifically envisision that MECA files which include JATS XML with notebook `sub-article`s will also include a native copy of the notebooks (as `.ipynb` files) as well as files required to restore the execution environment for a notebook (for example as a folder that can be used to restore the environment).

## MECA Paths

While MECA files may include arbitrary files (as long as they are referenced from with the `manifest.xml` file), we propose that by convention, the following files be placed in the following paths and referenced in the `manifest.xml` using the following `item-type`.

| Item                     | Folder      | `item-type`            |
|--------------------------|-------------|------------------------|
| Notebook (.`ipynb` file) | `notebooks` | `notebook`             |
| REES compliant folder    | `sources`   | `notebook-environment` |

## Sample MECA Zip Contents

The following table outlines the contents of a sample MECA file for an article.

| File Name                                       | File Type                      |
|---------------------------------------|---------------------------------|
| `123e4567-e89b-12d3-a456-426655440000-MECA.zip` | Archive file                   |
| `manifest.xml`                                  | Manifest metadata file         |
| `demoarticle.xml`                               | Article metadata file          |
| `demoarticle_files/fig-jats/plot.jpg`           | File uploaded by author        |
| `demoarticle_files/fig-jats/plto2.jpg`          | File uploaded by author        |
| `demoarticle.pdf`                               | System file                    |
| `notebooks/source.ipynb`                        | Notebook file (source of plot) |
| `notebooks/article.ipynb`                       | Notebook file (document)       |
| `source/requirements.txt`                       | REES compliant folder          |
