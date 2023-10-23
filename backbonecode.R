rm(list=ls(all=T))
#install.packages("EnvStats")
library(EnvStats)
# Backbone code. This model involves the removal of fish from a pond.

#growth parameters 
k=0.251 #growth parameter
sd_k=0.05 #var in K
t0=-0.207 #time at age 0
linf=600 #asymptotic length

#RPS-recruits per spawner
lambda=4
RPS=rpois(1,lambda) #need to work size selective recruitment in here
#vunerability/Mortality
a_NS=0.005 #nearshore capture prob intercept
a_OS=0.0015 #offshore capture prob intercept
M=0.01 #natural M
vr=0.9 #volutary release
PR=0.1+M #post release M
nstates=5
a=c(a_NS,a_OS) #just allows me. to index alpha
#states
# 1.  Not Caught alive
# 2. C+R survivor
# 3. Natural M
# 4. C+R Death
# 5. Harvested

#initalize
n=100
periods=52
age=round(rnormTrunc(n,2,2,2,12)) #inital age
sex=rbinom(n,1,0.5) #0=M 1=F
k_ind=rnormTrunc(n,k,sd_k,0.15,0.35) #var in growth
lgth=linf*(1-exp(-k_ind*(age-t0))) #length from von. berf
beta=runif(n,0,0.03) #ind vuln
sd_beta=0.04
hab=rbinom(n,1,0.5) #habitat 0=NS 1=OS
dat=data.frame(id=1:n,age=age,lgth=lgth,sex=sex+1,k_ind=k_ind,beta=beta,hab=hab+1)
dat
spawners=list(NULL,NULL) #lag spawners by 2 years
for(rep in 3:100){ #100 years, starting at. 3 works out a bug. need to think about that
BPM=array(NA,dim=c(nrow(dat),periods,nstates,nstates)) #transition prob
for(i in 1:nrow(dat)){
  for(t in 1:periods){ #dont need t now, give. me. the option to add time varyin. params later
    BPM[i,t,,]<-matrix(c(
      (1-M)*(1-(a[dat$hab[i]]+dat$beta[i])),(a[dat$hab[i]]+dat$beta[i])*vr*(1-PR),
      M*(1-(a[dat$hab[i]]+dat$beta[i])),(a[dat$hab[i]]+dat$beta[i])*vr*PR,(a[dat$hab[i]]+dat$beta[i])*(1-vr),
      (1-M)*(1-(a[dat$hab[i]]+dat$beta[i])),(a[dat$hab[i]]+dat$beta[i])*vr*(1-PR),
      M*(1-(a[dat$hab[i]]+dat$beta[i])),(a[dat$hab[i]]+dat$beta[i])*vr*PR,(a[dat$hab[i]]+dat$beta[i])*(1-vr),
      0,0,1,0,0,
      0,0,0,1,0,
      0,0,0,0,1                                                 
    ),nrow=nstates,byrow=T)
  }
}
z=matrix(NA,nrow(dat),periods)
z[,1]=1
# propagate process via pre defined transitions
for(i in 1:nrow(dat)){
  for(t in 2:periods){
    departure.state=z[i,t-1]
    arrival.state=which(rmultinom(1,1,BPM[i,t-1,departure.state,])==1)
    z[i,t]<-arrival.state
  }
}


survivors=dat[z[,52]<3,]
survivorsf=survivors[survivors$sex==1,]
survivorsm=survivors[survivors$sex==2,]

#have survivors reproduce
pairs=min(nrow(survivorsf),nrow(survivorsm))
mates_f=sample(survivorsf$id,pairs)
mates_m=sample(survivorsm$id,pairs)


tdat=dat[z[,52]<3,] #remove dead fish
tdat$id=1:nrow(tdat)
tdat

#containers
recruits=data.frame(id=0,age=0,lgth=0,sex=0,k_ind=0,beta=0,hab=0)
recruits
id=NULL
age=NULL
k_ind=NULL
lgth=NULL
sex=NULL
hab=NULL
mean_p_beta=NULL
beta=NULL

for(p in 1:pairs){
  Rec=rpois(1,lambda)
  for(r in 1:Rec){
    age=c(age,2)
    k=rnormTrunc(1,k,sd_k,0.15,0.35)
    k_ind=c(k_ind,k)
    lgth=c(lgth,linf*(1-exp(-k*(2-t0))))
    sex=c(sex,rbinom(1,1,0.5)+1)
    hab=c(hab,rbinom(1,1,0.5)+1)
    mean_p_beta=mean(dat$beta[dat$id==mates_f[p]],dat$beta[dat$id==mates_m[p]])
    beta=c(beta,rnormTrunc(1,mean_p_beta,sd=sd_beta,min=0,max=1))
    recruits=data.frame(id=(1:length(age)),age=age,lgth=lgth,sex=sex,k_ind=k_ind,beta=beta,hab=hab)
    #should an spawning prob and stochastisity
  }
}
spawners=c(spawners,list(recruits))
#r=c(r,list(recruits))
#recruits$id=recruits$id+nrow(tdat)
#caught up on way to lag recruits, need to think that through....
thisyearspawners=spawners[rep-2] # I think this will work
thisyearspawners
dat=rbind(tdat,thisyearspawners[[1]])
dat$id=1:nrow(dat)
#need to save catch,  mean vuln etc. but right now process is working,  sorta.  I think there is a bug somewhere
}
dat
#would like. to work in density dependent reproduction, mortality etc.  That stuff hasnt really been. quantified so I may have to just make some. stuff up. This isnt for my thesis work, so having a model that isn't 100% backed by literature is okay, at least for me