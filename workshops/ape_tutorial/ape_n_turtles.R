library('ape')

# generate a tree
tree <- rtree(n=10)
class(tree)

# tip labels
sp_names <- rep("species",20)

str(tree)
tree$tip.label
length(tree$tip.label)
Ntip(tree)
Nnode(tree)
Nedge(tree)

mtrees<-rmtree(N=3,n=20) # generate a multiphylo object w/ 3 trees
plot(mtrees)

# Setting graphical parameters and display
par(mar=c(1,1,1,1),mfcol=c(1,1))
?par # all infos. As always, google for examples if you're not sure.
# Using layout
display<-matrix(data = c(1,1,1,2,2, # first row
                         1,1,1,2,2, # 2nd row
                         1,1,1,3,3), # third row 
                nrow = 3,ncol = 5, byrow = T)
display # the matrix assigns each plot to a number of cells it will fill
layout(mat = display)

# an example to plot 3 random trees
plot(rtree(n=100))
plot(rtree(n=20))
plot(rtree(n=5))
# neat.

# reset to the default layout manually
layout(matrix(1,1,1)) # a 1x1 matrix with value 1


# Plot a tree
plot.phylo(tree)
plot(tree)
plot(tree, show.tip.label = F, type='fan')
plot(tree, show.tip.label = T, type = 'phylogram',
     edge.color = c('red','blue'),
     edge.lty = c(2),
     edge.width = c(2),
     align.tip.label = T)

# Show labels
tiplabels()
edgelabels()
nodelabels()

# Read an input tree from a string
newick_tree <- "((((A,B), C), (D,E)),F);"
lil_tree <- read.tree(text = newick_tree)
plot(lil_tree)

rd_tree<-read.tree(text = "((raccoon:19.19959,bear:6.80041):0.84600,((sea_lion:11.99700, seal:12.00300):7.52973,((monkey:100.85930,cat:47.14069):20.59201, weasel:18.87953):2.09460):3.87382,dog:25.46154);
 ")
plot(rd_tree)

# Read an input tree from a file
getwd()
list.files()
lil_tree <- read.tree(file = "input_tree.txt")
plot(lil_tree)
write.tree(lil_tree,file = "input_tree_copy.txt")

# An actual tree
turtle_tree<-read.tree(file = "Turtles J2011.tre")
plot(turtle_tree)
plot(turtle_tree,show.tip.label = F)

turtle_tree$tip.label

# cryptodira
nodelabels()
pleurodira_tree<-extract.clade(turtle_tree, node=235)
plot(pleurodira_tree,show.tip.label = F)
write.tree(pleurodira_tree,file = "pleuro_tree.tre")
save(pleurodira_tree,file = "pleurodira_phylo.Rdata")
saveRDS(pleurodira_tree,file = "pleurodira_phylo.rds")

# Cuora tree, tips 127:135
turtle_tree$tip.label
cuora_tree<-drop.tip(turtle_tree,tip = c(1:126,137:length(turtle_tree$tip.label)))
cuora_tree$tip.label
plot(cuora_tree)

cuora_names<-cuora_tree$tip.label
pruned.tree<-drop.tip(turtle_tree,turtle_tree$tip.label[-match(cuora_names, turtle_tree$tip.label)])
plot(pruned.tree)

# ltt plots
ltt.plot(turtle_tree)
tmnt_list<-list(turtle_tree,pleurodira_tree)
names(tmnt_list)<-c("testudines","pleurodira")
class(tmnt_list)<-"multiPhylo"
mltt.plot(tmnt_list)

# funky plot by Liam Revell
tr <- read.tree(text = "((Homo,Pan),Gorilla);")
plot(tr)
nodelabels("7.3 Ma", 4, frame = "r", bg = "yellow", adj = 0)
nodelabels("5.4 Ma", 5, frame = "c", bg = "tomato", font = 3)
plot(tr, x.lim = c(-1, 4))
nodelabels(node = 4, pie = matrix(rep(1, 100), 1), cex = 5)
op <- par(fg = "transparent")
nodelabels(node = 5, pie = matrix(rep(1, 100), 1), cex = 5)
par(op)
par(fg='black')

# repeat the turtle things with carnivora
list.files()
carnivora_tree<-read.tree("Carnivora_species.nwk")
plot(carnivora_tree)
carnivora_tree$tip.label
# extract the upper half of the phylogeny (Caniformia)
nodelabels() # I want to extract node 378 and its progeny
caniformia_tree <- extract.clade(carnivora_tree,node = 378)
plot(caniformia_tree)
write.tree(caniformia_tree,file = "caniformia_love.tre")
cat(readLines("caniformia_love.tre"))
# This last line is equivalent to 'cat' in Unix command line, i.e. prints the content of a plaint text file. Quite useful and can be stored.
# For our present concern, note the structure translated in Newick.
save(caniformia_tree,"caniformia_love.Rdata") # also possible for a R usage

# Now I want to get the phylogeny for the Canis genus only
caniformia_tree$tip.label
# canis are tips 13:19
doggos_tree<-drop.tip(caniformia_tree,tip = c(1:12,20:length(caniformia_tree$tip.label)))
doggos_tree$tip.label
plot(doggos_tree)
# a more efficient way if you know the full names by advance, and don't want to scroll through all the tips
doggos_names<-doggos_tree$tip.label
name_matches <- match(doggos_names, carnivora_tree$tip.label)
tips_to_prune<-carnivora_tree$tip.label[-name_matches]
dogs_tree<-drop.tip(carnivora_tree,tips_to_prune)
plot(dogs_tree)

# More info
# http://blog.phytools.org/
# Liam Revell's blog about phytools, another package complementary to ape
# The blog contains an insane number of tricks on how to handle phylogenetic data in R
# https://cran.r-project.org/web/packages/ape/ape.pdf
# The official documentation for ape on CRAN.
?ape



