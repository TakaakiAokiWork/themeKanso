#' 地図（geom_sf）向けの簡素な ggplot2 テーマ
#'
#' [theme_kanso()] を地図描画向けに調整したテーマ。太字タイトル・コンパクトな
#' 凡例・太字の strip といった体裁は引き継ぎつつ、緯度経度の軸テキスト・軸タイトル・
#' 目盛と経緯線（graticule）を取り除き、真っ白な背景にする。
#' `geom_sf()` / `coord_sf()` を使った地図に用いる。
#'
#' @details
#' スケールバーや北矢印が必要な場合は、別途 \pkg{ggspatial} の
#' `annotation_scale()` / `annotation_north_arrow()` を足す。
#'
#' @inheritParams theme_kanso
#'
#' @return ggplot2 のテーマオブジェクト。
#' @import ggplot2
#' @export
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' nc <- sf::st_read(system.file("shape/nc.shp", package = "sf"))
#' ggplot(nc) +
#'   geom_sf(aes(fill = AREA), colour = "white", linewidth = 0.1) +
#'   scale_fill_viridis_c() +
#'   labs(title = "North Carolina", fill = "Area") +
#'   theme_kanso_map()
#' }
theme_kanso_map <- function(base_size = 11, base_family = "") {
  theme_kanso(base_size = base_size, base_family = base_family) %+replace%
    theme(
      # 経緯線・パネル背景・枠を除去（真っ白な地図背景）
      panel.grid       = element_blank(),
      panel.background = element_blank(),
      panel.border     = element_blank(),

      # 緯度経度の軸まわりを一切表示しない
      axis.text  = element_blank(),
      axis.title = element_blank(),
      axis.ticks = element_blank(),

      # 余白はコンパクトに（過去作例の plot.margin に倣う）
      plot.margin = margin(t = 2, r = 2, b = 2, l = 2),

      complete = TRUE
    )
}
