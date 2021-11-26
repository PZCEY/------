1. impala与hive的区别


2. sql的执行顺序
    > from -> join -> on -> where -> groupby -> having -> select -> distinct -> order -> limit

3. 窗口函数  
   rank(), denseRank(), rowNumber()  
   rank在遇到相同值时rank相同，但下一个值会累加  
   denseRank（）在遇到相同值时rank也相同，但下一个值不会累加  
   rownumber() 在遇到相同值时仍旧赋予不同的ranking  

