# 一、数据预处理相关知识
1. 监督学习，无监督学习，主动学习，半监督学习的区别有哪些  
   >监督学习会给定标注数据，核心思想是学习输入集与输出集的映射。如果输出是连续的，则回归。如果输出是discrete，则为分类。如果输出是有序，则为标注。  

   >无监督学习不会给定标注数据，核心思想是学习数据的潜在结构。

2. 数据集太小怎么办？
   > generate synthetic data (gans/data augmentations)


3. 数据初步分析怎么做 
   > 清理掉一半或者三分之二的数据都算正常 
   - 列清洗  
      保留null值个数小于列总个数30%的列  
   - 数据类型（data type）转换  
      例如：文本转数字等等
   - 描述性分析  
      describe命令  
      通常可以通过一些最大值和最小值发现明显异常的极端值
   - 可视化分析  
      箱型图(boxplot)，直方图等等

4. 数据清洗怎么做  
   - 列清洗  
      保留null值个数小于列总个数30%的列  
   - 数据类型（data type）转换  
      例如：文本转数字等等
   - 错误数据检测与清理  
      > 1. outliers
      > 2. rule violations  
         functional dependencies
         denial constraints(自行指定规则)  
      > 3. pattern violations  
         语法语义相关
   

5. 为什么对数据取对数  
   > 数据值较大时可以考虑取对数、在数据存在负数时绝对不可以取对数、离散数据不要取对数  
   - 消除异方差(扰动项的方差不全相等)  
   - 对数函数在定义域内单调递增，取对数不会改变数据的相关关系
   - 缩小数据的绝对数值  


6. 如何做数据转换  
- transformation for real value  
![avatar](/machinelearning/normalization.png)

- image transformation
   - downsampling
   - cropping  
- text transformation
   - stemming and lemmatization（语法纠正）
   - tokenization(分词)

7. 特征工程  
   make the input well defined
   - 数据特征处理
   ![avatar](/machinelearning/feature.png)
   - 文本特征处理
      - bag of words
      - word embedding
      - pretrained language models
   - 图片特征处理
      - sift
      - using pre-trained neural networks as fearure extractor



   # 二、决策树  
