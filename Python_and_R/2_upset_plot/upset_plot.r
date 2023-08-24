library(ggplot2)
library(ComplexUpset)

# a utiliser dans RStudio
lt <- read.csv(file="C:/Users/boutroux/Documents/integration_souches_08_2023/data_upset.csv", sep=',', quote='', header=TRUE, check.names=FALSE)
print(colnames(lt))

upset(lt, colnames(lt), name='Group', width_ratio=0.2, sort_sets=FALSE, min_size=20, min_degree=2, mode='intersect',
      base_annotations=list(
        'Intersection size'=
            intersection_size(
              mode= 'intersect',
              mapping=aes(width=0.8),
              counts=FALSE
              #text=list(
              #vjust=0.3,
              #hjust=-0.1,
              #angle=90,
              #size=2,
              #check_overlap=TRUE
              #)
            )+theme(panel.grid.major.x = element_blank())
      ),
      set_sizes=upset_set_size()
        + theme(axis.text.x=element_text(angle=90), panel.grid=element_blank())
        + geom_bar(fill='blue', width=0.8)
        + geom_text(aes(label=..count..), hjust=1.1, stat='count', size=3),
      matrix=(
        intersection_matrix(
          geom=geom_point(
            size=2
          ),
          segment=geom_segment(
            size=0.5
          )
        )
      )
)+theme(panel.grid=element_blank())+patchwork::plot_layout(heights=c(0.9, 0.9))

