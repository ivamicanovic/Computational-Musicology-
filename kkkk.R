---
  title: "Test"
output: 
  flexdashboard::flex_dashboard:
  orientation: columns
vertical_layout: fill
---
  
  ```{r setup, include=FALSE}
library(flexdashboard)
  ```

Column {data-width=650}
-----------------------------------------------------------------------
  
  ### Chart A
  
  Commentary 123

```  
sample(10)

```

Column {data-width=350}
-----------------------------------------------------------------------
  
  ### Chart B
  
  ```  
{r}

```

### Chart C

```
{r}

```
