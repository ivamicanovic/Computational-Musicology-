---
  title: "Bikeshare"
output: 
  flexdashboard::flex_dashboard
---
  
  ```{r setup, include=FALSE}
library(flexdashboard)
library(readr)
library(ggplot2)
library(dplyr)
library(lubridate)
```

```{r load_data, include = FALSE}
trips_df <- read_csv('https://assets.datacamp.com/production/course_5875/datasets/sanfran_bikeshare_joined_oneday.csv')
```

```{r plot1}

trips_df %>%
  mutate(Hour = hour(start_date)) %>%
  group_by(Hour) %>%
  summarize(`Trips Started` = n()) %>%
  ggplot(aes(x = Hour, y = `Trips Started`)) +
  theme_bw() +
  geom_bar(stat = 'identity')

```

Column
-----------------------------------------------------------------------
  
  ### Chart A
  
  ```{r}

```

Column
-----------------------------------------------------------------------
  
  ### Chart B
  
  ```{r}

```

### Chart C

```{r}

```