1. **impala与hive的区别**


2. **sql的执行顺序**
    > from -> join -> on -> where -> groupby -> having -> select -> distinct -> order -> limit

3. **窗口函数**  
   rank(), denseRank(), rowNumber()  
   rank在遇到相同值时rank相同，但下一个值会累加  
   denseRank（）在遇到相同值时rank也相同，但下一个值不会累加  
   rownumber() 在遇到相同值时仍旧赋予不同的ranking  

4. **case when**  
   sql中的case when用在select语句中，并且可以用 __and__ 和 __or__ 连接多个条件 

5. **如何进行condition count**  
   一般采用sum(case when)或者sum(if())  
s