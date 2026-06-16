# themeKanso

A simple, clean ggplot2 theme. "Kanso" (簡素) means *simplicity*.
`theme_kanso()` extends `theme_minimal()` with reduced margins and grid lines
for an uncluttered look.

## Installation

```r
# from GitHub
remotes::install_github("TakaakiAokiWork/themeKanso")
```

## Usage

```r
library(ggplot2)
library(themeKanso)

ggplot(mtcars, aes(wt, mpg, colour = factor(cyl))) +
  geom_point() +
  labs(title = "themeKanso", subtitle = "Kanso") +
  theme_kanso()
```

`theme_kanso()` takes a base font size and family.

```r
theme_kanso(base_size = 14, base_family = "")
```

### Maps

`theme_kanso_map()` is a variant for `geom_sf()` maps. It inherits the bold
titles, compact legend, and bold strips of `theme_kanso()`, but removes the
latitude/longitude axes, ticks, and graticule and uses a plain white
background. It takes the same `base_size` and `base_family` arguments.

```r
library(sf)

nc <- st_read(system.file("shape/nc.shp", package = "sf"))

ggplot(nc) +
  geom_sf(aes(fill = AREA), colour = "white", linewidth = 0.1) +
  scale_fill_viridis_c() +
  labs(title = "North Carolina", fill = "Area") +
  theme_kanso_map()
```

For scale bars or north arrows, add `ggspatial::annotation_scale()` /
`ggspatial::annotation_north_arrow()` on top.

## Gallery

| | |
|---|---|
| ![Scatter](man/figures/scatter.png) | ![Histogram](man/figures/histogram.png) |
| ![Line](man/figures/line.png) | ![Heatmap](man/figures/heatmap.png) |
| ![Bar](man/figures/bar.png) | ![Boxplot](man/figures/boxplot.png) |
| ![Facet](man/figures/facet.png) | ![Map](man/figures/map.png) |

The gallery uses standard datasets (`iris`, `diamonds`, `txhousing`,
`faithfuld`, `mpg`, plus the `nc` shapefile bundled with [sf](https://r-spatial.github.io/sf/)),
the AAAS palette from [ggsci](https://nanx.me/ggsci/) for discrete scales, and
viridis for the continuous ones. The map uses `theme_kanso_map()` (see above).
Regenerate with:

```r
Rscript data-raw/make_readme_figures.R   # requires ggsci, patchwork, sf
```

### Multi-panel layout

Three panels side by side at A4 text width (16 cm) with
[patchwork](https://patchwork.data-imaginist.com/). The theme renders panel tags
from `plot_annotation(tag_levels = "A")` bold and top-left.

![Patchwork row](man/figures/patchwork_row.png)

## License

MIT License
