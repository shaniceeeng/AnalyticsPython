movies <- read.csv(file.choose())
head(movies)
colnames(movies) <- c("Film", "Genre", "CriticRatings", "AudienceRatings", "Budget", "Year")
head(movies)
str(movies)
movies$film <- as.factor(movies$Film)
movies$Genre <- as.factor(movies$Genre)
movies$year <- as.factor(movies$Year)
str(movies)
head(movies)
movies$film <- NULL
movies$Film <- as.factor(movies$Film)
str(movies)

"#------------------- Asethetics!------------------"
library(ggplot2)
ggplot(data=movies, aes(x=CriticRatings, y=AudienceRatings, 
                        colour=Genre, size=Budget)) + geom_point()
#aes stands for asethetics, point stands for scatter plot

p <- ggplot(data=movies, aes(x=CriticRatings, y=AudienceRatings, 
                             colour=Genre, size=Budget)) + geom_point()
#can assign a variable to it to save time
p + geom_line() #change it to a line graph
p + geom_line() + geom_point() #multiple layers whichever is typed first will be placed below

"----------------#Overriding Asethetics!---------------"
q <- ggplot(data=movies, aes(x=CriticRatings, y=AudienceRatings, colour=Genre, size=Budget))
q + geom_point() #to override asethics, write code inside bracket
q + geom_point(aes(size=CriticRatings))
q + geom_point(aes(colour=Budget)) +
xlab("Budget in Millions") #to change the axis title ylab for y-axis
q + geom_line(size=1) + geom_point() #change the thickness of the line
q + geom_point(aes(x=Budget)) + xlab("Budget in Millions")

"---------------- #Mapping vs Setting!---------------"
r = ggplot(data=movies, aes(x=CriticRatings, y=AudienceRatings))
r + geom_point()
r + geom_point(aes(colour=Genre)) #what we done so far aka mapping
r + geom_point(colour="Dark Green") #this is called a setting
#cant type aes as r will recongise it as a legend instead
#error r + geom_point(aes(colour="Dark Green")) 

"---------------- #Histrograms & Density Charts (Area) ---------------"
s <- ggplot(data=movies, aes(x=Budget))
s + geom_histogram(binwidth=10) #thickness of the histograms
s + geom_histogram(binwidth=10, aes(fill=Genre)) #colour of the charts
s + geom_histogram(binwidth=10, aes(fill=Genre), colour="Black") #lines in the graph
s + geom_density() #area chart
s + geom_density(aes(fill=Genre)) #overlapped with one another
s +geom_density(aes(fill=Genre), position="Stack") #stack ontop of one another
t <- ggplot(data=movies, aes(x=AudienceRatings))
t + geom_histogram(binwidth = 10, fill="White", colour="Blue")
#could also write like t <- ggplot(data=movies) so dont have to keep retype everything

"---------------------- #Geom Smooth --------------------"
u <- ggplot(data=movies, aes(x=CriticRatings, y=AudienceRatings, colour=Genre))
u + geom_point() + geom_smooth() #geomsmooth tries to find the trend line but its messy
u + geom_point() + geom_smooth(fill=NA) #removing the grey area makes it neater
#boxplots line is q1 and q3, middle line is median, max and min at the ends
#the longer the box the more flexible/less risky it is
v <- ggplot(data=movies, aes(x=Genre, y=AudienceRatings, colour=Genre))
v + geom_boxplot() 
v + geom_boxplot(size=1.2) + geom_point() #looks weird cause its trying to fit the box
v + geom_boxplot(size=1.2) + geom_jitter() #plot by point to find outlier and stuff
v + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5) #change transparency of box

w <- ggplot(data=movies) #type like this 
w + aes(x=Genre, y=CriticRatings, Colour=Genre) + geom_boxplot()
w + aes(x=Genre, y=CriticRatings, colour=Genre) + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)

"--------------- #Using Facets(creating lots of charts apparently---------------"
w + aes(x=Budget) + geom_histogram(binwidth=10, aes(fill=Genre), colour="Black")
w + aes(x=Budget) + geom_histogram(binwidth=10, aes(fill=Genre), colour="Black") +
  facet_grid(Genre~.) #.~ = column, ~. = rows
w + aes(x=Budget) + geom_histogram(binwidth=10, aes(fill=Genre), colour="Black") +
  facet_grid(Genre~., scale="free") #every graph uses its own y-axis labels
#if dont mention, r finds the one that fits all which is misleading

w + aes(x=CriticRatings, y=AudienceRatings, colour=Genre) + geom_point()
w + aes(x=CriticRatings, y=AudienceRatings, colour=Genre) + geom_point() +
  facet_grid(Genre~.)
w + aes(x=CriticRatings, y=AudienceRatings, colour=Genre) + geom_point() +
  facet_grid(.~Year) #column charts now
w + aes(x=CriticRatings, y=AudienceRatings, colour=Genre) + geom_point() +
  facet_grid(Genre~Year) #both tgt makes many charts

w + aes(x=CriticRatings, y=AudienceRatings, colour=Genre) + geom_point(aes(size=Budget)) +
  facet_grid(Genre~Year) + geom_smooth(fill=NA) #adding many crap tgt

"--------------- #cOORDINATES ---------------"
w + aes(x=CriticRatings, y=AudienceRatings, size=Budget, colour=Genre) + geom_point()
x <- w + aes(x=CriticRatings, y=AudienceRatings, size=Budget, colour=Genre)
x + geom_point() + xlim(50,100) #changing the x-axis but might be misleading cause
#r sees it as zooming in which stretch the grahs making them not accurate
#the proper way:
y <- ggplot(data=movies, aes(x=Budget))
y + geom_histogram(binwidth=10, aes(fill=Genre), colour="Black") + 
  coord_cartesian(ylim=c(0,50)) #use of coord_cartesian clause 

w + aes(x=CriticRatings, y=AudienceRatings, colour=Genre) + geom_point(aes(size=Budget)) +
  facet_grid(Genre~Year) + geom_smooth() + coord_cartesian(ylim=c(0,100))

"--------------- #ADDING THEMES ---------------"
z <- ggplot(data=movies, aes(x=Budget))
a <- z + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")
a + xlab("Money Axis") + ylab("Number of Movies") #changing name of axis

a + ylab("Number of Movies") + xlab("Money Axis") + ggtitle("Movie Budget Distribution") +
  theme(axis.title.x = element_text(colour="DarkGreen", size=10),
        axis.title.y = element_text(colour="Red", size=10),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=10),
        legend.title = element_text(size=10),
        legend.text = element_text(size=10),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        plot.title = element_text(colour="DarkBlue", size=30, family="Times New Roman"))

