SPARQL As A Backend For DBI
==========================
[![Travis-CI Build Status](https://travis-ci.org/<USERNAME>/<REPO>.svg?branch=master)](https://travis-ci.org/<USERNAME>/<REPO>)

This package implements R's [DBI](https://github.com/rstats-db/DBI) interface for [SPARQL](https://en.wikipedia.org/wiki/SPARQL). This will lead us to the bright future where we can use SPARQL via dplyr!

## Installation

```r
devtools::install_github("yutannihilation/SPARQLDBI")
```

## Usage

```r
library(SPARQLDBI)

endpoint <- "http://data.e-stat.go.jp/lod/sparql/query"
query <-
  '# 川越市のコード及び改正履歴を調べる
PREFIX rdfs:<http://www.w3.org/2000/01/rdf-schema#>
PREFIX org:<http://www.w3.org/ns/org#>
PREFIX dcterms:<http://purl.org/dc/terms/>
PREFIX sacs:<http://data.e-stat.go.jp/lod/terms/sacs#>
PREFIX sac:<http://data.e-stat.go.jp/lod/sac/>
PREFIX sace:<http://data.e-stat.go.jp/lod/sace/>
PREFIX sacr:<http://data.e-stat.go.jp/lod/sacr/>
select  *
where {
?s rdfs:label "川越市"@ja ;
org:resultedFrom / dcterms:description ?rfc . FILTER(LANG(?rfc)="ja")
}
ORDER BY DESC(?s)'

# Load driver
drv <- SPARQL()

# (Pretend to) create a connection
con <- dbConnect(drv, endpoint)

# Send a query
res <- dbSendQuery(con, query)

# Fetch result
dbFetch(res)
```
