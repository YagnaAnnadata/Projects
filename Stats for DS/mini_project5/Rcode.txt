Data=read.csv("bodytemp-heartrate.csv",header = T)
M=subset(Data,Data$gender == 1)
FM=subset(Data,Data$gender == 2)
boxplot(M$body_temperature,FM$body_temperature, main="boxplots of body tempuratures of Male and Female",names = c("Male","Female"),ylab="Tempurature")
par(mfrow=c(1,2))
qqnorm(M$body_temperature,main="Male Q-Q Plots on Bodytempurature")
qqline(M$body_temperature)
qqnorm(FM$body_temperature,main="Female Q-Q plot on Bodytempurature")
qqline(FM$body_temperature)
t.test(M$body_temperature,FM$body_temperature,alternative = 'two.sided')
boxplot(M$heart_rate,FM$heart_rate,main='Box plot of Male and Female heart rate',names = c("Male","Female"),ylab="Heart_rate")
qqnorm(M$heart_rate,main = "Q-Q plot for Male Heart rate")
qqline(M$heart_rate)
qqnorm(FM$heart_rate,main = "Q-Q plot for Female Heart rate")
qqline(FM$heart_rate)
t.test(M$heart_rate,FM$heart_rate,alternative = 'two.sided')
cor(M$body_temperature,M$heart_rate)
cor(FM$body_temperature,FM$heart_rate)
par(mfrow=c(1,2))
plot(M$heart_rate,M$body_temperature,pch=1,main = 'Scatter plot of Male Body temp and Heart rate')
abline(lm(M$body_temperature~M$heart_rate))
plot(FM$heart_rate,FM$body_temperature,pch=1,main = 'Scatterplot of Female Body temp & Heart rate')
abline(lm(FM$body_temperature~FM$heart_rate))

#question 2--------
Zinterval <- function(n, lambda) {
  x <- rexp(n,lambda)
  LowerBound <- mean(x) - qnorm(0.975) * sd(x) / sqrt(n)
  UpperBound <- mean(x) + qnorm(0.975) * sd(x) / sqrt(n)
  Mean = 1/lambda
  if(UpperBound>Mean & LowerBound<Mean) {
    return (1)
  }
  else {
    return (0)
  }
}
