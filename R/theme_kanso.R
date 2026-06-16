#' 簡素な ggplot2 テーマ
#'
#' `theme_minimal()` を拡張した、論文・印刷向けの簡素なテーマ。
#' 過去の論文図のスタイル（薄いグリッド、コンパクトな凡例、太字のパネルラベル）
#' を踏まえている。
#'
#' @details
#' `patchwork::plot_annotation(tag_levels = "A")` でパネルラベルを付けると、
#' 太字・左上に配置される。
#'
#' @param base_size 基準フォントサイズ（pt）。
#' @param base_family 基準フォントファミリ。既定はシステム既定のサンセリフ（`""`）。
#'
#' @return ggplot2 のテーマオブジェクト。
#' @import ggplot2
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg, colour = factor(cyl))) +
#'   geom_point() +
#'   theme_kanso()
theme_kanso <- function(base_size = 11, base_family = "") {
  half <- base_size / 2
  theme_minimal(base_size = base_size, base_family = base_family) %+replace%
    theme(
      # グリッド: minor を消し major を薄く
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(linewidth = 0.3, colour = "grey90"),

      # タイトル: 太字・左寄せ・黒・心持ち大きく
      plot.title    = element_text(face = "bold", hjust = 0, colour = "black",
                                   size = rel(1.05), margin = margin(b = half)),
      plot.subtitle = element_text(hjust = 0, margin = margin(b = half)),

      # 軸タイトル: 太字（urbnthemes の print スタイルに倣う）
      axis.title = element_text(face = "bold", colour = "grey30"),

      # 凡例: 右・コンパクト（論文向け）。タイトルは軸タイトルと同じ体裁に揃える
      legend.position = "right",
      legend.title    = element_text(face = "bold", colour = "grey30"),
      legend.key.size = unit(base_size, "pt"),
      legend.text     = element_text(size = rel(0.9)),

      # ファセット見出し: 太字
      strip.text = element_text(face = "bold"),

      # パネルラベル（patchwork の tag_levels）: 太字・左上
      plot.tag          = element_text(face = "bold", hjust = 0, vjust = 1),
      plot.tag.position = c(0, 1),

      complete = TRUE
    )
}
