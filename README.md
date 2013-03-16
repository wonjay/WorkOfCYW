陈延伟教授作业。

MATLAB

作业要求：给定一张 480 * 610 的图片 Classification.png。图中有5类物体，分别为海、树林、绿地、公路及沙地。先手工在每类中随机选取10个样本点，再遍历图中每个像素点，将其与每类中心点的最小欧式距离及最小马氏距离算出，以此将图片分类。

结果：ClassificationTest.m 为作业源码，文件 MahalanobisDistance Result.jpg 与 EuclideanDistance Result.jpg 分别为用最小马氏距离及最小欧式距离得出的分类结果图。详细生成见代码注释。白色区域为海，黑色区域为树林，红色区域为公路，绿色区域为绿地，蓝色区域为沙地。

Existed Issue: 由于在计算马氏距离时，没有估算M_dist 的数量级（见代码 Line 115），期间导致数量级太大使计算失去精准度，故在 Debug 模式下查出数量级后将 M_dist 缩小了 ##10^7 倍.
